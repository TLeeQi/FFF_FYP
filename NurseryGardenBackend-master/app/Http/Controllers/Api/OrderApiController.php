<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Cart;
use App\Models\Order;
use App\Models\Plant;
use App\Models\Product;
use App\Models\Delivery;
use App\Models\OrderDetailModel;
use App\Models\WiringDetail;
use App\Models\PipingDetail;
use App\Models\GardeningDetail;
use App\Models\RunnerDetail;
use Illuminate\Http\Request;
use App\Models\Address;
use App\Models\Payment;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rules;
use Carbon\Carbon;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;


class OrderApiController extends Controller
{
    public function show(Request $request)
    {
        $query = Order::where('order.user_id', Auth::id());

        // pay/ship/partial/receive/completed/cancel
        if ($request->status != null) {
            $query = $query->where('order.status', $request->status);
        } else {
            return $this->fail('Some error occured.');
        }

        // Sort By 
        $sortBy = in_array($request->sortBy, ['order.id', 'order.created_at', 'order.updated_at'])
            ? $request->sortBy : 'order.created_at';
        $sortOrder = in_array($request->sortOrder, ['asc', 'desc'])
            ? $request->sortOrder : 'desc';
        $limit = $request->limit
            ? $request->limit : 3;

        $orders = $query->orderBy($sortBy, $sortOrder)
            ->paginate($limit);

        $ret['orders'] = $orders;
        return $this->success($ret);
    }

    public function cancel(Request $request)
    {
        $request->validate([
            'id' => 'required|integer|exists:order,id',
        ]);

        $order = Order::where('id', $request->id)->first();

        if ($order->status == 'pay') {
            $order->update([
                'status' => 'cancel'
            ]);
        } else {
            return $this->fail('Some error occured.');
        }

        return $this->success($order);
    }

    public function order_detail(Request $request)
    {
        $query = OrderDetailModel::where('order_id', $request->id);

        // If there are no matching orders, return fail
        if ($query->count() == 0) {
            return $this->fail('No orders yet.');
        }

        // Array to store
        $ret = [];

        // Sort By 
        $sortBy = in_array($request->sortBy, ['id', 'created_at', 'updated_at'])
            ? $request->sortBy : 'created_at';
        $sortOrder = in_array($request->sortOrder, ['asc', 'desc'])
            ? $request->sortOrder : 'asc';

        $order_item = $query->orderBy($sortBy, $sortOrder)->get();

        if ($order_item->count() == 0) {
            return $this->fail('Some error occur, Please try again later.');
        }

        // Log the order items
        \Log::info('Order Items:', $order_item->toArray());

        $wiringArray = [];

        foreach ($order_item as $item) {
            if (!is_null($item->plant_id)) {
                $plant = Plant::leftjoin('category', 'category.id', 'plant.cat_id')
                    ->where('plant.id',  $item->plant_id)
                    ->select('plant.*', 'category.name as category_name', 'plant.image as image')
                    ->first();
                $ret['plant'][] = $plant;
            } else if (!is_null($item->product_id) && is_null($item->wiring_id)) {
                $product = Product::leftjoin('category', 'category.id', 'product.cat_id')
                    ->where('product.id', $item->product_id)
                    ->select('product.*', 'category.name as category_name', 'product.image as image')
                    ->first();
                $ret['product'][] = $product;
            } 
            else if (!is_null($item->wiring_id)) {
                // $wiring = WiringDetail::where('id', $item->wiring_id)->first();
                $wiring = WiringDetail::find($item->wiring_id);
                // Log the wiring details
                \Log::info('Wiring Detail:', $wiring ? $wiring->toArray() : 'No wiring found');

                // Decode and add URLs for wiring photos
                if ($wiring) {
                    $wiringPhotos = $wiring->photo ? json_decode($wiring->photo, true) : [];
                    $wiring->photo_urls = array_map(function ($path) {
                        return asset('storage/' . $path);
                    }, $wiringPhotos);

                    // Add wiring detail to the array
                    $wiringArray[] = $wiring->toArray();

                    $ret['wiring'] = $wiringArray;

                    // Log the wiring details
                    \Log::info('Wiring Detail:', $wiring ? $wiring->toArray() : 'No wiring found');
                    \Log::info('Wiring Array:', $wiringArray);
                    \Log::info('Response Data:', $ret);
                    \Log::info('Order Item Wiring IDs:', $order_item->pluck('wiring_id')->toArray());
                    \Log::info('Final Wiring Data:', $ret['wiring']);
                    
                }else {
                    \Log::warning('No wiring found for ID: '.$item->wiring_id);
                }

            } else if (!is_null($item->product_id) && !is_null($item->piping_id)) {
                $piping = PipingDetail::leftjoin('order_detail', 'order_detail.piping_id', 'piping_detail.id')
                    ->where('piping_detail.id', $item->piping_id)
                    ->select('piping_detail.*')
                    ->first();
                $ret['piping'][] = $piping;
            } else if (!is_null($item->product_id) && !is_null($item->gardening_id)) {
                $gardening = GardeningDetail::leftjoin('order_detail', 'order_detail.gardening_id', 'gardening_detail.id')
                    ->where('gardening_detail.id', $item->gardening_id)
                    ->select('gardening_detail.*')
                    ->first();
                $ret['gardening'][] = $gardening;
            } else if (!is_null($item->product_id) && !is_null($item->runner_id)) {
                $runner = RunnerDetail::leftjoin('order_detail', 'order_detail.runner_id', 'runner_detail.id')
                    ->where('runner_detail.id', $item->runner_id)
                    ->select('runner_detail.*')
                    ->first();
                $ret['runner'][] = $runner;
            }
        }

        $ret['order_item'] = $order_item;

        $delivery = Delivery::where('order_id', $request->id)->get();
        $ret['delivery_list'] = $delivery;
        \Log::info('API Response to Flutter:', $ret);

        return $this->success($ret);
    }

