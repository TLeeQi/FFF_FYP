@extends('layouts.app')

@section('content')
    <div class="row">
        <div class="col-12">
            <div class="card">
                <h5 class="card-header">Create new product</h5>
                <div class="card-body">

                    <form method="POST" action="{{ route('product.store') }}" onsubmit="return getSelectedOption();"
                        enctype="multipart/form-data">
                        @csrf
                        <div class="row">
                            <!-- Personal Info -->
                            <div class="col-12">
                                <h6 class="mt-2">1. Basic Information</h6>
                                <hr class="mt-0" />
                            </div>
                            <!-- Plant Details -->
                            <div class="col-md-6 mb-3">
                                <div class="form-floating form-floating-outline">
                                    <input type="text" class="form-control" placeholder="Soil" name="name" required />
                                    <label for="name">Product Name</label>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <div class="form-floating form-floating-outline">
                                    <input type="number" class="form-control" placeholder="9" name="quantity"
                                        onkeypress="return (event.charCode == 8 || event.charCode == 0) ? null : event.charCode >= 48 && event.charCode <= 57"
                                        min="0" required />
                                    <label for="inventory">Product Inventory</label>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <div class="form-floating form-floating-outline">
                                    <input type="number" class="form-control" placeholder="99.99" name="price"
                                        onkeypress="return (event.charCode >= 48 && event.charCode <= 57) ||
                                event.charCode == 46 || event.charCode == 0 "
                                        min="1" step="0.01" required />
                                    <label for="price">Product Price</label>
                                </div>
                            </div>
                            <div class="form-floating form-floating-outline col-md-6 mb-3">
                                <select class="form-select" id="selectCategory" aria-label="Default select example"
                                    name="category_id">
                                    <option value="default" disabled selected>Choose option</option>
                                    @foreach ($category as $categories)
                                        <option value="{{ $categories->id }}">{{ $categories->name }}</option>
                                    @endforeach
                                </select>
                                <label for="exampleFormControlSelect1">Category</label>
                            </div>

                            <div class="form-floating form-floating-outline col-md-12 mb-3">
                                <select class="form-select" id="status" name="status">
                                    <option value="default" disabled selected>Choose option</option>
                                    <option value="1">Show</option>
                                    <option value="0">Hide</option>
                                    <option value="custom">Custom</option>
                                </select>
                                <label for="exampleFormControlSelect1">Product Status</label>
                            </div>


                            <div class="col-md-12 mb-3">
                                <div class="form-floating form-floating-outline">
                                    <textarea class="form-control h-px-100" name="description" maxlength="500"
                                        placeholder="Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmm ad minim veniam......"
                                        rows="3" required></textarea>
                                    <label for="description">Product description</label>
                                </div>
                            </div>


                            <!-- Personal Info -->
                            <div class="col-12 ">
                                <h6 class="mt-2">2. Product Image &amp; Preview</h6>
                                <hr class="mt-0" />
                            </div>

                            <div class="col-md-12 mb-3">
                                <div class="form-floating form-floating-outline">
                                    <img id="frame" class="img-fluid m-1" style="height:200px; width:200px" />
                                </div>
                            </div>

                            <div class="col-md-12 mb-3">
                                <div class="form-floating form-floating-outline">
                                    <input class="form-control" type="file" id="formFile" name="image"
                                        onchange="preview()">
                                    <label for="formValidationFile">Product Image</label>
                                </div>
                            </div>

                            <div class="col-md-12 ">
                                <button type="submit" class="btn btn-primary">Submit</button>
                                <a href="{{ route('product.index') }}" class="btn btn-primary" value="Back">Back</a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        function getSelectedOption() {
            // selectCategory
            var selectElement2 = document.getElementById("selectCategory");
            var selectedOptionValue2 = selectElement2.value;
            var selectElement3 = document.getElementById("status");
            var selectedOptionValue3 = selectElement3.value;

            if (selectedOptionValue2 === "default" || selectedOptionValue3 === "default") {
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
