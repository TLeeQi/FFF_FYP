<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Bidding;
use App\Models\Payment;
use DateTime;
use Stripe;
use App\Models\BiddingDetailModel;
use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;

class BiddingApiController extends Controller
{
	/**
	 * Display a listing of the resource.
	 * @param string $limit
	 * @return Pagination 
	 * List of Bidding
	 */
	public function index(Request $request)
	{
		$datetime = Carbon::now()->toDateTimeString();
		$bidding_query = Bidding::leftjoin('plant', 'plant.id', 'bidding.plant_id')
			->leftjoin('category', 'category.id', 'plant.cat_id')
			->select(
				'bidding.*',
				'plant.*',
				'plant.id as plant_id',
				'bidding.id as bidding_id',
				'category.name as category_name'
			)
			->where('bidding.status', '1')
			->where('start_time', '<=', $datetime)
			->where('end_time', '>=', $datetime);

		// Pagination Limit
		if ($request->limit) {
			$limit = $request->limit;
		} else {
			$limit = 8;
		}

		// Sort By 
		if ($request->sortBy && in_array(
			$request->sortBy,
			[
				'bidding.id', 'bidding.created_at'
			]
		)) {
			$sortBy = $request->sortBy;
		} else {
			$sortBy = 'bidding.id';
		}

		if ($request->sortOrder && in_array(
			$request->sortOrder,
			[
				'asc', 'desc'
			]
		)) {
			$sortOrder = $request->sortOrder;
		} else {
			$sortOrder = 'asc';
		}

		// Pagination
		$bidding = $bidding_query->orderBy(
			$sortBy,
			$sortOrder
		)->paginate($limit);


		$ret['bidding'] = $bidding;
		return $this->success($ret);
	}

	/*
	 * @param Bidding ID
	 * @return highest amount
	 */
	public function show(Request $request)
	{
		$request->validate([
			'id' => 'required'
		]);

		$bidding_id = $request->id;

		// Check the validty and pass the bid
		$datetime = Carbon::now()->toDateTimeString();

		$bid = Bidding::where('id', $bidding_id)
			->where('status', '1')
			->where('end_time', '>=', $datetime)
			->where('start_time', '<=', $datetime)
			->first();

		if (!$bid) {
			return $this->fail('Bidding not found');
		}

		if ($bid) {
			$bid_detail = BiddingDetailModel::where('bidding_id', $bidding_id)
				->where('refund_status', 'pay')
				->where('user_id', Auth::id())
				->first();
			if ($bid_detail) {
				$ret['user_bid'] = $bid_detail->amount;
			} else {
				$ret['user_bid'] = 0;
			}
		}


		$ret['bid'] = $bid;
		return $this->success($ret);
	}


	public function paymentIntent(Request $request)
	{
		// Validate
		$request->validate([
			'bidding_id' => 'required',
			'amount' => 'required'
		]);

		if ($request->amount >= 100000) {
			return $this->fail('Amount must be less than 100000');
		}

		// Get Bidding Info
		$bidding_id = $request->bidding_id;

		// Check the validty and pass the bid
		$datetime = Carbon::now()->toDateTimeString();

		$bid = Bidding::where('id', $bidding_id)
			//Update the Bidding Status when finished
			->where('status', '1')
			->where('end_time', '>=', $datetime)
			->where('start_time', '<=', $datetime)
			->first();

		if (!$bid) {
			return $this->fail('Bidding not found');
		}

		// Validate the amount
		$bid_amount = $request->amount;
		if ($bid_amount < ($bid->highest_amt + $bid->min_amt)) {
			return $this->fail('Amount must be greater than highest amount plus minimum amount');
		}

		// Check last amount
		$last_bid = BiddingDetailModel::where('bidding_id', $bidding_id)
			->where('user_id', Auth::id())
			->where('refund_status', 'pay')
			->first();

		// Get the Old amount
		if ($last_bid) {
			// Update Bidding Detail
			$amount = $bid_amount - $last_bid->amount;

			if ($amount <= 0) {
				return $this->fail('Difference amount 0 is not allowed');
			}

			$bid_detail = BiddingDetailModel::where('id', $last_bid->id)->first();

			// Make payment
			$stripeClient = new Stripe\StripeClient(
				config('services.stripe.STRIPE_SECRET_KEY')
			);

			// Create a PaymentIntent with amount and currency
			$paymentIntent = $stripeClient->paymentIntents->create([
				'amount' => $amount * 100,
				'currency' => 'myr',
				'payment_method_types' => ['card'],
			]);

			// Create Payment
			Payment::create([
				'status' => 'pending',
				'bidding_id' => $bid->id,
				'details' => $paymentIntent->client_secret,
				'method' => 'Card',
				'amount' =>  $amount,
				'date' => Carbon::today(),
				'user_id' => Auth::id()
			]);

			$payment = [
				'Client_Secret' => $paymentIntent->client_secret,
				'amount' => $amount
			];

			$ret['payment'] = $payment;
		} else {
			// Create Bidding Detail
			$amount = $request->amount;

			// Make payment
			$stripeClient = new Stripe\StripeClient(
				config('services.stripe.STRIPE_SECRET_KEY')
			);

			// Create a PaymentIntent with amount and currency
			$paymentIntent = $stripeClient->paymentIntents->create([
				'amount' => $amount * 100,
				'currency' => 'myr',
				'payment_method_types' => ['card'],
			]);

			Payment::create([
				'status' => 'pending',
				'bidding_id' => $bid->id,
				'details' => $paymentIntent->client_secret,
				'method' => 'Card',
				'amount' =>  $amount,
				'date' => Carbon::today(),
				'user_id' => Auth::id()
			]);

			$payment = [
				'Client_Secret' => $paymentIntent->client_secret,
				'amount' => $amount
			];

			$ret['payment'] = $payment;
		}
		return $this->success($ret);
	}

