<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Address;
use Illuminate\Support\Facades\Auth;

class AddressApiController extends Controller
{
    public function addressList(Request $request)
    {
        $address_list = Address::where(
            'user_id',
            Auth::id()
        )->where('status', 1);

        // If result is impty, return fail
        // if ($address_list->count() == 0) {
        //     return $this->fail('Address no found');
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
        $address = $address_list->orderBy(
            $sortBy,
            $sortOrder
        )->paginate($limit);

        $ret['address_list'] = $address;

        return $this->success($ret);
    }

    public function addAddress(Request $request)
    {
        $user = Auth::user();

        $request->validate([
            'address' => ['required', 'string', 'max:255'],
        ]);

        $newAddress = Address::create([
            'address' => $request->address,
            'user_id' => $user->id,
        ]);

        $ret['address'] = $newAddress;

        return $this->success($ret);
    }

    public function updateAddress(Request $request)
    {
        $request->validate([
            'id' => ['required', 'string', 'max:255'],
            'address' => ['required', 'string', 'max:255'],
        ]);

        $address = Address::where('id', $request->id)
            ->where('status', 1)
            ->first();

        if (!$address) {
            return $this->fail('Address id not found');
        }

        $address->address = $request->address;
        $address->save();

        $ret['address'] = $address;

        return $this->success($ret);
    }

    public function deleteAddress(Request $request)
    {
        $request->validate([
            'id' => ['required', 'string', 'max:255'],
        ]);

        $address = Address::where('id', $request->id)
            ->where('status', 1)
            ->first();

        if (!$address) {
            return $this->fail('Address id not found');
        }

        $address->status = 0;
        $address->save();

        return $this->success();
    }
}