    public function create(Request $request)
    {
        // Validate the request input
        $request->validate([
            'cart_list' => ['required', 'array'],
            'cart_list.*.id' => ['required', 'integer'],
            'cart_list.*.quantity' => ['required', 'integer'],
            'address' => ['required', 'string', 'max:255'],
        ]);

        // Get the cart_list
        $cartValidation = $request->cart_list;

        $cartList = [];

        // Validate either the cart exist or not
        foreach ($cartValidation as $item) {
            // if ($item['id'] != 0) {
            $cartItem = Cart::where('id', $item['id'])
                ->where('is_purchase', "false")
                ->first();
            if (!$cartItem) {
                return $this->fail('Cart ID: ' .  $item['id'] . ' not found');
            } else {
                $cartList[] = $cartItem;
            }
            // } else {
            //     $data = $item;
            // }
        }

        $total_order_price = 0;

        $address = $request->address;

        // Create the order
        $order = Order::create([
            'status' =>  $request->status ? $request->status : 'pay',
            'date' => Carbon::now(),
            'total_amount' => $total_order_price,
            'user_id' => Auth::id(),
            'address' => $address,
            'note' => $request->note ? $request->note : null,
        ]);

        // if ($item['id'] != 0) {
        // Create the order detail
        foreach ($cartList as $item) {
            OrderDetailModel::create([
                'quantity' => $item['quantity'],
                'price' => $item['price'],
                'amount' => $item['price'] * $item['quantity'],
                'order_id' => $order->id,
                'product_id' => $item['product_id'] == null ? null : $item['product_id'],
                'plant_id' => $item['plant_id'] == null ? null : $item['plant_id'],
                'bidding_id' => $item['bidding_id'] == null ? null : $item['bidding_id'],
            ]);

            // Minus the inventory of the product
            if (!is_null($item['plant_id'])) {
                $plant = Plant::where('id', $item['plant_id'])->first();
                $quantity = $item['quantity'];
                $plant->update([
                    'sales_amount' => $plant->sales_amount + $quantity,
                    'quantity' => $plant->quantity - $quantity
                ]);
            } else if (!is_null($item['product_id'])) {
                $product = Product::where('id', $item['product_id'])->first();
                $quantity = $item['quantity'];
                $product->update([
                    'sales_amount' => $product->sales_amount + $quantity,
                    'quantity' => $product->quantity - $quantity
                ]);
            }

            // Get the order price
            $total_order_price += $item['price'] * $item['quantity'];
            // Update the cart item to false
            $item->update([
                'is_purchase' => "true"
            ]);
        }
        // Update order price
        Order::where('id', $order->id)->update([
            'total_amount' => $total_order_price
        ]);

        $ret['order_id'] = $order->id;

        return $this->success($ret);
    }

