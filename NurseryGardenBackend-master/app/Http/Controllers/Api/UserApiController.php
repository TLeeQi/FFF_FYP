<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Validation\Rules;
use Illuminate\Support\Facades\Hash;
use App\Models\User;
use Illuminate\Support\Facades\File;

class UserApiController extends Controller
{
    public function show(Request $request)
    {
        $user = $request->user();
        return $this->success($user);
    }

    // Upddate profile
    public function update(Request $request)
    {
        $request->validate([
            'name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'string', 'email', 'max:255'],
            'address' => ['nullable', 'string', 'max:255'],
            'gender' => ['nullable', 'string', 'max:255'],
            'contact_number' => ['nullable', 'numeric'],
            'image' => ['nullable', 'image', 'mimes:jpeg,bmp,png,jpg,svg'],
            'birth_date' => ['nullable', 'date', 'before:today'],
            'image_name' => ['nullable', 'string', 'max:255'],
        ]);

        $user = $request->user();

        //Handle Photo
        if ($request->hasFile('image')) {
            $old_path = public_path('user_image/' . $user->image);
            if (File::exists($old_path)) {
                File::delete($old_path);
            }
            $imageName = time() . '.' . $request->file('image')->extension();
            $request->image->move(public_path('/user_image'), $imageName);
        } else {
            $imageName = $user->image;
        }

        $user->image = $imageName;

        if ($request->image_name != null) {
            $old_path = public_path('temp_image/' . $request->image_name);
            if (File::exists($old_path)) {
                // Check user path
                $user_path = public_path('user_image/' . $user->image);
                if (File::exists($user_path)) {
                    File::delete($user_path);
                }
                // Change image name
                $user->image = $request->image_name;
                // Move image path
                File::move(
                    public_path('temp_image/' . $request->image_name),
                    public_path('user_image/' . $user->image)
                );
            }
        }

        $user->name = $request->name;
        $user->email = $request->email;
        $user->address = $request->address;
        $user->gender = $request->gender;
        $user->contact_number = $request->contact_number;
        $user->birth_date = $request->birth_date;
        $user->save();

        return $this->success();
    }

    // Temp
    public function handleUploadUserImage(Request $request)
    {
        $request->validate([
            'image' => ['required', 'image', 'mimes:jpeg,bmp,png,jpg,svg'],
        ]);

        $user = $request->user();

        //Handle Photo
        if ($request->hasFile('image')) {
            $imageName = time() . '.' . $request->file('image')->extension();
            $request->image->move(public_path('/temp_image'), $imageName);
        } else {
            $imageName = $user->image;
            return $this->fail("Fail to Save the image");
        }

        $ret['image_link'] = asset('/temp_image/' . $imageName);
        $ret['image_name'] = $imageName;
        return $this->success($ret);
    }

    public function updatePassword(Request $request)
    {
        $request->validate([
            'old_password' => ['required', 'String', Rules\Password::defaults()],
            'new_password' => ['required', Rules\Password::defaults()],
        ]);

        $user = $request->user();

        // Match The Old Password
        if (!Hash::check($request->old_password, $user->password)) {
            return $this->fail("Error, Old Password doesn't match!");
        }

        // Update the new Password
        $user->update([
            'password' => Hash::make($request->new_password)
        ]);

        return $this->success();
    }
}