	public function payment(Request $request)
	{
		$request->validate([
			'client_secret' => ['required'],
		]);;

		$payment = Payment::where('details', $request->client_secret)->first();
		$payment->status = 'success';
		$payment->save();

		// Check the validty and pass the bid
		$datetime = Carbon::now()->toDateTimeString();

		// If payment succees, update the bidding highest amount and bidding detail status
		$bidding = Bidding::where('id', $payment->bidding_id)
			->where('end_time', '>=', $datetime)
			->where('start_time', '<=', $datetime)
			->first();

		$bid_detail = BiddingDetailModel::where('bidding_id', $bidding->id)
			->where('user_id', Auth::id())
			->first();

		if (!$bid_detail) {
			$bid_detail = BiddingDetailModel::create([
				'bidding_id' => $bidding->id,
				'amount' => $payment->amount,
				'user_id' => Auth::id(),
				'refund_status' => 'pay',
				'payment_way' => 'Card'
			]);
		} else {
			$bid_detail->amount += $payment->amount;
			$bid_detail->save();
		}

		// Amend the highest amounts
		$bidding->highest_amt = $bid_detail->amount;
		$bidding->winner_id = Auth::id();
		$bidding->save();

		return $this->success("Payment Success");
	}

	public function refundList(Request $request)
	{
		$datetime = Carbon::now()->toDateTimeString();
		$bidding_query = Bidding::leftjoin('bidding_detail', 'bidding_detail.bidding_id', 'bidding.id')
			->leftjoin('plant', 'plant.id', 'bidding.plant_id')
			->where('bidding.status', '2')
			->where('bidding_detail.refund_status', 'pay')
			->where('bidding_detail.user_id', Auth::id())
			->where('end_time', '<=', $datetime)
			->select(
				'bidding_detail.*',
				'bidding.id as bidding_id',
				'bidding.plant_id as plant_id',
				'plant.image as plant_image',
				'plant.name as plant_name',
			);

		// Pagination Limit
		if ($request->limit) {
			$limit = $request->limit;
		} else {
			$limit = 8;
		}

		// Sort By 
		if ($request->sortBy && in_array(
			$request->sortBy,
			[
				'bidding.id', 'bidding.created_at'
			]
		)) {
			$sortBy = $request->sortBy;
		} else {
			$sortBy = 'bidding.id';
		}

		if ($request->sortOrder && in_array(
			$request->sortOrder,
			[
				'asc', 'desc'
			]
		)) {
			$sortOrder = $request->sortOrder;
		} else {
			$sortOrder = 'asc';
		}

		// Pagination
		$bidding = $bidding_query->orderBy(
			$sortBy,
			$sortOrder
		)->paginate($limit);


		$ret['refund_list'] = $bidding;
		return $this->success($ret);
	}
}