    public function storeWiringDetail(Request $request)
    {
        \Log::info('Incoming Request Data', $request->all());

        // Extract 'data' from the request
        $total_order_price = 50;

        try{
            // Validate the extracted data
            $validatedData = $request->validate([
                'type' => 'required|string',
                'fixitem' => 'required|array',
                'ishavepart' => 'required|boolean',
                'types_property' => 'required|string',
                'app_date' => 'required|date',
                'preferred_time' => 'required|string',
                'details' => 'nullable|string',
                'photos.*' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
                'budget' => 'required|string',
                'address' => 'required|string',
                'prod_id' => 'required|integer',
            ]);
        
            \Log::info('Validated Data', $validatedData);
        }catch (\Illuminate\Validation\ValidationException $e) {
            Log::error('Validation Failed:', $e->errors());
            return response()->json(['errors' => $e->errors()], 422);
        }  
        // try{
        //     $data = $request->validate([
        //         'type' => 'required|string',
        //         'fixitem' => 'required|array',
        //         'ishavepart' => 'required|boolean',
        //         'types_property' => 'required|string',
        //         'app_date' => 'required|date',
        //         'preferred_time' => 'required|string',
        //         'details' => 'nullable|string',
        //         'photo' => 'nullable|array',
        //         'budget' => 'required|string',
        //         'address' => 'required|string',
        //     ]);
        // }catch (\Illuminate\Validation\ValidationException $e) {
        // Log::error('Validation Failed:', $e->errors());
        //     return response()->json(['errors' => $e->errors()], 422);
        // }   

        // Handle file uploads
        $photoPaths = [];
        if ($request->hasFile('photos')) {
            foreach ($request->file('photos') as $photo) {
                $path = $photo->store('uploads/wiring_photos', 'public'); // Save to storage/app/public/uploads/wiring_photos
                $photoPaths[] = $path;
            }
        }

        // Create the order
        try{
            $order = Order::create([
                // 'status' =>  $requestData->status ? $requestData->status : 'pay',
                'status' => 'pay',
                'date' => Carbon::now(),
                'total_amount' => $total_order_price,
                'user_id' => Auth::id(),
                'address' => $validatedData['address'],
                // 'note' => $requestData->note ? $requestData->note : null,
                'note' => null,
                'price' => $total_order_price,
            ]);
            \Log::info('Order Created', $order->toArray());
        } catch (\Exception $e) {
            \Log::error('Failed to Create Order', ['error' => $e->getMessage()]);
            return response()->json(['error' => 'Failed to create order'], 500);
        }


        // $wiringDetail = WiringDetail::create([
        //     'type' => $data['type'],
        //     'fixitem' => $data['fixitem'],
        //     'ishavepart' => $data['ishavepart'],
        //     'types_property' => $data['types_property'],
        //     'app_date' => $data['app_date'],
        //     'preferred_time' => $data['preferred_time'],
        //     'details' => $data['details'],
        //     'photo' => $data['photo'],
        //     'budget' => $data['budget'],
        // ]);

        try {
            $wiringDetail = WiringDetail::create([
                'type' => $validatedData['type'],
                'fixitem' => $validatedData['fixitem'],
                'ishavepart' => $validatedData['ishavepart'],
                'types_property' => $validatedData['types_property'],
                'app_date' => $validatedData['app_date'],
                'preferred_time' => $validatedData['preferred_time'],
                'details' => $validatedData['details'],
                'photo' => !empty($photoPaths) ? json_encode($photoPaths) : null,
                'budget' => $validatedData['budget'],
                'price' => $total_order_price,
            ]);
    
            \Log::info('Wiring Detail Created', $wiringDetail->toArray());
            \Log::info('Wiring Detail ID', ['id' => $wiringDetail->id]); // Log the ID

        } catch (\Exception $e) {
            \Log::error('Failed to Create Wiring Detail', ['error' => $e->getMessage()]);
            return response()->json(['error' => 'Failed to create wiring detail'], 500);
        }


        try{
            OrderDetailModel::create([
                'quantity' => '1',
                'price' => '50',
                'amount' => '50',
                'order_id' => $order->id,
                'product_id' => $validatedData['prod_id'],
                'plant_id' => null,
                'bidding_id' => null,
                'wiring_id' => $wiringDetail->id, // Use the ID from the created wiring detail
                'piping_id' => null,
                'gardening_id' => null,
                'runner_id' => null,
            ]);

            \Log::info('Order Detail Created');
        } catch (\Exception $e) {
            \Log::error('Failed to Create Order Detail', ['error' => $e->getMessage()]);
            return response()->json(['error' => 'Failed to create order detail'], 500);
        }
    
        // Get the order price
        // $total_order_price += $data['price'] * $data['quantity'];
        // // Update the cart item to false
        // $data->update([
        //             'is_purchase' => "true"
        //     ]);
        // }

        // Update order price
        Order::where('id', $order->id)->update([
            'total_amount' => $total_order_price
        ]);

        $ret['order_id'] = $order->id;

        return $this->success($ret);
    }

