<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Cart;
use App\Models\Plant;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rules;
use Carbon\Carbon;

class CartApiController extends Controller
{
    public function show(Request $request)
    {
        $cart = Cart::where('user_id', Auth::id())
            ->where('is_purchase', "false");

        $ret = [];

        // If result is impty, return fail
        // if ($cart->count() == 0) {
        //     return $this->success($ret);
        // }

        $ret['cart'] = [];
        $ret['plant'] = [];
        $ret['product'] = [];

        // Sort By 
        if ($request->sortBy && in_array(
            $request->sortBy,
            [
                'id', 'created_at', 'updated_at'
            ]
        )) {
            $sortBy = $request->sortBy;
        } else {
            $sortBy = 'updated_at';
        }

        if ($request->sortOrder && in_array(
            $request->sortOrder,
            [
                'asc', 'desc'
            ]
        )) {
            $sortOrder = $request->sortOrder;
        } else {
            $sortOrder = 'desc';
        }

        if ($request->limit) {
            $limit = $request->limit;
        } else {
            $limit = 5;
        }

        $cart = $cart->orderBy(
            $sortBy,
            $sortOrder
        )->paginate($limit);

        $cart_item = $cart;
        foreach ($cart_item as $carts) {
            // Get related information
            if (!is_null($carts->plant_id)) {
                $plant = Plant::leftjoin('category', 'category.id', 'plant.cat_id')
                    ->where('plant.id', $carts->plant_id)
                    ->where('plant.status', '1')
                    ->where('plant.quantity', '>', '0')
                    ->select('plant.*', 'category.name as category_name', 'plant.image as image')
                    ->first();
                $ret['plant'][] = $plant;
            } else if (!is_null($carts->product_id)) {
                $product = Product::leftjoin('category', 'category.id', 'product.cat_id')
                    ->where('product.id', $carts->product_id)
                    ->where('product.status', '1')
                    ->where('product.quantity', '>', '0')
                    ->select('product.*', 'category.name as category_name', 'product.image as image')
                    ->first();
                $ret['product'][] = $product;
            }
        }

        $ret['cart'] = $cart;

        return $this->success(
            $ret
        );
    }

