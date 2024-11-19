<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Plant;
use App\Models\Category;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;


class PlantApiController extends Controller
{
    public function plant()
    {
        $plants = Plant::leftjoin('category', 'category.id', 'plant.cat_id')
            ->where('plant.status', '1')
            ->where('plant.quantity', '>', '0')
            ->select('plant.*', 'category.name as category_name', 'plant.image as image')
            ->get();

        // if ($plants->count() == 0) {
        //     return $this->fail('No plant data available');
        // }

        $ret['plant'] = $plants;
        return $this->success($ret);
    }


    // Pagination for plant
    public function plantList(Request $request)
    {
        $status = $request->status;
        if (is_null($status)) {
            $status = "1";
        } else {
            $status = $request->status;
        }

        $plants_query = Plant::leftjoin('category', 'category.id', 'plant.cat_id')
            ->where('plant.status', $status)
            ->where('plant.quantity', '>', '0')
            ->select('plant.*', 'category.name as category_name', 'plant.image as image');

        // If result is impty, return fail
        // if ($plants_query->count() == 0) {
        //     return $this->fail('Plant no found');
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

        // Search by category
        if ($request->category) {
            $plants_query = $plants_query->whereHas(
                'category',
                function ($query) use ($request) {
                    $query->where('category.name', $request->category);
                }
            );
        }

        // Pagination
        $plants = $plants_query->orderBy(
            $sortBy,
            $sortOrder
        )->paginate($limit);

        $ret['plant'] = $plants;

        return $this->success($ret);
    }

    public function searchKeyword()
    {
        $plants_query = Plant::where('plant.status', '1')
            ->where('plant.quantity', '>', '0')
            ->get(['name']);
        $ret['plant_name'] = $plants_query;
        return $this->success($ret);
    }

    public function searchPlant(Request $request)
    {
        // If no keyword, return error message
        if (
            $request->keyword == null &&
            $request->category == null
        ) {
            return $this->fail('Invalid request');
        }

        $plants_query = Plant::leftjoin('category', 'category.id', 'plant.cat_id')
            ->where('plant.status', '1')
            ->where('plant.quantity', '>', '0')
            ->select('plant.*', 'category.name as category_name', 'plant.image as image');

        // Search by plant name
        if ($request->keyword) {
            $plants_query = $plants_query->where('plant.name', 'like', '%' . $request->keyword . '%');
        }

        // Search by category
        if ($request->category) {
            $plants_query = $plants_query->whereHas(
                'category',
                function ($query) use ($request) {
                    $query->where('category.name', $request->category);
                }
            );
        }

        // If result is impty, return fail
        // if ($plants_query->count() == 0) {
        //     return $this->fail('Plant no found');
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

        // Pagination
        $plants = $plants_query->orderBy(
            $sortBy,
            $sortOrder
        )->paginate($limit)->setPath('');

        if ($request->keyword) {
            $plants->appends(array(
                'keyword' => $request->keyword
            ));
        } else {
            $plants->appends(array(
                'category' => $request->category
            ));
        }

        $ret['plant'] = $plants;

        return $this->success($ret);
    }

    public function getCategory()
    {
        $category =  Category::where('type', 'plant')
            ->where('status', '1')->get();
        if ($category->count() == 0) {
            return $this->fail('No category data available');
        }
        $ret['category'] = $category;
        return $this->success($ret);
    }

    public function show(Request $request)
    {
        $plants = Plant::where('plant.id', $request->id)
            ->where('plant.status', '1')
            ->where('plant.quantity', '>', '0')
            ->select('plant.*')
            ->first();

        if ($plants != null) {
            $ret['plant'] = $plants;
            return $this->success($ret);
        } else {
            return $this->fail('Plant not found');
        }
    }
}
