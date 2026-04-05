@extends('layouts.app')

@section('content')
    <!-- Basic Layout -->
    <div class="row">
        <div class="col-xl">
            <div class="card mb-4">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Edit Category</h5>
                </div>
                <div class="card-body">
                    @foreach ($category as $categories)
                        <form method="POST" action="{{ route('category.update', $categories->id) }}">
                            @csrf
                            <div class="form-floating form-floating-outline mb-4">
                                <input type="text" id="id" name="id" class="form-control"
                                    id="basic-default-fullname" placeholder="ID" value="{{ $categories->id }}" readonly />
                                <label for="basic-default-fullname">ID</label>
                            </div>
                            <div class="form-floating form-floating-outline mb-4">
                                <input type="text" id="name" name="name" class="form-control"
                                    id="basic-default-fullname" placeholder="Name" value="{{ $categories->name }}"
                                    required />
                                <label for="basic-default-fullname">Name</label>
                            </div>
                            <div class="form-floating form-floating-outline mb-4">
                                <select class="form-select" id="selectOption" aria-label="Default select example"
                                    name="type">
                                    <option hidden value="{{ $categories->type }}">
                                        {{ $categories->type }}</option>
                                    <option value="Plant">Plant</option>
                                    <option value="Product">Product</option>
                                </select>
                                <label for="exampleFormControlSelect1">Type</label>
                            </div>
                            <button type="submit" class="btn btn-primary">Save</button>
                            <a href="{{ route('category.index') }}" class="btn btn-primary" value="Back">Back</a>
                        </form>
                    @endforeach
                </div>
            </div>
        </div>
    @endsection