    // Add and update
    public function add(Request $request)
    {
        // If null, return
        $ret = [];

        if (
            ($request->plantID == null &&
                $request->productID == null)
        ) {
            return $this->fail('Invalid request');
        }

        // Check plant
        if ($request->plantID != "null") {
            $plant = Plant::find($request->plantID);
            if ($plant->quantity == 0) {
                return $this->fail('Plant out of stock');
            }
            $request->validate([
                'plantID' => ['required', 'string', 'max:255'],
                'quantity' => 'required|numeric|min:1|max:' . $plant->quantity,
            ]);
            // Debug Print
            // $ret['plant'] = $plant;
        }

        if ($request->productID != "null") {
            $product = Product::find($request->productID);
            if ($product->quantity == 0) {
                return $this->fail('Product out of stock');
            }
            $request->validate([
                'productID' => ['required', 'string', 'max:255'],
                'quantity' => 'required|numeric|min:1|max:' . $product->quantity,
            ]);
            // Debug Print
            // $ret['product'] = $product;
        }

        // Add to the cart for plant
        if ($request->plantID != "null") {
            if ($request->is_cart == false) {
                $newCart = Cart::create([
                    'quantity' => $request->quantity,
                    'plant_id' => (int)$request->plantID,
                    'user_id' => Auth::id(),
                    'date_added' => Carbon::today(),
                    'is_purchase' => "false",
                    'price' => $plant->price,
                ]);
                // Debug Print
                $ret['return_cart'][] = $newCart;
            } else {
                $cartPlant = Cart::firstOrNew(['plant_id' => $request->plantID, 'user_id' => Auth::id(), 'is_purchase' => "false"]);
                // If cart exists, update quantity
                if ($cartPlant->exists) {
                    // Validate cart item and their quantity
                    if ($cartPlant->plant_id != null) {
                        $plant = Plant::find($cartPlant->plant_id);
                        if (($cartPlant->quantity + $request->quantity) > $plant->quantity) {
                            return $this->fail('Plant exceed stock');
                        }
                    }
                    // Add quantity based on the old quantity
                    $cartPlant->quantity += $request->quantity;
                    $cartPlant->price = $plant->price;
                    $cartPlant->save();
                    // Debug Print
                    $ret['return_cart'][] = $cartPlant;
                } else {
                    $newCart = Cart::create([
                        'quantity' => $request->quantity,
                        'plant_id' => (int)$request->plantID,
                        'user_id' => Auth::id(),
                        'date_added' => Carbon::today(),
                        'is_purchase' => "false",
                        'price' => $plant->price,
                    ]);
                    // Debug Print
                    $ret['return_cart'][] = $newCart;
                }
            }
        }

        // Add to the cart for product
        if ($request->productID != "null") {
            if ($request->is_cart === false) {
                $newCart = Cart::create([
                    'quantity' => $request->quantity,
                    'product_id' => (int)$request->productID,
                    'user_id' => Auth::id(),
                    'date_added' => Carbon::today(),
                    'is_purchase' => "false",
                    'price' => $product->price,
                ]);
                // Debug Print
                $ret['return_cart'][] = $newCart;
            } else {
                $cart = Cart::firstOrNew(['product_id' => $request->productID, 'user_id' => Auth::id(), 'is_purchase' => "false"]);
                // If cart exists, update quantity
                if ($cart->exists) {
                    // Validate cart item and their quantity
                    if ($cart->product_id != null) {
                        $product = Product::find($cart->product_id);
                        if (($cart->quantity + $request->quantity) > $product->quantity) {
                            return $this->fail('Product exceed stock');
                        }
                    }
                    $cart->quantity += $request->quantity;
                    $cart->price = $product->price;
                    $cart->save();
                    // Debug Print
                    $ret['return_cart'][] = $cart;
                } else {
                    $newCart = Cart::create([
                        'quantity' => $request->quantity,
                        'product_id' => (int)$request->productID,
                        'user_id' => Auth::id(),
                        'date_added' => Carbon::today(),
                        'is_purchase' => "false",
                        'price' => $product->price,
                    ]);
                    // Debug Print
                    $ret['return_cart'][] = $newCart;
                }
            }
        }


        return $this->success($ret);
    }

    public function delete(Request $request)
    {
        //Delete the cart
        $deleteCart = Cart::where('user_id', Auth::id())
            ->where('is_purchase', "false")
            ->where('id', $request->id);
        if ($deleteCart->exists()) {
            $deleteCart->delete();
        } else {
            return $this->fail('Invalid request');
        }
        return $this->success();
    }

    public function update(Request $request)
    {
        // Validate the request
        $request->validate([
            'id' => ['required', 'string', 'max:255'],
            'quantity' => ['required', 'numeric', 'min:1']
        ]);

        // Update the cart
        $updateCart =
            Cart::where('id', $request->id)
            ->where('user_id', Auth::id())
            ->where('is_purchase', "false")
            ->first();

        if (!$updateCart) {
            return $this->fail('Invalid request');
        }

        // Validate cart iem and their quantity
        if ($updateCart->plant_id != null) {
            $plant = Plant::find($updateCart->plant_id);
            if ($plant->quantity < $request->quantity) {
                return $this->fail('Plant exceed stock');
            }
        } else if ($updateCart->product_id != null) {
            $product = Product::find($updateCart->product_id);
            if ($product->quantity < $request->quantity) {
                return $this->fail('Product exceed stock');
            }
        }

        if ($updateCart) {
            // Get related information
            if (!is_null($updateCart->plant_id)) {
                $plant = Plant::find($updateCart->plant_id);
                $price = $plant->price;
            } else if (!is_null($updateCart->product_id)) {
                $product = Product::find($updateCart->product_id);
                $price = $product->price;
            }
            $updateCart->update([
                'quantity' => $request->quantity,
                'price' => $price
            ]);
        } else {
            return $this->fail('Invalid request');
        }

        return $this->success();
    }
}
