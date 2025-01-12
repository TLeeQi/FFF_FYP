@extends('layouts.app')
@section('content')
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

    <p class="display-5">Profile Update</p>

    <form method="POST" action="{{ route('verification.update') }}" enctype="multipart/form-data">
        @csrf
        <div class="row mb-3">
            <div class="col-md-2">
                <label for="id" class="form-label">ID</label>
                <input type="text" class="form-control" id="id" name="id" value="{{$user->id}}" readonly>
            </div>
            <div class="col-md-10">
                <label for="name" class="form-label">Name</label>
                <input type="text" class="form-control" id="name" name="name" value="{{$user->name}}" required>
            </div>
        </div>

        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="email" class="form-control" id="email" name="email" value="{{$user->email}}" required>
        </div>

        <div class="mb-3">
            <label for="phone" class="form-label">Phone</label>
            <input type="text" class="form-control" id="contact_number" name="contact_number" value="{{$user->contact_number}}" required>
        </div>

        <div class="mb-3">
            <label for="address" class="form-label">Address</label>
            <input type="text" class="form-control" id="address" name="address" value="{{$user->address}}" required>
        </div>

        <div class="mb-3">
            <label for="image" class="form-label">Profile Image</label>
            <input type="file" class="form-control" id="image" name="image" accept="image/*" 
                   {{ $user->image ? '' : 'required' }} onchange="previewImage(event)">
        </div>

        <!-- Image Preview Section -->
        <div class="mb-3">
            <img id="imagePreview" 
                 src="{{ $user->image ? asset('user_image/' . $user->image) : '#' }}" 
                 alt="Image Preview" 
                 style="display: {{ $user->image ? 'block' : 'none' }}; max-width: 200px; max-height: 200px; width: auto; height: auto;" />
        </div>

        <div class="mb-3">
            <label for="description" class="form-label">Description</label>
            <textarea class="form-control" id="description" name="description" rows="3" required>{{ $vendor->description ?? '' }}</textarea>
        </div>

        @if($vendor->status == 0)
            <div class="mb-3">
                <label for="ssm" class="form-label">SSM Document (PDF, DOC, DOCX, JPG, JPEG, PNG)</label>
                <input type="file" class="form-control" id="ssm" name="ssm" accept=".pdf,.doc,.docx,.jpg,.jpeg,.png" required>
                @if($vendor->ssm_path)
                    <p>Current SSM Document: 
                        <a href="{{ asset('ssm_files/' . $vendor->ssm_path) }}" target="_blank">{{ basename($vendor->ssm_path) }}</a>
                    </p>
                @else
                    <p>No document uploaded yet.</p>
                @endif
            </div>
        @elseif($vendor->status == 1 && $vendor->ssm_path)
            <div class="mb-3">
                <p>SSM Document: <a href="{{ asset('ssm_files/' . $vendor->ssm_path) }}" target="_blank">View Document</a></p>
            </div>
        @elseif($vendor->status == 2)
        <div class="mb-3">
            <label for="ssm" class="form-label">SSM Document (PDF, DOC, DOCX, JPG, JPEG, PNG)</label>
            <input type="file" class="form-control" id="ssm" name="ssm" accept=".pdf,.doc,.docx,.jpg,.jpeg,.png">
            
            @if($vendor->ssm_path)
                <p>Current SSM Document: 
                    <a href="{{ asset('ssm_files/' . $vendor->ssm_path) }}" target="_blank">{{ basename($vendor->ssm_path) }}</a>
                </p>
            @else
                <p>No document uploaded yet.</p>
            @endif
        </div>
        @endif

        @if($vendor->rating != 'NULL')
            <div class="mb-3">
                <label for="rating" class="form-label">Rating</label>
                <input type="number" class="form-control" id="rating" name="rating" value="{{$vendor->rating}}" readonly>
            </div>
        @endif

        <button type="submit" class="btn btn-primary">Submit</button>


    <script>
        function previewImage(event) {
            var reader = new FileReader();
            reader.onload = function() {
                var output = document.getElementById('imagePreview');
                output.src = reader.result;
                output.style.display = 'block';
            }
            reader.readAsDataURL(event.target.files[0]);
        }
    </script>

    @if ($errors->any())
        <div class="alert alert-danger">
            <ul>
                @foreach ($errors->all() as $error)
                    <li>{{ $error }}</li>
                @endforeach
            </ul>
        </div>
    @endif
@endsection
