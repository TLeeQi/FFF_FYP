<?php

namespace App\Http\Controllers;

use App\Models\WiringDetail;
use Illuminate\Http\Request;
use App\Models\Category;
use App\Models\User;
use App\Models\Product;
use App\Models\Plant;
use App\Models\Payment;
use App\Models\Order;
use Illuminate\Support\Facades\Auth;

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
        $data = [];
        $data['totalUsers']         = User::where('type', '=', 'user')->count('id');
        $data['totalProducts']      = Product::count('id');
        $data['totalPlants']        = Plant::count('id');
        $data['totalServices']     = WiringDetail::count('id') + PipingDetail::count('id') + GardeningDetail::count('id') + RunnerDetail::count('id');
        $data['totalSalesProducts'] = Product::sum('sales_amount');
        $data['totalSalesPlants']   = Plant::sum('sales_amount');
        $data['totalOrder']         = Order::count('id');
        $data['totalPayments']      = Payment::where('status', 'success')->sum('amount');

        if (!Auth::check()) {
            return redirect()->back();
        }
        if (Auth::user()->type == "admin" || Auth::user()->type == "sadmin") {
            return view('home')->with($data, 'data');
        } else {
            return view('404');
        }


        return redirect()->back();
    }
}
