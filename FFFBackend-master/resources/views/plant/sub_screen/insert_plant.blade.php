@extends('layouts.app')

@section('content')
    <div class="row">
        <div class="col-12">
            <div class="card">
                <h5 class="card-header">Create new plant</h5>
                <div class="card-body">

                    <form method="POST" action="{{ route('plant.store') }}" class="row g-3"
                        onsubmit="return getSelectedOption();" enctype="multipart/form-data">
                        @csrf
                        <!-- Personal Info -->
                        <div class="col-12">
                            <h6 class="mt-2">1. Basic Information</h6>
                            <hr class="mt-0" />
                        </div>
                        <!-- Plant Details -->
                        <div class="col-md-6">
                            <div class="form-floating form-floating-outline">
                                <input type="text" class="form-control" placeholder="Lotus" name="name" required />
                                <label for="name">Plant Name</label>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-floating form-floating-outline">
                                <input type="number" class="form-control" placeholder="9" name="quantity"
                                    onkeypress="return (event.charCode == 8 || event.charCode == 0) ? null : event.charCode >= 48 && event.charCode <= 57"
                                    min="0" required />
                                <label for="inventory">Plant Inventory</label>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-floating form-floating-outline">
                                <input type="number" class="form-control" placeholder="99.99" name="price"
                                    onkeypress="return (event.charCode >= 48 && event.charCode <= 57) ||
                                    event.charCode == 46 || event.charCode == 0 "
                                    min="1" step="0.01" required />
                                <label for="price">Plant Price</label>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-floating form-floating-outline">
                                <input type="text" class="form-control" placeholder="Malaysia" name="origin" required />
                                <label for="origin">Plant Origin</label>
                            </div>
                        </div>
                        <div class="form-floating form-floating-outline col-md-6">
                            <select class="form-select" id="selectCategory" aria-label="Default select example"
                                name="category_id">
                                <option value="default" disabled selected>Choose option</option>
                                @foreach ($category as $categories)
                                    <option value="{{ $categories->id }}">{{ $categories->name }}</option>
                                @endforeach
                            </select>
                            <label for="exampleFormControlSelect1">Category</label>
                        </div>

                        <div class="col-md-6">
                            <div class="form-floating form-floating-outline">
                                <input type="number" class="form-control" placeholder="1.15" name="height"
                                    onkeypress="return (event.charCode >= 48 && event.charCode <= 57) ||
                                    event.charCode == 46 || event.charCode == 0 "
                                    min="0" step="0.01" required />
                                <label for="price">Mature Height</label>
                            </div>
                        </div>

                        <div class="form-floating form-floating-outline col-md-6">
                            <select class="form-select" id="selectSunlight" name="sunlight">
                                <option value="default" disabled selected>Choose option</option>
                                <option value="Full">Full</option>
                                <option value="Partial">Partial</option>
                                <option value="Shade">Shade</option>
                            </select>
                            <label for="exampleFormControlSelect1">Sunlight Need</label>
                        </div>

                        <div class="form-floating form-floating-outline col-md-6">
                            <select class="form-select" id="selectWater" name="water">
                                <option value="default" disabled selected>Choose option</option>
                                <option value="High">High</option>
                                <option value="Moderate">Moderate</option>
                                <option value="Low">Low</option>
                            </select>
                            <label for="exampleFormControlSelect1">Water Need</label>
                        </div>

                        <div class="form-floating form-floating-outline col-md-12">
                            <select class="form-select" id="status" name="status">
                                <option value="default" disabled selected>Choose option</option>
                                <option value="1">Show</option>
                                <option value="0">Hide</option>
                                <option value="bid">Bidding</option>
                                <option value="custom">Custom</option>
                            </select>
                            <label for="exampleFormControlSelect1">Plant Status</label>
                        </div>

                        <div class="col-md-12">
                            <div class="form-floating form-floating-outline">
                                <textarea class="form-control h-px-100" name="description" maxlength="500"
                                    placeholder="Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmm ad minim veniam......"
                                    rows="3" required></textarea>
                                <label for="description">Plant description</label>
                            </div>
                        </div>



                        <!-- Personal Info -->
                        <div class="col-12">
                            <h6 class="mt-2">2. Plant Image &amp; Preview</h6>
                            <hr class="mt-0" />
                        </div>

                        <div class="col-md-12">
                            <div class="form-floating form-floating-outline">
                                <img id="frame" class="img-fluid m-1" style="height:200px; width:200px" />
                            </div>
                        </div>

                        <div class="col-md-12">
                            <div class="form-floating form-floating-outline">
                                <input class="form-control" type="file" id="formFile" name="image"
                                    onchange="preview()">
                                <label for="formValidationFile">Plant Image</label>
                            </div>
                        </div>

                        <div class="col-md-12">
                            <button type="submit" class="btn btn-primary">Submit</button>
                            <a href="{{ route('plant.index') }}" class="btn btn-primary" value="Back">Back</a>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </div>
    <script>
        function getSelectedOption() {
            // selectCategory
            var selectElement = document.getElementById("selectSunlight");
            var selectedOptionValue = selectElement.value;
            var selectElement1 = document.getElementById("selectWater");
            var selectedOptionValue1 = selectElement1.value;
            var selectElement2 = document.getElementById("selectCategory");
            var selectedOptionValue2 = selectElement2.value;
            var selectElement3 = document.getElementById("status");
            var selectedOptionValue3 = selectElement3.value;

            if (selectedOptionValue === "default" || selectedOptionValue1 === "default" ||
                selectedOptionValue2 === "default" || selectedOptionValue3 === "default") {
                alert("Please select an option");
                return false; // Prevent form submission
            } else {
                // You can now use the selectedOptionValue in your further processing
                return true; // Allow form submission
            }
        }

        function preview() {
            frame.src = URL.createObjectURL(event.target.files[0]);
        }

        function clearImage() {
            document.getElementById('formFile').value = null;
            frame.src = "";
        }
    </script>
@endsection
