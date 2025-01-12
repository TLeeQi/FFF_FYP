<?php

namespace App\Http\Controllers;

use App\Models\Category;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;
use function Ramsey\Uuid\v1;

class CategoryController extends Controller
{

    public function index()
    {
        // $category = Category::where('status', '1')->paginate(5);
        // $category = Category::all();
        $category = Category::paginate(5);
        return view('category.category')
            ->with('category', $category);
    }

    public function insert()
    {
        return view('category.sub_screen.insert_category');
    }

    public function store(Request $request)
    {
        $addCategory = Category::create([    //step 3 bind data//add on 
            'name' => $request->name,
            'type' => $request->type,
            'status' => "1",
        ]);
        if ($addCategory) {
            Session::flash('success', "Category create successful!");
            return redirect()->route('category.index'); // step 5 back to last page
        }
        return null; // step 5 back to last page       
    }

    public function search(Request $request)
    {
        $query = $request->name;
        $keyword = $request->name;
        $category = Category::where('name', 'like', "%$keyword%")
            ->paginate(5);
        $category->appends(array(
            'name' => $query
        ));
        return view('category.category')
            ->with('category', $category);
    }

    public function edit($id)
    {
        $category = Category::all()->where('id', $id);
        return view('category.sub_screen.edit_category')
            ->with('category', $category);
    }

    public function update(Request $request)
    {
        $category = Category::where('id', $request->id)->first();

        //Name get from form
        $category->name = $request->name;
        $category->type = $request->type;
        $category->save();
        Session::flash('success', "Update successfully!!");
        return redirect()->route('category.index');
    }

    public function delete($id)
    {
        $category = Category::where('id', $id)->first();
        if ($category->status == "1") {
            $category->status = "0";
        } else {
            $category->status = "1";
        }
        $category->save();
        Session::flash('success', "Update Category Status successfully!!");
        return redirect()->route('category.index');
    }
}