    public function storePipingDetail(Request $request)
    {
        \Log::info('Incoming Request Data', $request->all());

        // Extract 'data' from the request
        $total_order_price = 50;

        try{
            // Validate the extracted data
            $validatedData = $request->validate([
                'type' => 'required|string',
                'fixitem' => 'required|array',
                'problem' => 'required|array',
                'types_property' => 'required|string',
                'app_date' => 'required|date',
                'preferred_time' => 'required|string',
                'details' => 'nullable|string',
                'photo' => 'nullable|array',
                'budget' => 'required|string',
                'address' => 'required|string',
            ]);
        
            \Log::info('Validated Data', $validatedData);
        }catch (\Illuminate\Validation\ValidationException $e) {
            Log::error('Validation Failed:', $e->errors());
            return response()->json(['errors' => $e->errors()], 422);
        }  

        // Create the order
        try{
            $order = Order::create([
                // 'status' =>  $requestData->status ? $requestData->status : 'pay',
                'status' => 'pay',
                'date' => Carbon::now(),
                'total_amount' => $total_order_price,
                'user_id' => Auth::id(),
                'address' => $validatedData['address'],
                // 'note' => $requestData->note ? $requestData->note : null,
                'note' => null,
                'price' => $total_order_price,
            ]);
            \Log::info('Order Created', $order->toArray());
        } catch (\Exception $e) {
            \Log::error('Failed to Create Order', ['error' => $e->getMessage()]);
            return response()->json(['error' => 'Failed to create order'], 500);
        }

        try {
            $pipingDetail = PipingDetail::create([
                'type' => $validatedData['type'],
                'fixitem' => $validatedData['fixitem'],
                'problem' => $validatedData['problem'],
                'types_property' => $validatedData['types_property'],
                'app_date' => $validatedData['app_date'],
                'preferred_time' => $validatedData['preferred_time'],
                'details' => $validatedData['details'],
                'photo' => $validatedData['photo'],
                'budget' => $validatedData['budget'],
                'price' => $total_order_price,
            ]);
    
            \Log::info('Piping Detail Created', $pipingDetail->toArray());
        } catch (\Exception $e) {
            \Log::error('Failed to Create Piping Detail', ['error' => $e->getMessage()]);
            return response()->json(['error' => 'Failed to create wiring detail'], 500);
        }


        try{
            OrderDetailModel::create([
                'quantity' => '1',
                'price' => '50',
                'amount' => '50',
                'order_id' => $order->id,
                'product_id' => null,
                'plant_id' => null,
                'bidding_id' => null,
                'wiring_id' => null, // Use the ID from the created wiring detail
                'piping_id' => $pipingDetail->id,
                'gardening_id' => null,
                'runner_id' => null,
            ]);

            \Log::info('Order Detail Created');
        } catch (\Exception $e) {
            \Log::error('Failed to Create Order Detail', ['error' => $e->getMessage()]);
            return response()->json(['error' => 'Failed to create order detail'], 500);
        }
        
        // Update order price
        Order::where('id', $order->id)->update([
            'total_amount' => $total_order_price
        ]);

        $ret['order_id'] = $order->id;

        return $this->success($ret);
    }

