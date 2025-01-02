<?php

namespace App\Http\Controllers;

use App\Models\Delivery;
use App\Models\Order;
use App\Models\Plant;
use App\Models\User;
use App\Models\Product;
use App\Models\OrderDetailModel;
use App\Models\WiringDetail;
use App\Models\PipingDetail;
use App\Models\GardeningDetail;
use App\Models\RunnerDetail;
use Illuminate\Support\Facades\Session;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Input;
use Illuminate\Support\Facades\Validator;
use function PHPUnit\Framework\isNull;

class DeliveryController extends Controller
{
    public function index()
    {
        $delivery = Delivery::orderBy('created_at', 'desc')->paginate(10);
        return view('delivery.delivery')->with('delivery', $delivery);
    }

    public function search(Request $request)
    {
        $query = $request->name;
        $delivery = Delivery::where("order_id", '=', "$query")
            ->paginate(10);
        $delivery->appends(array(
            'keyword' => $query
        ));
        return view('delivery.delivery')
            ->with('delivery', $delivery);
    }

    public function detail($id)
    {
        $delivery = Delivery::where('id', $id)->get();
        $orders = Order::where('id', $delivery[0]->order_id)->first();
        $order = Order::where('id', $delivery[0]->order_id)->get();
        $order_item = OrderDetailModel::where('order_id', $orders->id)
            ->where('delivery_id', $delivery[0]->id)
            ->get();
        // dd($order_item);
        // $delivery_total_price = 0;
        // foreach ($order_item as $item) {
        //     $delivery_total_price += $item->amount;
        // }
        $user = User::where('id',  $orders->user_id)->get();

        $item_detail = [
            'plant' => [],
            'product' => [],
            'wiring' => [],
            'piping' => [],
            'gardening' => [],
            'runner' => [],
        ];
        
        foreach ($order_item as $item) {
            if (!is_null($item->plant_id)) {
                $plant = Plant::leftjoin('category', 'category.id', 'plant.cat_id')
                    ->where('plant.id',  $item->plant_id)
                    ->select('plant.*', 'category.name as category_name', 'plant.image as image')
                    ->first();
                $item_detail['plant'][] = $plant;
            } else if (!is_null($item->product_id)){
                $product = Product::where('product.id', $item->product_id)
                    ->where('product.status', '1')
                    ->first();
                $item_detail['product'][] = $product;
          
                if(!is_null($item->wiring_id)) {
                    $wiringDetails = WiringDetail::where('id', $item->wiring_id)
                        ->first();
                    $item_detail['wiring'][] = $wiringDetails;
                } elseif (!is_null($item->piping_id)) {
                    $pipingDetails = PipingDetail::where('id', $item->piping_id)
                        ->first();
                    $item_detail['piping'][] = $pipingDetails;
                } elseif (!is_null($item->gardening_id)) {
                    $gardeningDetails = GardeningDetail::where('id', $item->gardening_id)
                        ->first();
                    $item_detail['gardening'][] = $gardeningDetails;
                } elseif (!is_null($item->runner_id)) {
                    $runnerDetails = RunnerDetail::where('id', $item->runner_id)
                        ->first();
                    $item_detail['runner'][] = $runnerDetails;
                }
            }
        }

        return view('delivery.sub_screen.edit_delivery_screen')
            ->with('order_item', $order_item)
            ->with('orders', $order)
            ->with('user', $user)
            ->with('item_detail', $item_detail)
            //->with('delivery_total_price', $delivery_total_price)
            ->with('deliver', $delivery);
    }

    public function updateDelivery(Request $request)
    {
        $items = $request->items;
        $order = Order::where('id', $request->order_id)->first();

        // Create new delivery for new item
        if ($items != null) {
            // Create New Delivery
            $delivery = Delivery::create([
                'order_id' => $request->order_id,
                'user_id' => $order->user_id,
                'status' => 'confirm',
                'tracking_number' => $request->track_num,
                'method' => $request->method,
                //'expected_date' => $request->expected_date
            ]);

            $order->status = 'confirm';
            $order->save();

            $delivery->save();

            $order_items = OrderDetailModel::where('order_id', $request->order_id)->get();

            foreach ($order_items as $order_item){
                $order_item->update([
                    'remark' => true,
                    'delivery_id' => $delivery->id
                ]);
            }

            Session::flash('success', "Delivery updated successfully!!");
            return redirect()->route('delivery.index');
        }

        // Delivery arrived
        if ($request->status == 'confirm') {

            // Get delivery
            $delivery = Delivery::where('id', $request->id)->first();
            
            if($request->hasFile('image_proof')){            

                // Get delivery image prove
                $old_path = public_path('delivery_prove/' . $delivery->prv_img);
                if (File::exists($old_path)) {
                    if ($delivery->prv_img != 'no_delivery.png') {
                        File::delete($old_path);
                    }
                }
                $imageName = time() . '.' . $request->file('image_proof')->getClientOriginalExtension();
                $request->file('image_proof')->move(public_path('/delivery_prove'), $imageName);

                // Update delivery
                $delivery->prv_img = $imageName;                
            }

            $order->status = 'completed';
            $order->save();
        
            $delivery->status = 'Completed';
            $delivery->save();

            Session::flash('success', "Delivery updated successfully!!");
            return redirect()->route('delivery.index');
        }
    }
}
