<?php

namespace App\Http\Controllers;

use App\Models\Delivery;
use Illuminate\Http\Request;
use App\Models\Order;
use App\Models\Product;
use App\Models\Plant;
use App\Models\OrderDetailModel;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;
use SebastianBergmann\Type\TrueType;

class OrderController extends Controller
{
    /**Order List */
    public function index()
    {
        $order = Order::select(
            "order.*",
        )->orderBy('created_at', 'desc')
            ->paginate(10);
        return view('order.order')->with('orders', $order);
    }

    /**Filter order status*/
    public function filter(Request $request)
    {

        $order = Order::select(
            "order.*",
        )->where('status', $request->status)
            ->orderBy('created_at', 'desc')
            ->paginate(10)->setPath('');

        $order->appends(array(
            'name' => $request->status
        ));
        return view('order.order')->with('orders', $order);
    }

    public function search(Request $request)
    {
        $order = Order::select(
            "order.*",
        )->where('id', $request->id)
            ->orderBy('created_at', 'desc')
            ->paginate(5)->setPath('');
        $order->appends(array(
            'id' => $request->id
        ));
        return view('order.order')->with('orders', $order);
    }

    public function order_detail(Request $request)
    {
        $order = Order::select(
            "order.*",
        )->where('id', $request->id)->get();

        $user = User::where('id', $order[0]->user_id)->get();


        $order_item = OrderDetailModel::where('order_id', $request->id)
            ->orderBy('created_at', 'desc')->get();

        foreach ($order_item as $item) {
            if (!is_null($item->plant_id)) {
                $plant = Plant::leftjoin('category', 'category.id', 'plant.cat_id')
                    ->where('plant.id',  $item->plant_id)
                    ->select('plant.*', 'category.name as category_name', 'plant.image as image')
                    ->first();
                $item_detail['plant'][] = $plant;
            } else if (!is_null($item->product_id)) {
                $product = Product::leftjoin('category', 'category.id', 'product.cat_id')
                    ->where('product.id', $item->product_id)
                    ->select('product.*', 'category.name as category_name', 'product.image as image')
                    ->first();
                $item_detail['product'][] = $product;
            }
        }

        // dd($order);
        // dd($order_item);
        // dd($plant_list);
        // dd($product_list);
        // dd($item_detail);

        return view('order.sub_screen.order_detail')
            ->with('orders', $order)
            ->with('order_item', $order_item)
            ->with('item_detail', $item_detail)
            ->with('user', $user);
    }

    public function showShipOrder($id)
    {
        $orders = Order::where('id', $id)->first();

        $user = User::where('id',  $orders->user_id)->get();

        $order_item = OrderDetailModel::where('order_id', $id)
            ->orderBy('created_at', 'desc')->get();

        foreach ($order_item as $item) {
            if (!is_null($item->plant_id)) {
                $plant = Plant::leftjoin('category', 'category.id', 'plant.cat_id')
                    ->where('plant.id',  $item->plant_id)
                    ->select('plant.*', 'category.name as category_name', 'plant.image as image')
                    ->first();
                $item_detail['plant'][] = $plant;
            } else if (!is_null($item->product_id)) {
                $product = Product::leftjoin('category', 'category.id', 'product.cat_id')
                    ->where('product.id', $item->product_id)
                    ->select('product.*', 'category.name as category_name', 'product.image as image')
                    ->first();
                $item_detail['product'][] = $product;
            }
        }

        $order = Order::where('id', $id)->get();

        return view('order.sub_screen.order_ship')
            ->with('orders', $order)
            ->with('order_item', $order_item)
            ->with('item_detail', $item_detail)
            ->with('user', $user);
    }

    public function showPartialOrder($id)
    {
        $orders = Order::where('id', $id)->first();

        $user = User::where('id',  $orders->user_id)->get();

        // Use to get all the item within a order
        $all_item = OrderDetailModel::where('order_id', $id)
            ->orderBy('created_at', 'desc')
            ->get();

        $isfull = true;

        foreach ($all_item as $item) {
            if ($item->remark != true) {
                $isfull = false;
                break;
            }
        }


        foreach ($all_item as $item) {
            if (!is_null($item->plant_id)) {
                $plant = Plant::leftjoin('category', 'category.id', 'plant.cat_id')
                    ->where('plant.id',  $item->plant_id)
                    ->select('plant.*', 'category.name as category_name', 'plant.image as image')
                    ->first();
                $item_detail['plant'][] = $plant;
            } else if (!is_null($item->product_id)) {
                $product = Product::leftjoin('category', 'category.id', 'product.cat_id')
                    ->where('product.id', $item->product_id)
                    ->select('product.*', 'category.name as category_name', 'product.image as image')
                    ->first();
                $item_detail['product'][] = $product;
            }
        }

        $order = Order::where('id', $id)->get();

        // Completed order item
        // // Delivery List
        // $delivery = Delivery::where('order_id', $id)->get();
        // $delivery_detail = [];

        // Get the order item accoding list
        // foreach ($delivery as $item) {
        //     $order_detail = OrderDetailModel::where('order_id', $id)
        //         ->orderBy('created_at', 'desc')
        //         ->where('delivery_id', $item->id)
        //         ->where('remark', true)
        //         ->get();
        //     $delivery_detail['order_detail'][] = $order_detail;
        // }

        // dd($delivery_detail);

        return view('order.sub_screen.order_partial')
            ->with('orders', $order)
            ->with('order_item', $all_item)
            ->with('item_detail', $item_detail)
            ->with('isfull', $isfull)
            // ->with('delivery_detail', $delivery_detail)
            // ->with('deliver', $delivery)
            // ->with('deliver', $delivery)
            ->with('user', $user);
    }
}
