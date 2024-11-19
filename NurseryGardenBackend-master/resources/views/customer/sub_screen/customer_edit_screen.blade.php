@extends('layouts.app')

@section('content')
    <div class="row">
        <div class="col-xl">
            <div class="card mb-4">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Edit Role</h5>
                </div>
                <div class="card-body">
                    @foreach ($customers as $customer)
                        <form method="POST"
                            action="{{ route('customer.update', ['id' => $customer->id, 'type' => $customer->type]) }}">
                            @csrf
                            <div class="form-floating form-floating-outline mb-4">
                                <input type="text" id="id" name="id" class="form-control"
                                    id="basic-default-fullname" placeholder="ID" value="{{ $customer->id }}" readonly />
                                <label for="basic-default-fullname">ID</label>
                            </div>
                            <div class="form-floating form-floating-outline mb-4">
                                <select class="form-select" id="selectOption" aria-label="Default select example"
                                    name="type">
                                    <option hidden value="{{ $customer->type }}">
                                        {{ ucfirst(trans($customer->type)) }}</option>
                                    <option value="admin">Admin</option>
                                    <option value="delivery">Delivery Man</option>
                                    <option value="user">User</option>
                                </select>
                                <label for="exampleFormControlSelect1">Type</label>
                            </div>
                            <button type="submit" class="btn btn-primary">Save</button>
                            <a href="{{ route('customer.index') }}" class="btn btn-primary" value="Back">Back</a>
                        </form>
                    @endforeach
                </div>
            </div>
        </div>
    @endsection