    public function storeGardeningDetail(Request $request)
    {
        \Log::info('Incoming Request Data', $request->all());

        // Extract 'data' from the request
        $total_order_price = 50;

        try{
            // Validate the extracted data
            $validatedData = $request->validate([
                'type' => 'required|string',
                'area' => 'required|string',
                'types_property' => 'required|string',
                'app_date' => 'required|date',
                'preferred_time' => 'required|string',
                'details' => 'nullable|string',
                'photo' => 'nullable|array',
                
                'budget' => 'required|string',
                'address' => 'required|string',
            ]);
        
            \Log::info('Validated Data', $validatedData);
        }catch (\Illuminate\Validation\ValidationException $e) {
            Log::error('Validation Failed:', $e->errors());
            return response()->json(['errors' => $e->errors()], 422);
        }  

        // Create the order
        try{
            $order = Order::create([
                // 'status' =>  $requestData->status ? $requestData->status : 'pay',
                'status' => 'pay',
                'date' => Carbon::now(),
                'total_amount' => $total_order_price,
                'user_id' => Auth::id(),
                'address' => $validatedData['address'],
                // 'note' => $requestData->note ? $requestData->note : null,
                'note' => null,
                'price' => $total_order_price,
            ]);
            \Log::info('Order Created', $order->toArray());
        } catch (\Exception $e) {
            \Log::error('Failed to Create Order', ['error' => $e->getMessage()]);
            return response()->json(['error' => 'Failed to create order'], 500);
        }

        try {
            $gardeningDetail = GardeningDetail::create([
                'type' => $validatedData['type'],
                'area' => $validatedData['area'],
                'types_property' => $validatedData['types_property'],
                'app_date' => $validatedData['app_date'],
                'preferred_time' => $validatedData['preferred_time'],
                'details' => $validatedData['details'],
                'photo' => $validatedData['photo'],
                'budget' => $validatedData['budget'],
                'price' => $total_order_price,
            ]);
    
            \Log::info('Gardening Detail Created', $gardeningDetail->toArray());
            \Log::info('Gardening Detail ID', ['id' => $gardeningDetail->id]); // Log the ID

        } catch (\Exception $e) {
            \Log::error('Failed to Create Gardening Detail', ['error' => $e->getMessage()]);
            return response()->json(['error' => 'Failed to create gardening detail'], 500);
        }


        try{
            OrderDetailModel::create([
                'quantity' => '1',
                'price' => '50',
                'amount' => '50',
                'order_id' => $order->id,
                'product_id' => null,
                'plant_id' => null,
                'bidding_id' => null,
                'wiring_id' => null, // Use the ID from the created wiring detail
                'piping_id' => null,
                'gardening_id' => $gardeningDetail->id,
                'runner_id' => null,
            ]);

            \Log::info('Order Detail Created');
        } catch (\Exception $e) {
            \Log::error('Failed to Create Order Detail', ['error' => $e->getMessage()]);
            return response()->json(['error' => 'Failed to create order detail'], 500);
        }

        // Update order price
        Order::where('id', $order->id)->update([
            'total_amount' => $total_order_price
        ]);

        $ret['order_id'] = $order->id;

        return $this->success($ret);
    }

