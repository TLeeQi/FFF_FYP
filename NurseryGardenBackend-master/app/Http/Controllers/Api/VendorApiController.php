<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Vendor;
use App\Models\VendorRating;
use DateTime;
use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;

class VendorApiController extends Controller
{
	/**
	 * Display a listing of the resource.
	 * @param string $limit
	 * List of Vendor
	 */
	public function index(Request $request)
	{
        \Log::info('Authorization Header:', [$request->header('Authorization')]);

		$datetime = Carbon::now()->toDateTimeString();
		$vendor_query = Vendor::where('status', '1');

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
				'vendors.id', 'vendors.created_at'
			]
		)) {
			$sortBy = $request->sortBy;
		} else {
			$sortBy = 'vendors.id';
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
		$vendor = $vendor_query->orderBy(
			$sortBy,
			$sortOrder
		)->paginate($limit);

        \Log::info('Vendors Retrieved: ', $vendor->toArray()); 

		$ret['vendors'] = $vendor;
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

		$vendor_id = $request->id;

		// Check the validty and pass the bid
		$datetime = Carbon::now()->toDateTimeString();

		$vid = Vendor::where('id', $vendor_id)
			//->where('status', '1')
			->first();

		if (!$vid) {
			return $this->fail('Vendor not found');
		}

		if ($vendor_id) {
			$vendor_detail = Vendor::where('id', $vendor_id)
				->first();
			if ($vendor_detail) {
				$ret['vendor_detail'] = $vendor_detail;
			} else {
				$ret['vendor_detail'] = null;
			}
		}


		$ret['vendor_id'] = $vendor_id;
		return $this->success($ret);
	}

    public function rate(Request $request, $id)
    {
        $request->validate([
            'user_id' => 'required|exists:users,id', // Assume users table exists
            'rating' => 'required|numeric|min:0|max:5',
            'review' => 'nullable|string',
        ]);

        $vendor = Vendor::findOrFail($id);

        // Create a new rating
        $rating = VendorRating::create([
            'vendor_id' => $vendor->id,
            'user_id' => $request->user_id,
            'rating' => $request->rating,
            'review' => $request->review,
        ]);

        // Update vendor's average rating
        $vendor->rating = $vendor->ratings()->avg('rating');
        $vendor->save();

        return response()->json(['message' => 'Rating submitted successfully', 'rating' => $rating]);
    }
}
