<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Vendor;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\File;
use App\Models\User;
use Illuminate\Support\Facades\Log;
class VendorController extends Controller
{
    //
    public function verification()
    {
        $vendor = Vendor::where('user_id', Auth::user()->id)->first();
        $user = User::where('id', Auth::user()->id)->first();
        return view('verification.verification', compact('vendor', 'user'));
    }

    public function update(Request $request)
    {
        Log::info('Update method called with data: ' . json_encode($request->all()));
        
        $validated =$request->validate([
            'name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'string', 'email', 'max:255'],
            'address' => ['required', 'string', 'max:255'],
            'contact_number' => ['required', 'numeric'],
            'image' => ['nullable', 'image', 'mimes:jpeg,bmp,png,jpg,svg'],
            'description' => ['required', 'string', 'max:255'],
            'ssm' => ['nullable', 'file', 'mimes:pdf,doc,docx,jpg,jpeg,png'],
        ]);

        \Log::info('Validated data: ' . json_encode($validated));

        $user = $request->user();
        \Log::info($request->all());

        //Handle Photo
        if ($request->hasFile('image')) {
            $old_path = public_path('user_image/' . $user->image);
            if (File::exists($old_path)) {
                File::delete($old_path);
            }
            $imageName = time() . '.' . $request->file('image')->extension();
            $request->image->move(public_path('/user_image'), $imageName);
        } 
        else {
            $imageName = $user->image;
        }

        $user->image = $imageName;
        $user->name = $request->name;
        $user->email = $request->email;
        $user->address = $request->address;
        $user->contact_number = $request->contact_number;
        $user->save();

        //Handle SSM Path
        $ssmPath = null;
        try {
            if ($request->hasFile('ssm') && $request->file('ssm')->isValid()) {
                $ssmFile = $request->file('ssm');
                $ssmFileName = time() . '_' . $ssmFile->getClientOriginalName();
                $ssmFile->move(public_path('ssm_files'), $ssmFileName);
                $ssmPath = 'ssm_files/' . $ssmFileName;
                Log::info('File uploaded successfully: ' . $ssmPath);
            } else {
                Log::error('File is invalid or not present');
            }
        } catch (\Exception $e) {
            Log::error('File upload error: ' . $e->getMessage());
            return back()->with('error', 'File upload failed: ' . $e->getMessage());
        }

        Log::info('SSM path: ' . $ssmPath);
        Log::info('SSM file name: ' . $ssmFileName);

        // Save vendor information
        $vendor = Vendor::updateOrCreate(
            ['user_id' => $user->id],
            [
                'description' => $request->description,
                'ssm_path' => $ssmFileName,
                'status' => '0',
            ]
        );

        Log::info('Session data: ', session()->all());

        return redirect()->route('verification.verification')
        ->with('vendor', $vendor)
        ->with('user', $user)
        ->with('success', 'Vendor information updated successfully');
    }

}
