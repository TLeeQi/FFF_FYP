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
    <p class="display-5">Plants</p>

    <!-- Search -->
    <form action="{{ route('plant.search') }}" method="POST">
        @csrf
        <div class="navbar-nav align-items-left">
            <div class="nav-item d-flex align-items-left">
                <i class="mdi mdi-magnify mdi-24px lh-0"></i>
                <input type="search" class="form-control border-0 shadow-none bg-body" id="name" name="name"
                    placeholder="Search..." aria-label="Search..." />
            </div>
        </div>
    </form>

    <!-- Data Tables -->
    <div class="col-12 mt-3">
        <div class="card">
            <div class="table-responsive">
                <table class="table">
                    <thead class="table-light">
                        <tr>
                            <th class="text-truncate">ID</th>
                            <th class="text-truncate">Image</th>
                            <th class="text-truncate">Name</th>
                            <th class="text-truncate">Category</th>
                            <th class="text-truncate">Quantity</th>
                            <th class="text-truncate">Price</th>
                            <th class="text-truncate">Origin</th>
                            <th class="text-truncate">Sunlight</th>
                            <th class="text-truncate">Water</th>
                            <th class="text-truncate">Height</th>
                            <th class="text-truncate">Action</th>
                            <th class="text-truncate">Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        @if (count($plant) < 1)
                            <tr>
                                <td class="text-truncate">
                                    <p class="fw-normal mb-1">Data no found.</p>
                                </td>
                            </tr>
                        @else
                            @foreach ($plant as $plants)
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <p class="fw-bold mb-1">{{ $plants->id }}</p>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <img src="{{ asset('plant_image') }}/{{ $plants->image }}" class="img-fluid"
                                                style="height:100px; width:100px; object-fit: contain;">
                                        </div>
                                    </td>

                                    <td class="text-truncate">
                                        <p class="fw-normal mb-1">{{ Str::limit($plants->name, 10) }}</p>
                                    </td>
                                    <td class="text-truncate">
                                        <p class="fw-normal mb-1">{{ $plants->cat_name }}</p>
                                    </td>
                                    <td class="text-truncate">
                                        <p class="fw-normal mb-1">{{ $plants->quantity }}</p>
                                    </td>
                                    <td class="text-truncate">
                                        <p class="fw-normal mb-1">{{ $plants->price }}</p>
                                    </td>
                                    <td class="text-truncate">
                                        <p class="fw-normal mb-1">{{ Str::limit($plants->origin, 10) }}</p>
                                    </td>
                                    <td class="text-truncate">
                                        <p class="fw-normal mb-1">{{ $plants->sunlight_need }}</p>
                                    </td>
                                    <td class="text-truncate">
                                        <p class="fw-normal mb-1">{{ $plants->water_need }}</p>
                                    </td>
                                    <td class="text-truncate">
                                        <p class="fw-normal mb-1">{{ $plants->mature_height }}</p>
                                    </td>


                                    <td class="text-truncate">
                                        <a class="navbar-brand" href="{{ route('plant.edit', $plants->id) }}">
                                            <i class="mdi mdi-pencil-box-outline mdi-24px lh-0"></i>
                                        </a>
                                        @if ($plants->status != 'custom' && $plants->status != 'bid')
                                            <a class="navbar-brand"
                                                onclick="return confirm('Are you sure you want to change the status?')"
                                                href="{{ route('plant.delete', $plants->id) }}">
                                                @if ($plants->status == 0)
                                                    <i class="mdi mdi-checkbox-blank-outline mdi-24px lh-0"></i>
                                                @else
                                                    <i class="mdi mdi-checkbox-marked-outline mdi-24px lh-0"></i>
                                                @endif

                                            </a>
                                        @endif
                                    </td>

                                    @if ($plants->status == 0)
                                        <td>
                                            <span class="badge bg-label-danger rounded-pill">Disabled</span>
                                        </td>
                                    @elseif($plants->status == 1)
                                        <td>
                                            <span class="badge bg-label-success rounded-pill">Active</span>
                                        </td>
                                    @elseif($plants->status == 'custom')
                                        <td>
                                            <span class="badge bg-label-warning rounded-pill">Custom</span>
                                        </td>
                                    @elseif($plants->status == 'bid')
                                        <td>
                                            <span class="badge bg-label-info rounded-pill">Bidding</span>
                                        </td>
                                    @endif
                                </tr>
                            @endforeach
                        @endif
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!--/ Data Tables -->
    <div class="m-4 d-flex justify-content-between">
        {!! $plant->render() !!}
    </div>
@endsection
