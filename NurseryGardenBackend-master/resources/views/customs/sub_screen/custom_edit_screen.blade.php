@extends('layouts.app')

@section('content')
    <div class="row">
        <div class="col-12">
            <div class="card">
                <h5 class="card-header">Edit custom style</h5>
                <div class="card-body">

                    <form method="POST" action="{{ route('custom.update') }}" class="row g-3" enctype="multipart/form-data">
                        @csrf
                        <!-- Plant Details -->

                        <div class="col-md-12">
                            <div class="form-floating form-floating-outline">
                                <input type="text" class="form-control" placeholder="" name="id"
                                    value="{{ $custom->id }}" required readonly />
                                <label for="name">Custom Style ID</label>
                            </div>
                        </div>

                        <div class="col-md-12">
                            <div class="form-floating form-floating-outline">
                                <input type="text" class="form-control" placeholder="Custom Style Name...."
                                    name="name" value="{{ $custom->name }}" required />
                                <label for="name">Custom Style Name</label>
                            </div>
                        </div>

                        <hr>

                        <div class="col-md-12">
                            <div class="form-floating form-floating-outline">
                                <img id="frame" class="img-fluid m-1" style="height:400px; width:200px"
                                    src="{{ asset('custom') }}/{{ $custom->image }}" alt="Image Preview" />
                            </div>
                        </div>

                        <div class="col-md-12">
                            <div class="form-floating form-floating-outline">
                                <input class="form-control" type="file" id="formFile" name="image"
                                    onchange="preview()">
                                <label for="formValidationFile">Custom Style Image</label>
                            </div>
                        </div>

                        <hr>

                        <div class="col-md-12">
                            <div class="form-floating form-floating-outline">
                                <input class="form-control" type="file" accept="video/*" id="videoFile" name="videoFile"
                                    onchange="videoFileName()" />
                                <label for="formValidationFile">Custom Style Video</label>
                            </div>
                        </div>

                        <div class="col-md-12">
                            <div class="form-floating form-floating-outline">
                                <input type="text" class="form-control" placeholder="" name="video"
                                    value="{{ $custom->video }}" required readonly />
                                <label for="name">Old Video File Name</label>
                            </div>
                        </div>

                        <div class="col-md-12">
                            <button type="submit" class="btn btn-primary">Submit</button>
                            <a href="{{ route('custom.index') }}" class="btn btn-primary" value="Back">Back</a>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </div>
    <script>
        function preview() {
            frame.src = URL.createObjectURL(event.target.files[0]);
        }

        function clearImage() {
            document.getElementById('formFile').value = null;
            frame.src = "";
        }

        // const videoSrc = document.querySelector("#video-source");
        // const videoTag = document.querySelector("#video-tag");
        // const inputTag = document.querySelector("#videoFile");
        // inputTag.addEventListener('change', readVideo)

        // function readVideo(event) {
        //     console.log(event.target.files)
        //     if (event.target.files && event.target.files[0]) {
        //         var reader = new FileReader();

        //         reader.onload = function(e) {
        //             console.log('loaded')
        //             videoSrc.src = e.target.result
        //             videoTag.load()
        //         }.bind(this)

        //         reader.readAsDataURL(event.target.files[0]);
        //     }
        // }
    </script>
@endsection
