<?php

namespace App\Http\Controllers;

use App\Models\Bidding;
use App\Models\BiddingDetailModel;
use App\Models\Payment;
use App\Models\Order;
use Illuminate\Http\Request;
use App\Models\Plant;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;
use App\Models\OrderDetailModel;

class BiddingController extends Controller
{
    public function index()
    {
        $bidding = Bidding::leftjoin('plant', 'plant.id', 'bidding.plant_id')
            ->leftjoin('category', 'category.id', 'plant.cat_id')
            ->select(
                'bidding.*',
                'plant.*',
                'plant.id as plant_id',
                'bidding.id as bidding_id',
                'bidding.status as bidding_status',
                'category.name as category_name'
            )
            ->paginate(5);
        return view('bidding.bidding')->with('bidding', $bidding);
    }

    public function search(Request $request)
    {
        $bidding = Bidding::leftjoin('plant', 'plant.id', 'bidding.plant_id')
            ->leftjoin('category', 'category.id', 'plant.cat_id')
            ->select(
                'bidding.*',
                'plant.*',
                'plant.id as plant_id',
                'bidding.id as bidding_id',
                'bidding.status as bidding_status',
                'category.name as category_name'
            )
            ->where('bidding.id', '=', "$request->name")
            ->paginate(5)
            ->setPath('');

        $bidding->appends(array(
            'id' => $request->name
        ));
        return view('bidding.bidding')->with('bidding', $bidding);
    }

    public function insert()
    {
        $plant = Plant::where('status', 'bid')->get();
        return view('bidding.sub_screen.insert_bidding')
            ->with('plants', $plant);
    }

    public function store(Request $request)
    {
        $valid = $request->validate([
            'start_time' => 'required',
            'end_time' => 'required',
            'plant_id' => 'required',
            'int_amt' => 'required',
            'min_amt' => 'required',
        ]);

        if (!$valid) {
            Session::flash('error', 'unvailable price, please insert again');
            return redirect()->back();
        }

        $bidding = Bidding::create([
            'start_time' => $request->start_time,
            'end_time' => $request->end_time,
            'plant_id' => $request->plant_id,
            'intial_amt' => $request->int_amt,
            'highest_amt' => $request->int_amt,
            'min_amt' => $request->min_amt,
            'status' => '1',
        ]);

        if ($bidding->exists) {
            Session::flash('success', "Bidding create successful!");
            return redirect()->route('bidding.index');
        }

        return redirect()->back();
    }

    public function paymentHistory($id)
    {
        $bidding = Bidding::where('id', $id)->first();
        $payment = Payment::where('bidding_id', $id)
            ->orderBy('created_at', 'desc')
            ->paginate(10);

        return view('bidding.sub_screen.user_bidding')
            ->with('bidding', $bidding)
            ->with('payment', $payment);
    }

    public function paymentHistorySearch(Request $request)
    {
        $user_id = $request->name;
        $bidding_id = $request->bidding_id;

        $payment = Payment::where('user_id', $user_id)
            ->where('bidding_id', $bidding_id)
            ->where('user_id', $user_id)
            ->orderBy('created_at', 'desc')
            ->paginate(10)
            ->setPath('');

        $payment->appends(array(
            'userID' => $user_id,
            'id' => $bidding_id
        ));

        $bidding = Bidding::where('id', $bidding_id)->first();

        return view('bidding.sub_screen.user_bidding')
            ->with('bidding', $bidding)
            ->with('payment', $payment);
    }
}
