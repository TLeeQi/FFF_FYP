<?php

namespace App\Http\Controllers;

use App\Models\Category;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Session;

class ProductController extends Controller
{
    /**Product List */
    public function index()
    {
        $product = Product::select(
            "product.*",
            "category.name as cat_name",
        )->leftjoin('category', 'category.id', 'product.cat_id')
            ->paginate(5);
        return view('product.product')
            ->with('product', $product);
    }

    public function insert()
    {
        $category = Category::where('status', '1')
            ->where('type', 'product')->get();
        return view('product.sub_screen.insert_product')
            ->with('category', $category);
    }

    public function store(Request $request)
    {
        //Handle Photo
        if ($request->hasFile('image')) {
            $imageName = time() . '.' . $request->file('image')->getClientOriginalExtension();
            $request->file('image')->move(public_path('/product_image'), $imageName);
        } else {
            $imageName = 'no_product.png';
        }

        // Create product
        $addProduct = Product::create([
            'name' => $request->name,
            'price' => $request->price,
            'description' => $request->description,
            'quantity' => $request->quantity,
            'status' => $request->status,
            'image' => $imageName,
            'cat_id' => $request->category_id
        ]);

        if ($addProduct->exists) {
            Session::flash('success', "Product create successfully!!");
            return redirect()->route('product.index');
        }
    }

    public function search(Request $request)
    {
        $query = $request->name;
        $keyword = $request->name;
        $product = Product::select(
            "product.*",
            "category.name as cat_name",
        )->leftjoin('category', 'category.id', 'product.cat_id')
            ->where('product.name', 'like', "%$keyword%")
            ->paginate(5)->setPath('');
        $product->appends(array(
            'name' => $query
        ));
        return view('product.product')
            ->with('product', $product);;
    }

    public function edit($id)
    {
        $category = Category::where('status', '1')
            ->where('type', 'product')->get();
        $product = Product::select(
            "product.*",
            "category.name as cat_name",
        )->leftjoin('category', 'category.id', 'product.cat_id')
            ->where('product.id', $id)
            ->get();
        return view('product.sub_screen.edit_product')
            ->with('product', $product)
            ->with('category', $category);;
    }

    public function update(Request $request)
    {
        $product = Product::where('id', $request->id)->first();

        //Handle Photo
        if ($request->hasFile('image')) {
            $old_path = public_path('product_image/' . $product->image);
            if (File::exists($old_path)) {
                if ($product->image != 'no_product.png') {
                    File::delete($old_path);
                }
            }
            $imageName = time() . '.' . $request->file('image')->getClientOriginalExtension();
            $request->file('image')->move(public_path('/product_image'), $imageName);
        } else {
            if ($product->image == null) {
                $imageName = 'no_product.png';
            } else {
                $imageName = $product->image;
            }
        }

        $product->name = $request->name;
        $product->price = $request->price;
        $product->description = $request->description;
        $product->quantity = $request->quantity;
        $product->status = $request->status;
        $product->image = $imageName;
        $product->cat_id = $request->category_id;
        $product->save();

        Session::flash('success', "Update Product successfully!!");
        return redirect()->route('product.index');
    }

    public function delete($id)
    {
        $product = Product::where('id', $id)->first();
        if ($product->status == "1") {
            $product->status = "0";
        } else {
            $product->status = "1";
        }
        $product->save();
        Session::flash('success', "Update Product Status successfully!!");
        return redirect()->route('product.index');
    }
}
