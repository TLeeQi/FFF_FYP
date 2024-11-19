@extends('layouts.app')

@section('content')
    <!-- Basic Layout -->
    <div class="row">
        <div class="col-xl">
            <div class="card mb-4">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Create new category</h5>
                </div>
                <div class="card-body">
                    <form method="POST" action="{{ route('category.store') }}" onsubmit="return getSelectedOption();">
                        @csrf
                        <div class="form-floating form-floating-outline mb-4">
                            <input type="text" id="name" name="name" class="form-control"
                                id="basic-default-fullname" placeholder="Name" required />
                            <label for="basic-default-fullname">Name</label>
                        </div>
                        <div class="form-floating form-floating-outline mb-4">
                            <select class="form-select" id="selectOption" aria-label="Default select example"
                                name="type">
                                <option value="" disabled selected>Choose option</option>
                                <option value="Plant">Plant</option>
                                <option value="Product">Product</option>
                            </select>
                            <label for="exampleFormControlSelect1">Type</label>
                        </div>
                        <button type="submit" class="btn btn-primary">Submit</button>
                        <a href="{{ route('category.index') }}" class="btn btn-primary" value="Back">Back</a>
                    </form>
                </div>
            </div>
        </div>

        <script>
            function getSelectedOption() {
                var selectElement = document.getElementById("selectOption");
                var selectedOptionValue = selectElement.value;

                if (selectedOptionValue === "") {
                    alert("Please select an option");
                    return false; // Prevent form submission
                } else {
                    // You can now use the selectedOptionValue in your further processing
                    return true; // Allow form submission
                }
            }
        </script>
    @endsection
