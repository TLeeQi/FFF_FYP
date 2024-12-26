<?php

namespace App\Http\Controllers;

use App\Models\WiringDetail;
use Illuminate\Http\Request;

class WiringDetailController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $data = $request->validate([
            'user_id' => 'required|integer',
            'type' => 'required|string',
            'fixitem' => 'required|array',
            'ishavepart' => 'required|boolean',
            'types_property' => 'required|string',
            'app_date' => 'required|date',
            'preferred_time' => 'required|string',
            'details' => 'nullable|string',
            'photo' => 'nullable|array',
            'budget' => 'required|string',
        ]);

        $wiringDetail = WiringDetail::create($data);
    
        return response()->json([
            'success' => true, 
            'message' => 'Wiring detail saved successfully!',
            'data' => $wiringDetail
        ]);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