    public function storeRunnerDetail(Request $request)
    {
        \Log::info('Incoming Request Data', $request->all());

        // Extract 'data' from the request
        $total_order_price = 50;

        try{
            // Validate the extracted data
            $validatedData = $request->validate([
                'type' => 'required|string',
                'area' => 'required|string',
                'app_date' => 'required|date',
                'preferred_time' => 'required|string',
                'details' => 'nullable|string',
                'photo' => 'nullable|array',
                'budget' => 'required|string',
                'address' => 'required|string',
            ]);
        
            \Log::info('Validated Data', $validatedData);
        }catch (\Illuminate\Validation\ValidationException $e) {
            Log::error('Validation Failed:', $e->errors());
            return response()->json(['errors' => $e->errors()], 422);
        }  

        // Create the order
        try{
            $order = Order::create([
                // 'status' =>  $requestData->status ? $requestData->status : 'pay',
                'status' => 'pay',
                'date' => Carbon::now(),
                'total_amount' => $total_order_price,
                'user_id' => Auth::id(),
                'address' => $validatedData['address'],
                // 'note' => $requestData->note ? $requestData->note : null,
                'note' => null,
                'price' => $total_order_price,
            ]);
            \Log::info('Order Created', $order->toArray());
        } catch (\Exception $e) {
            \Log::error('Failed to Create Order', ['error' => $e->getMessage()]);
            return response()->json(['error' => 'Failed to create order'], 500);
        }

        try {
            $runnerDetail = RunnerDetail::create([
                'type' => $validatedData['type'],
                'area' => $validatedData['area'],
                'app_date' => $validatedData['app_date'],
                'preferred_time' => $validatedData['preferred_time'],
                'details' => $validatedData['details'],
                'photo' => $validatedData['photo'],
                'budget' => $validatedData['budget'],
                'price' => $total_order_price,
            ]);
    
            \Log::info('Runner Detail Created', $runnerDetail->toArray());
            \Log::info('Runner Detail ID', ['id' => $runnerDetail->id]); // Log the ID

        } catch (\Exception $e) {
            \Log::error('Failed to Create Runner Detail', ['error' => $e->getMessage()]);
            return response()->json(['error' => 'Failed to create runner detail'], 500);
        }


        try{
            OrderDetailModel::create([
                'quantity' => '1',
                'price' => '50',
                'amount' => '50',
                'order_id' => $order->id,
                'product_id' => null,
                'plant_id' => null,
                'bidding_id' => null,
                'wiring_id' => null, // Use the ID from the created wiring detail
                'piping_id' => null,
                'gardening_id' => null,
                'runner_id' => $runnerDetail->id,
            ]);

            \Log::info('Order Detail Created');
        } catch (\Exception $e) {
            \Log::error('Failed to Create Order Detail', ['error' => $e->getMessage()]);
            return response()->json(['error' => 'Failed to create order detail'], 500);
        }

        // Update order price
        Order::where('id', $order->id)->update([
            'total_amount' => $total_order_price
        ]);

        $ret['order_id'] = $order->id;

        return $this->success($ret);
    }

    public function uploadTemporaryPhoto(Request $request)
    {
        $request->validate([
            'photo' => 'required|image|max:2048', // Validate the image file
        ]);

        // Save file in a temporary directory
        $path = $request->file('photo')->store('temp_image', 'public');

        return response()->json([
            'message' => 'Photo uploaded temporarily',
            'temp_photo_url' => Storage::url($path),
            'temp_photo_path' => $path, // This will be sent to Flutter for further reference
        ]);
    }

    public function receipt(Request $request)
    {
        $id = $request->id;

        $request->validate([
            'id' => 'required|integer|exists:order,id',
        ]);

        $order = Order::where('id', $id)->first();

        $order_detail =
            Order::leftjoin('order_detail', 'order_detail.order_id', 'order.id')
            ->leftjoin('plant', 'plant.id', 'order_detail.plant_id')
            ->leftjoin('product', 'product.id', 'order_detail.product_id')
            ->where('order.user_id', Auth::id())
            ->where('order.id', $id)
            ->select(
                'order_detail.*',
                'plant.name as plant_name',
                'plant.price as plant_price',
                'product.name as product_name',
                'product.price as product_price',
            )
            ->get();

        $payment = Payment::select(
            'payment.id',
            'payment.method',
            'payment.status',
            'payment.updated_at',
            'payment.amount',
            'payment.date',
        )
            ->where('order_id', $id)
            ->where('user_id', Auth::id())
            ->first();

        $sender = [
            "Sender" => "Nursery Garden SDN Berhad",
            "Address" => "Nursery Garden, Pontian Besar, 82000, Pontian, Johor"
        ];


        $ret['order'] = $order;
        $ret['order_item'] = $order_detail;
        $ret['payment'] = $payment;
        $ret['sender'] = $sender;
        $ret['user'] = Auth::user();

        return $this->success($ret);
    }

    public function updateOrderAddress(Request $request)
    {
        $request->validate([
            'id' => 'required|integer|exists:order,id',
            'address' => 'required|string|max:255',
        ]);

        $order = Order::find($request->id);

        if (!$order) {
            return $this->fail('Order not found.');
        }

        if ($order->status !== 'ship') {
            return $this->fail('Invalid order status.');
        }

        $order->update([
            'address' => $request->address
        ]);

        return $this->success($order);
    }
}
