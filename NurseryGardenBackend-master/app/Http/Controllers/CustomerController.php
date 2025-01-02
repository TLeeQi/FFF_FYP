<?php

namespace App\Http\Controllers;

use App\Models\User;
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
        ->select('users.*', 'vendors.rating as rating')
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
            ->select('users.*', 'vendors.rating as rating')
            ->where('users.name', 'like', "%$keyword%")
            ->paginate(10)->setPath('');
        } else {
            $vendor = Vendor::where('type', 'vendor')
            ->where('users.status', '1')
            ->leftjoin('users', 'vendors.user_id', '=', 'users.id')
            ->select('users.*', 'vendors.rating as rating')
            ->where('users.name', 'like', "%$keyword%")->paginate(10)->setPath('');
        }
        $vendor->appends(array(
            'name' => $keyword
        ));
        return view('customer.vendor')->with("vendors", $vendor);
    }
    public function editvendor($id)
    {
        $customer = User::where('id', $id)->get();
        return view('customer.sub_screen.customer_edit_screen')->with("customers", $customer);
    }

    public function updatevendor(Request $request)
    {
        $type = $request->type;

        User::where('id', $request->id)->update([
            'type' => $type
        ]);

        Session::flash('success', "Update successfully!");
        return redirect()->route('customer.index');
    }
}
