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
use App\Models\Delivery;
use DateTimeInterface;


class DeliveryApiController extends Controller
{
    public function index(Request $request)
    {
        $deliveries = Delivery::leftjoin('order', 'order.id', 'delivery.order_id')
            ->where("delivery.user_id", Auth::id())
            ->select(
                'delivery.*',
                'order.created_at as order_date',
                'order.address as order_address',
                'order.total_amount as order_total_amount',
            );

        // Search by order_id
        if ($request->order_id) {
            $deliveries = $deliveries->whereHas(
                'order',
                function ($query) use ($request) {
                    $query->where('order.id', $request->order_id);
                }
            );
        }

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
            $limit = 10;
        }

        $deliveries = $deliveries->orderBy($sortBy, $sortOrder)->paginate($limit);

        return $this->success($deliveries);
    }

    public function show(Request $request)
    {
        $delivery = Delivery::leftjoin('order', 'order.id', 'delivery.order_id')
            ->where("delivery.user_id", Auth::id())
            ->where('delivery.id', $request->id)
            ->select(
                'delivery.*',
                'order.created_at as order_date',
                'order.address as order_address',
                'order.total_amount as order_total_amount',
                'delivery.created_at as created_at',
                'delivery.updated_at as updated_at',
            )->first();

        if ($delivery == null) {
            return $this->fail('No delivery found.');
        } else {
        }

        return $this->success($delivery);
    }


    public function receipt(Request $request)
    {
        $id = $request->id;

        $request->validate([
            'id' => 'required|integer|exists:delivery,id',
        ]);
        // Delivery receipt on certain delivery
        $order_detail =
            Delivery::leftjoin('order_detail', 'order_detail.delivery_id', 'delivery.id')
            // ->leftjoin('order', 'order.id', 'order_detail.order_id')
            ->leftjoin('plant', 'plant.id', 'order_detail.plant_id')
            ->leftjoin('product', 'product.id', 'order_detail.product_id')
            ->where('delivery.user_id', Auth::id())
            ->where('delivery.id', $id)
            ->select(
                // 'order.id as order_id',
                // 'order.created_at as order_date',
                // 'order.address as order_address',
                // 'order.status as order_status',
                // 'order.total_amount as order_total_amount',
                'order_detail.*',
                'plant.name as plant_name',
                'plant.price as plant_price',
                'plant.image as plant_image',
                'product.name as product_name',
                'product.price as product_price',
                'product.image as product_image',
            )
            ->get();

        $order = Delivery::leftjoin('order', 'order.id', 'delivery.order_id')
            ->where("delivery.user_id", Auth::id())
            ->where('delivery.id', $id)
            ->select(
                'order.*',
            )->first();

        $sender = [
            "Sender" => "Nursery Garden SDN Berhad",
            "Address" => "Nursery Garden, Pontian Besar, 82000, Pontian, Johor"
        ];

        $delivery = Delivery::where('id', $id)->first();

        $ret['user'] = Auth::user();
        $ret['delivery_order_detail'] = $order_detail;
        $ret['order'] = $order;
        $ret['sender'] = $sender;
        $ret['delivery'] = $delivery;

        return $this->success($ret);
    }
}
