@extends('layouts.app')

@section('content')
<div class="container mt-5">
    {{-- Session Message --}}
    @if (Session::has('error'))
        <div class="alert alert-danger" role="alert">
            {{ Session::get('error') }}
        </div>
        {{ session()->forget('error') }}
    @endif
    @if (Session::has('success'))
        <div class="alert alert-success" role="alert">
            {{ Session::get('success') }}
        </div>
        {{ session()->forget('success') }}
    @endif

    <h1 class="mb-4">Vendors</h1>

    <div class="row">
            <div class="col-md-4 mb-4">
                <div class="card h-100">
                    @if(!empty($vendor->image))
                        <img src="{{ asset('user_image/' . $vendor->image) }}" class="card-img-top" alt="{{ $vendor->name }}'s Profile Image" style="max-width: 100px; max-height: 100px;">
                        <div class="card-body">
                            <h5 class="card-text">Vendor ID: {{ $vendor->vendor_id }}</h5>
                            <h5 class="card-title">{{ $vendor->name }}</h5>
                            <p class="card-text"><strong>Email:</strong> {{ $vendor->email }}</p>
                            <p class="card-text"><strong>Contact Number:</strong> {{ $vendor->contact_number }}</p>
                            <p class="card-text"><strong>Address:</strong> {{ $vendor->address }}</p>
                            <p class="card-text"><strong>Description:</strong> {{ $vendor->description }}</p>
                            <!-- <p class="card-text"><strong>Rating:</strong> {{ $vendor->rating }}</p> -->
                            <p class="card-text"><strong>Category:</strong> {{ $vendor->category }}</p>
                            <a href="{{ asset('ssm_files/' . $vendor->ssm_path) }}" class="btn btn-primary" target="_blank">View SSM File</a>
                        </div>
                        @if($vendor->vendor_status == '0')
                            <div class="card-footer">
                            <p class="fw-normal mb-1">
                                        <a href="{{ route('vendor.verify', $vendor->vendor_id) }}" class="btn btn-primary">Verify</a>
                                    </p>
                            </div>
                        @else
                            <div class="card-footer" style="color: green;">Status: Verified </div>
                        @endif
                    @else
                        <div class="card-body">
                            <p class="card-text">No details updated yet</p>
                        </div>
                    @endif
                </div>
            </div>
    </div>
</div>
@endsection
