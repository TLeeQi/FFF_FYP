<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Cart;
use App\Models\Custom;
use App\Models\Plant;
use App\Models\Product;
use App\Models\Order;
use App\Models\OrderDetailModel;
use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;

class CustomApiController extends Controller
{
    public function index()
    {
        return $this->success();
    }

    public function show()
    {
        $ret['custom'] = Custom::where('status', '1')->get();

        return $this->success(
            $ret,
        );
    }

    public function add(Request $request)
    {
        return $this->success();
    }

    public function order(Request $request)
    {
        // If null, return
        $ret = [];

        // Validate the request input
        $request->validate([
            'cart_list' => ['required', 'array'],
            'cart_list.*.quantity' => ['required', 'integer'],
            'address' => ['required', 'string', 'max:255'],
        ]);

        // Get the cart_list
        $carts = $request->cart_list;
        $address = $request->address;


        $cartList = [];

        foreach ($carts as $cart) {
            if ($cart['plantID'] != "null") {
                $plant = Plant::find($cart['plantID']);

                if ($plant && $plant->exists) {
                    $cartList[] = Cart::create([
                        'quantity' => $cart['quantity'],
                        'plant_id' => (int)$plant->id,
                        'user_id' => Auth::id(),
                        'date_added' => Carbon::today(),
                        'is_purchase' => "true",
                        'price' => $plant->price,
                    ]);
                }
            } else if ($cart['productID'] != "null") {
                $product = Product::find($cart['productID']);

                if ($product && $product->exists) {
                    $cartList[] = Cart::create([
                        'quantity' => $cart['quantity'],
                        'product_id' => (int)$product->id,
                        'user_id' => Auth::id(),
                        'date_added' => Carbon::today(),
                        'is_purchase' => "true",
                        'price' => $product->price,
                    ]);
                }
            } else {
                return $this->fail('Invalid request');
            }
        }

        $total_order_price = 0;

        $order = Order::create([
            'status' =>  $request->status ? $request->status : 'pay',
            'date' => Carbon::now(),
            'total_amount' => $total_order_price,
            'user_id' => Auth::id(),
            'address' => $address,
            'note' => $request->note ? $request->note : "custom",
        ]);

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
}
