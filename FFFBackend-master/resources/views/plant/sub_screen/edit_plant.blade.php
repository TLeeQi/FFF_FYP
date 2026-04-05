@extends('layouts.app')

@section('content')
    <div class="row">
        <div class="col-12">
            <div class="card">
                <h5 class="card-header">Edit plant</h5>
                <div class="card-body">


                    @foreach ($plant as $plants)
                        <form method="POST" action="{{ route('plant.update', $plants->id) }}"
                            onsubmit="return getSelectedOption();" enctype="multipart/form-data">
                            @csrf
                            <div class="row">
                                <!-- Personal Info -->
                                <div class="col-12">
                                    <h6 class="mt-2">1. Basic Information</h6>
                                    <hr class="mt-0" />
                                </div>

                                <!-- Plant Details -->
                                <div class="col-md-12 mb-3">
                                    <div class="form-floating form-floating-outline">
                                        <input type="text" id="id" name="id" class="form-control"
                                            placeholder="ID" value="{{ $plants->id }}" readonly />
                                        <label for="name">ID</label>
                                    </div>
                                </div>

                                <div class="col-md-6 mb-3">
                                    <div class="form-floating form-floating-outline">
                                        <input type="text" class="form-control" placeholder="Lotus" name="name"
                                            value="{{ $plants->name }}"" required />
                                        <label for="name">Plant Name</label>
                                    </div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <div class="form-floating form-floating-outline">
                                        <input type="number" class="form-control" placeholder="9" name="quantity"
                                            onkeypress="return (event.charCode == 8 || event.charCode == 0) ? null : event.charCode >= 48 && event.charCode <= 57"
                                            min="0" value="{{ $plants->quantity }}" required />
                                        <label for="inventory">Plant Inventory</label>
                                    </div>
                                </div>

                                <div class="col-md-6 mb-3">
                                    <div class="form-floating form-floating-outline">
                                        <input type="number" class="form-control" placeholder="99.99" name="price"
                                            onkeypress="return (event.charCode >= 48 && event.charCode <= 57) ||
                                    event.charCode == 46 || event.charCode == 0 "
                                            min="1" step="0.01" value="{{ $plants->price }}" required />
                                        <label for="price">Plant Price</label>
                                    </div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <div class="form-floating form-floating-outline">
                                        <input type="text" class="form-control" placeholder="Malaysia" name="origin"
                                            value="{{ $plants->origin }}" required />
                                        <label for="origin">Plant Origin</label>
                                    </div>
                                </div>
                                <div class="form-floating form-floating-outline col-md-6 mb-3">
                                    <select class="form-select" id="selectCategory" aria-label="Default select example"
                                        name="category_id">
                                        <option hidden value="{{ $plants->cat_id }}">{{ $plants->cat_name }}
                                            @foreach ($category as $categories)
                                        <option value="{{ $categories->id }}">{{ $categories->name }}</option>
                    @endforeach
                    </select>
                    <label for="exampleFormControlSelect1">Category</label>
                </div>

                <div class="col-md-6 mb-3">
                    <div class="form-floating form-floating-outline ">
                        <input type="number" class="form-control" placeholder="1.15" name="height"
                            onkeypress="return (event.charCode >= 48 && event.charCode <= 57) ||
                                    event.charCode == 46 || event.charCode == 0 "
                            min="0" step="0.01" required value="{{ $plants->mature_height }}" />
                        <label for="price">Mature Height</label>
                    </div>
                </div>

                <div class="form-floating form-floating-outline col-md-6 mb-3">
                    <select class="form-select" id="selectSunlight" name="sunlight">
                        <option hidden value="{{ $plants->sunlight_need }}">
                            {{ $plants->sunlight_need }}</option>
                        <option value="Full">Full</option>
                        <option value="Partial">Partial</option>
                        <option value="Shade">Shade</option>
                    </select>
                    <label for="exampleFormControlSelect1">Sunlight Need</label>
                </div>

                <div class="form-floating form-floating-outline col-md-6 mb-3">
                    <select class="form-select" id="selectWater" name="water">
                        <option hidden value="{{ $plants->water_need }}">
                            {{ $plants->water_need }}</option>
                        <option value="High">High</option>
                        <option value="Moderate">Moderate</option>
                        <option value="Low">Low</option>
                    </select>
                    <label for="exampleFormControlSelect1">Water Need</label>
                </div>

                <div class="form-floating form-floating-outline col-md-12 mb-3">
                    <select class="form-select" id="status" name="status">
                        <option hidden value="{{ $plants->status }}">
                            {{ ($plants->status == 1
                                    ? 'Show'
                                    : $plants->status == 0)
                                ? 'Hide'
                                : ($plants->status == 'bid'
                                    ? 'Bidding'
                                    : 'Custom') }}
                        </option>
                        <option value="1">Show</option>
                        <option value="0">Hide</option>
                        <option value="bid">Bidding</option>
                        <option value="custom">Custom</option>
                    </select>
                    <label for="exampleFormControlSelect1">Plant Status</label>
                </div>

                <div class="col-md-12">
                    <div class="form-floating form-floating-outline col-md-12 mb-3">
                        <div class="form-floating form-floating-outline ">
                            <textarea class="form-control h-px-100" name="description" maxlength="500"
                                placeholder="Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmm ad minim veniam......"
                                rows="3" required value="{{ $plants->description }}">{{ $plants->description }}</textarea>
                            <label for="description">Plant description</label>
                        </div>
                    </div>



                    <!-- Personal Info -->
                    <div class="col-12">
                        <h6 class="mt-2">2. Plant Image &amp; Preview</h6>
                        <hr class="mt-0" />
                    </div>

                    <div class="col-md-12 mb-3">
                        <div class="form-floating form-floating-outline">
                            <img id="frame" class="img-fluid m-1" style="height:200px; width:200px"
                                src="{{ asset('plant_image') }}/{{ $plants->image }}" />
                        </div>
                    </div>

                    <div class="col-md-12 mb-3">
                        <div class="form-floating form-floating-outline">
                            <input class="form-control" type="file" id="formFile" name="image"
                                onchange="preview()">
                            <label for="formValidationFile">Plant Image</label>
                        </div>
                    </div>

                    <div class="col-md-12 mb-3">
                        <button type="submit" class="btn btn-primary">Submit</button>
                        <a href="{{ route('plant.index') }}" class="btn btn-primary" value="Back">Back</a>
                    </div>

                </div>
                </form>
                @endforeach

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
    </script>
@endsection
