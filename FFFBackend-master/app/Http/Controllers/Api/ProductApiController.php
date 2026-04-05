<?php

namespace App\Http\Controllers\Api;

use App\Models\Product;
use App\Models\Category;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class ProductApiController extends Controller
{
    public function product()
    {
        $product = Product::leftjoin('category', 'category.id', 'product.cat_id')
            ->where('product.status', '1')
            ->where('product.quantity', '>', '0')
            ->select('product.*', 'category.name as category_name', 'product.image as image')
            ->get();

        $ret['products'] = $product;
        return $this->success($ret);
    }

    // Product Pagination
    public function productList(Request $request)
    {
        $status = $request->status;
        if (is_null($status)) {
            $status = "1";
        } else {
            $status = $request->status;
        }

        $product_query = Product::leftjoin('category', 'category.id', 'product.cat_id')
            ->where('product.status', $status)
            ->where('product.quantity', '>', '0')
            ->select('product.*', 'product.cat_id as cat_id', 'category.name as category_name', 'product.image as image');

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

        // Search by category
        if ($request->category) {
            $product_query =  $product_query->whereHas(
                'category',
                function ($query) use ($request) {
                    $query->where('category.name', $request->category);
                }
            );
        }

        $products = $product_query->orderBy(
            $sortBy,
            $sortOrder
        )->paginate($limit);

        \Log::info('Products Retrieved: ', $products->toArray()); 

        $ret['products'] = $products;

        return $this->success($ret);
    }

    public function searchKeyword()
    {
        $products_query = Product::where('product.status', '1')
            ->where('product.quantity', '>', '0')
            ->get(['name']);
        $ret['product_name'] = $products_query;
        return $this->success($ret);
    }


    public function searchProduct(Request $request)
    {
        if (
            $request->keyword == null &&
            $request->category == null
        ) {
            return $this->fail('Invalid request');
        }

        $product_query = Product::leftjoin('category', 'category.id', 'product.cat_id')
            ->where('product.status', '1')
            ->where('product.quantity', '>', '0')
            ->select('product.*', 'category.name as category_name', 'product.image as image');

        // Search by product name
        if ($request->keyword) {
            $product_query = $product_query->where('product.name', 'like', '%' . $request->keyword . '%');
        }

        // Search by category
        if ($request->category) {
            $product_query =  $product_query->whereHas(
                'category',
                function ($query) use ($request) {
                    $query->where('category.name', $request->category);
                }
            );
        }

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
        $products = $product_query->orderBy(
            $sortBy,
            $sortOrder
        )->paginate($limit)->setPath('');

        if ($request->keyword) {
            $products->appends(array(
                'keyword' => $request->keyword
            ));
        } else {
            $products->appends(array(
                'category' => $request->category
            ));
        }

        $ret['products'] = $products;

        return $this->success($ret);
    }

    public function getCategory()
    {
        $category =  Category::where('type', 'product')
            ->where('status', '1')->get();
        $ret['category'] = $category;
        return $this->success($ret);
    }

    public function show(Request $request)
    {
        $products = Product::where('product.id', $request->id)
            ->where('product.status', '1')
            ->where('product.quantity', '>', '0')
            ->select('product.*')
            ->first();

        if ($products != null) {
            $ret['productt'] = $products;
            return $this->success($ret);
        } else {
            return $this->fail('Product not found');
        }
    }
}
