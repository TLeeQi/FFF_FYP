<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;

class CustomerController extends Controller
{
    /**Customer List */
    public function index()
    {
        if (auth()->user()->type == 'admin') {
            $customer = User::where('type', 'user')->paginate(10);
        } else {
            $customer = User::paginate(10);
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
            $customer = User::where('name', 'like', "%$keyword%")->paginate(10)->setPath('');
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
}
