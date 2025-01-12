<?php

namespace App\Http\Controllers;

use App\Models\Custom;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Session;

class CustomController extends Controller
{
    public function index()
    {
        $customs = Custom::select(
            "custom.*",
        )->paginate(7);
        return view('customs.custom')->with('customs', $customs);
    }

    public function insert()
    {
        return view('customs.sub_screen.custom_add_screen');
    }

    public function edit($id)
    {
        $custom = Custom::where('id', $id)->first();
        return view('customs.sub_screen.custom_edit_screen')->with('custom', $custom);
    }

    public function store(Request $request)
    {
        //Handle Photo
        if ($request->hasFile('image')) {
            $imageName =  $request->file('image')->getClientOriginalName();
            $request->file('image')->move(public_path('/custom'), $imageName);
        } else {
            $imageName = 'no_plant.png';
        }

        //Handle Video
        if ($request->hasFile('videoFile')) {
            $videoName =  $request->file('videoFile')->getClientOriginalName();
            $request->file('videoFile')->move(public_path('/custom'), $videoName);
        } else {
            $videoName = 'demo.mp4';
        }

        // Create new style
        $addCustom = Custom::create([
            'name' => $request->name,
            'image' => $imageName,
            'video' => $videoName,
            'status' => '1',
        ]);

        Session::flash('success', "Create style successfully!!");
        return redirect()->route('custom.index');
    }

    public function update(Request $request)
    {
        $custom = Custom::where('id', $request->id)->first();

        //Handle Photo
        if ($request->hasFile('image')) {
            $old_path = public_path('custom/' . $custom->image);
            if (File::exists($old_path)) {
                if ($custom->image != 'no_plant.png') {
                    File::delete($old_path);
                }
            }
            $imageName =  $request->file('image')->getClientOriginalName();
            $request->file('image')->move(public_path('/custom'), $imageName);
        } else {
            if ($custom->image == null) {
                $imageName = 'no_plant.png';
            } else {
                $imageName = $custom->image;
            }
        }

        //Handle Video
        if ($request->hasFile('videoFile')) {
            $old_path = public_path('custom/' . $custom->video);
            if (File::exists($old_path)) {
                if ($custom->video != 'demo.mp4') {
                    File::delete($old_path);
                }
            }
            $videoName =  $request->file('videoFile')->getClientOriginalName();
            $request->file('videoFile')->move(public_path('/custom'), $videoName);
        } else {
            if ($custom->video == null) {
                $videoName = 'demo.mp4';
            } else {
                $videoName = $custom->video;
            }
        }

        $custom->name = $request->name;
        $custom->image = $imageName;
        $custom->video = $videoName;
        $custom->save();

        Session::flash('success', "Update style successfully!!");
        return redirect()->route('custom.index');
    }

    public function search(Request $request)
    {
        $query = $request->name;
        $keyword = $request->name;
        $custom = Custom::select(
            "custom.*",
        )->where('custom.name', 'like', "%$keyword%");
        $custom = $custom->paginate(7)->setPath('');
        $custom->appends(array(
            'name' => $query
        ));
        return view('customs.custom')
            ->with('customs', $custom);;
    }

    public function delete($id)
    {
        $custom = Custom::where('id', $id)->first();
        if ($custom->status == "1") {
            $custom->status = "0";
        } else {
            $custom->status = "1";
        }

        Session::flash('success', "Update Style status successfully!!");
        $custom->save();
        return redirect()->route('custom.index');
    }
}
