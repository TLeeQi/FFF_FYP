<?php

namespace App\Http\Controllers;

use App\Models\WiringDetail;
use App\Models\PipingDetail;
use App\Models\GardeningDetail;
use App\Models\RunnerDetail;
use Illuminate\Http\Request;
use App\Models\Category;
use App\Models\User;
use App\Models\Product;
use App\Models\Plant;
use App\Models\Payment;
use App\Models\Order;
use Illuminate\Support\Facades\Auth;
use App\Models\Vendor;
use Illuminate\Support\Facades\Log;

class HomeController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('auth');
    }

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Contracts\Support\Renderable
     */

    public function home()
    {
        if (!Auth::check()) {
            return redirect()->back();
        }
        if (Auth::user()->type == "admin" || Auth::user()->type == "sadmin") {
            $data = [];
            $data['totalUsers']         = User::where('type', '=', 'user')->count('id');
            $data['totalProducts']      = Product::count('id');
            $data['totalPlants']        = Plant::count('id');
            $data['totalServices']     = Order::where('order.status', 'completed')
                                        ->count();
            $data['totalWiring']        = Order::where('order.status', 'completed')
                                        ->leftJoin('order_detail', 'order.id', '=', 'order_detail.order_id')
                                        ->where('order_detail.wiring_id', '!=', null)
                                        ->count();
            $data['totalPiping']        = Order::where('order.status', 'completed')
            ->leftJoin('order_detail', 'order.id', '=', 'order_detail.order_id')
                                        ->where('order_detail.piping_id', '!=', null)
                                        ->count();
            $data['totalGardening']     = Order::where('order.status', 'completed')
                                        ->leftJoin('order_detail', 'order.id', '=', 'order_detail.order_id')
                                        ->where('order_detail.gardening_id', '!=', null)
                                        ->count();
            $data['totalRunner']        = Order::where('order.status', 'completed')
                                        ->leftJoin('order_detail', 'order.id', '=', 'order_detail.order_id')
                                        ->where('order_detail.runner_id', '!=', null)
                                        ->count();
            $data['totalSalesProducts'] = Product::sum('sales_amount');
            $data['totalSalesPlants']   = Plant::sum('sales_amount');
            $data['totalOrder']         = Order::count('id');
            $data['totalPayments']      = Payment::where('status', 'success')->sum('amount');

            return view('home')->with($data, 'data');
        } else if(Auth::user()->type == "vendor"){
            $user = Auth::user();
            $vendor = Vendor::where('user_id', $user->id)->first();

            Log::info('Vendor data: ', ['vendor' => $vendor]);

            $data = [];
            $data['totalServices']     = Order::where('order.status', 'completed')
                                    ->leftJoin('delivery', 'order.id', '=', 'delivery.order_id')
                                    ->where('delivery.vendor_id', $vendor->id)
                                    ->count();
            $data['totalWiring']        = Order::where('order.status', 'completed')
                                    ->leftJoin('delivery', 'order.id', '=', 'delivery.order_id')
                                    ->where('delivery.vendor_id', $vendor->id)
                                    ->leftJoin('order_detail', 'order.id', '=', 'order_detail.order_id')
                                    ->where('order_detail.wiring_id', '!=', null)
                                    ->count();
            $data['totalPiping']        = Order::where('order.status', 'completed')
                                    ->leftJoin('delivery', 'order.id', '=', 'delivery.order_id')
                                    ->where('delivery.vendor_id', $vendor->id)
                                    ->leftJoin('order_detail', 'order.id', '=', 'order_detail.order_id')
                                    ->where('order_detail.piping_id', '!=', null)
                                    ->count();
            $data['totalGardening']     = Order::where('order.status', 'completed')
                                    ->leftJoin('delivery', 'order.id', '=', 'delivery.order_id')
                                    ->where('delivery.vendor_id', $vendor->id)
                                    ->leftJoin('order_detail', 'order.id', '=', 'order_detail.order_id')
                                    ->where('order_detail.gardening_id', '!=', null)
                                    ->count();
            $data['totalRunner']        = Order::where('order.status', 'completed')
                                    ->leftJoin('delivery', 'order.id', '=', 'delivery.order_id')
                                    ->where('delivery.vendor_id', $vendor->id)
                                    ->leftJoin('order_detail', 'order.id', '=', 'order_detail.order_id')
                                    ->where('order_detail.runner_id', '!=', null)
                                    ->count();
            $data['totalPayments']      = Payment::where('payment.status', 'success')
                                        ->leftJoin('order', 'payment.order_id', '=', 'order.id')
                                        ->where('order.status', 'completed')
                                        ->leftJoin('delivery', 'order.id', '=', 'delivery.order_id')
                                        ->where('delivery.vendor_id', $vendor->id)
                                        ->sum('payment.amount');
            $data['vendor'] = $vendor;

            return view('home')->with($data, 'data');
        } else {
            return view('404');
        }


        //return redirect()->back();
    }
}
