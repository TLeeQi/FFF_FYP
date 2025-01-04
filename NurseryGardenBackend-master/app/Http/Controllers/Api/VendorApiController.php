<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Vendor;
use App\Models\User;
use App\Models\VendorRating;
// use DateTime;
use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;

class VendorApiController extends Controller
{
	/**
	 * Display a listing of the resource.
	 * @param string $limit
	 * List of Vendor
	 */

	 public function vendor()
    {
        $vendor = User::where('vendors.status', '1')
            ->leftjoin('vendors', 'vendors.user_id', '=', 'users.id')
            ->where('users.type', 'vendor')
            ->where('vendors.status', '1')
            ->select('users.*', 'vendors.rating as rating', 'vendors.id as vendor_id', 'vendors.description as description')
			->get();

        $ret['vendors'] = $vendor;
        return $this->success($ret);
    }

	public function vendorList(Request $request)
	{
        \Log::info('Authorization Header:', [$request->header('Authorization')]);

		//$datetime = Carbon::now()->toDateTimeString();
		$vendor_query = User::where('users.status', '1')
        ->leftjoin('vendors', 'vendors.user_id', '=', 'users.id')
        ->where('users.type', 'vendor')
        ->where('vendors.status', '1')
        ->select('users.*', 'vendors.rating as rating', 'vendors.id as vendor_id', 'vendors.description as description');

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
				'id', 'created_at'
			]
		)) {
			$sortBy = $request->sortBy;
		} else {
			$sortBy = 'id';
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
		$vendors = $vendor_query->orderBy(
			$sortBy,
			$sortOrder
		)->paginate($limit);

        \Log::info('Vendors Retrieved: ', $vendors->toArray()); 

		$ret['vendors'] = $vendors;
		return $this->success($ret);
	}

	/*
	 * @param Bidding ID
	 * @return highest amount
	 */
	// public function show(Request $request)
	// {
	// 	$request->validate([
	// 		'id' => 'required'
	// 	]);

	// 	$vendor_id = $request->id;

	// 	// Check the validty and pass the bid
	// 	//$datetime = Carbon::now()->toDateTimeString();

	// 	$vid = Vendor::where('id', $vendor_id)
	// 		//->where('status', '1')
	// 		->first();

	// 	if (!$vid) {
	// 		return $this->fail('Vendor not found');
	// 	}

	// 	if ($vendor_id) {
	// 		$vendor_detail = Vendor::where('id', $vendor_id)
	// 			->first();
	// 		if ($vendor_detail) {
	// 			$ret['vendor_detail'] = $vendor_detail;
	// 		} else {
	// 			$ret['vendor_detail'] = null;
	// 		}
	// 	}


	// 	$ret['vendor_id'] = $vendor_id;
	// 	return $this->success($ret);
	// }

	public function searchKeyword()
    {
        $vendors_query = User::where('users.status', '1')
                    ->where('users.type', 'vendor')
                    ->where('vendors.status', '1')
                    ->get(['name']);
        $ret['vendor_name'] = $vendors_query;
        return $this->success($ret);
    }


    public function searchVendor(Request $request)
    {
        if (
            $request->keyword == null
        ) {
            return $this->fail('Invalid request');
        }

        $vendor_query = User::where('users.status', '1')
        ->where('users.type', 'vendor')
        ->leftjoin('vendors', 'vendors.user_id', '=', 'users.id')
        ->where('vendors.status', '1')
        ->select('users.*', 'vendors.rating as rating', 'vendors.id as vendor_id', 'vendors.description as description');

        // Search by product name
        if ($request->keyword) {
            $vendor_query = $vendor_query->where('name', 'like', '%' . $request->keyword . '%');
        }

        // Search by category
        // if ($request->category) {
        //     $product_query =  $product_query->whereHas(
        //         'category',
        //         function ($query) use ($request) {
        //             $query->where('category.name', $request->category);
        //         }
        //     );
        // }

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
                'id', 'created_at', 'price', 'sales_amount'
            ]
        )) {
            $sortBy = $request->sortBy;
        } else {
            $sortBy = 'id';
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

        // Paginations
        $vendors = $vendor_query->orderBy(
            $sortBy,
            $sortOrder
        )->paginate($limit)->setPath('');

        if ($request->keyword) {
            $vendors->appends(array(
                'keyword' => $request->keyword
            ));
        }

        $ret['vendors'] = $vendors;

        return $this->success($ret);
    }

	// public function show(Request $request)
    // {
    //     $vendors = Vendor::where('id', $request->id)
    //         ->where('status', '1')
    //         ->select('*')
    //         ->first();

    //     if ($vendors != null) {
    //         $ret['vendor'] = $vendors;
    //         return $this->success($ret);
    //     } else {
    //         return $this->fail('Vendor not found');
    //     }
    // }

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
