<?php

namespace App\Http\Controllers;

use App\Models\User;
use GrahamCampbell\ResultType\Success;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;
use App\Models\Vendor;

class CustomerController extends Controller
{
    /**Customer List */
    public function index()
    {
        if (auth()->user()->type == 'admin') {
            $customer = User::where('type', 'user')->paginate(10);
        } else {
            $customer = User::where('type', 'user')
            ->orwhere('type', 'admin')
            ->orwhere('type', 'sadmin')
            ->paginate(10);
        }

        return view('customer.customer')->with("customers", $customer);
    }

    public function search(Request $request)
    {
        $keyword = $request->name;
        if (auth()->user()->type == 'admin') {
            $customer = User::where('type', 'user')
                ->where('name', 'like', "%$keyword%")->paginate(10)->setPath('');
        } else {
            $customer = User::where('type', 'user')
            ->orwhere('type', 'admin')
            ->orwhere('type', 'sadmin')
            ->where('name', 'like', "%$keyword%")->paginate(10)->setPath('');
        }
        $customer->appends(array(
            'name' => $keyword
        ));
        return view('customer.customer')->with("customers", $customer);
    }

    public function edit($id)
    {
        $customer = User::where('id', $id)->get();
        return view('customer.sub_screen.customer_edit_screen')->with("customers", $customer);
    }

    public function update(Request $request)
    {
        $type = $request->type;

        User::where('id', $request->id)->update([
            'type' => $type
        ]);

        Session::flash('success', "Update successfully!");
        return redirect()->route('customer.index');
    }

    public function vendor()
    {
        $vendor = User::where('type', 'vendor')
        ->where('users.status', '1')
        ->leftjoin('vendors', 'vendors.user_id', '=', 'users.id')
        ->select('users.*', 'vendors.rating as rating', 'vendors.id as vendor_id', 'vendors.description as description', 'vendors.category as category', 'vendors.status as vendor_status')
        ->paginate(10);

        return view('customer.vendor')->with("vendors", $vendor);
    }

    public function vendorsearch(Request $request)
    {
        $keyword = $request->name;
        if (auth()->user()->type == 'admin') {
            $vendor = Vendor::where('type', 'vendor')
            ->where('users.status', '1')
            ->leftjoin('users', 'vendors.user_id', '=', 'users.id')
            ->select('users.*', 'vendors.rating as rating', 'vendors.id as vendor_id', 'vendors.description as description', 'vendors.category as category', 'vendors.status as vendor_status')
            ->where('users.name', 'like', "%$keyword%")
            ->paginate(10)->setPath('');
        } else {
            $vendor = Vendor::where('type', 'vendor')
            ->where('users.status', '1')
            ->leftjoin('users', 'vendors.user_id', '=', 'users.id')
            ->select('users.*', 'vendors.rating as rating', 'vendors.id as vendor_id', 'vendors.description as description', 'vendors.category as category', 'vendors.status as vendor_status')
            ->where('users.name', 'like', "%$keyword%")
            ->paginate(10)->setPath('');
        }
        $vendor->appends(array(
            'name' => $keyword
        ));
        return view('customer.vendor')->with("vendors", $vendor);
    }
    public function editvendor($id)
    {
        $vendor = Vendor::where('id', $id)->get();
        return view('customer.sub_screen.vendor_edit_screen')->with("vendors", $vendor);
    }

    public function updatevendor(Request $request)
    {
        $type = $request->type;

        Vendor::where('vendors.id', $request->id)
        ->leftJoin('users', 'vendors.user_id', '=', 'users.id')
        ->update([
            'users.type' => $type
        ]);

        Session::flash('success', "Update successfully!");
        return redirect()->route('customer.vendor');
    }

    public function vendorfilter(Request $request)
    {
        if($request->status == 'new'){
            $vendor = Vendor::where('vendors.status', '0')
            ->leftJoin('users', 'vendors.user_id', '=', 'users.id')
            ->select(
                'vendors.id as vendor_id', 
                'users.name as name',  // Assuming 'name' is in the 'users' table
                'users.image as image', 
                'users.email as email', 
                'users.contact_number as contact_number', 
                'users.address as address', 
                'users.type as type', 
                'vendors.description as description',
                'vendors.status as vendor_status',
                'vendors.category as category'
            )
            ->whereNull('vendors.description')
            ->orderBy('vendors.created_at', 'desc')
            ->paginate(10)->setPath('');
        }
        else if($request->status == 'pending'){
            $vendor = Vendor::where('vendors.status', '0')
            ->leftJoin('users', 'vendors.user_id', '=', 'users.id')
            ->select(
                'vendors.id as vendor_id', 
                'users.name as name',  // Assuming 'name' is in the 'users' table
                'users.image as image', 
                'users.email as email', 
                'users.contact_number as contact_number', 
                'users.address as address', 
                'users.type as type', 
                'vendors.description as description',
                'vendors.status as vendor_status',
                'vendors.category as category'
            )
            ->whereNotNull('vendors.description')  // Filters vendors with non-NULL description
            ->orderBy('vendors.created_at', 'desc')
            ->paginate(10)->setPath('');
        }else{
            $vendor = Vendor::where('vendors.status', '1')
            ->leftJoin('users', 'vendors.user_id', '=', 'users.id')
            ->select(
                'vendors.id as vendor_id', 
                'users.name as name',  // Assuming 'name' is in the 'users' table
                'users.image as image', 
                'users.email as email', 
                'users.contact_number as contact_number', 
                'users.address as address', 
                'users.type as type', 
                'vendors.description as description',
                'vendors.status as vendor_status',
                'vendors.category as category'
            )
            ->orderBy('vendors.created_at', 'desc')
            ->paginate(10)->setPath('');
        }
        return view('customer.vendor')->with('vendors', $vendor);
    }

    public function vendorDetail(Request $request, $id)
    {
        $vendor = Vendor::where('vendors.id', $id)
            ->leftJoin('users', 'vendors.user_id', '=', 'users.id')
            ->select('users.name as name', 
            'users.email as email', 
            'users.contact_number as contact_number', 
            'users.address as address', 
            'users.image as image', 
            'vendors.rating as rating', 
            'vendors.id as vendor_id', 
            'vendors.description as description', 
            'vendors.category as category', 
            'vendors.status as vendor_status', 
            'vendors.ssm_path as ssm_path')
            ->first();

        if (!$vendor) {
            abort(404, 'Vendor not found');
        }

        \Log::info('Vendor found in vendorDetail: ' . $vendor);

        return view('customer.vendorview')->with('vendor', $vendor);
    }

    public function vendorVerify(Request $request, $id)
    {
        $vendor = Vendor::where('id', $id)->first()
        ->update(['status' => '1']);

        return redirect()->route('vendor.detail', $id)->with('success', 'Vendor verified successfully!');
    }

}
