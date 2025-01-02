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
    <p class="display-5">Ongoing Booking List</p>

    <!-- Search -->
    <form action="{{ route('delivery.search') }}" method="POST">
        @csrf
        <div class="navbar-nav align-items-left">
            <div class="nav-item d-flex align-items-left">
                <i class="mdi mdi-magnify mdi-24px lh-0"></i>
                <input type="search" class="form-control border-0 shadow-none bg-body" id="name" name="name"
                    placeholder="Search the services by order ID..." aria-label="Search..." />
            </div>
        </div>
    </form>
    <!-- /Search -->

    <!-- Data Tables -->
    <div class="col-12 mt-3">
        <div class="card">
            <div class="table-responsive">
                <table class="table">
                    <thead class="table-light">
                        <tr>
                            <th class="text-truncate">ID</th>
                            <th class="text-truncate">Order ID</th>
                            <th class="text-truncate">Service Provider Company</th>
                            <th class="text-truncate">Contact Number</th>
                            <th class="text-truncate">Prepare Date</th>
                            <th class="text-truncate">Action</th>
                            <th class="text-truncate">Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        @if (count($delivery) < 1)
                            <tr>
                                <td class="text-truncate">
                                    <p class="fw-normal mb-1">Data no found.</p>
                                </td>
                            </tr>
                        @else
                            @foreach ($delivery as $deliver)
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <p class="fw-bold mb-1">{{ $deliver->id }}</p>
                                        </div>
                                    </td>

                                    <td>
                                        <div class="d-flex align-items-center">
                                            <a href="{{ route('order.detail', $deliver->order_id) }}">
                                                <p class=" mb-1">{{ $deliver->order_id }}</p>
                                            </a>
                                        </div>
                                    </td>


                                    <td>
                                        <div class="d-flex align-items-center">
                                            <p class=" mb-1">{{ $deliver->method }}</p>
                                        </div>
                                    </td>

                                    <td class="text-truncate">
                                        <p class="fw-normal mb-1">{{ $deliver->tracking_number }}</p>
                                    </td>

                                    <td class="text-truncate">
                                        <div class="d-flex align-items-center ">
                                            <p class="fw-normal mb-1">
                                                {{ Carbon\Carbon::parse($deliver->created_at)->format('d/m/Y') }}
                                            </p>
                                        </div>
                                    </td>


                                    <td class="text-truncate">
                                        <div class="d-flex align-items-center ">
                                            <a class="navbar-brand" href="{{ route('delivery.detail', $deliver->id) }}">
                                                <i class="mdi mdi-pencil-box-outline mdi-24px lh-0"></i>
                                            </a>
                                        </div>
                                    </td>

                                    <td>
                                        @if ($deliver->status == 'prepare')
                                            <span class="badge bg-label-success rounded-pill">{{ $deliver->status }}</span>
                                        @else
                                            <span class="badge bg-label-primary rounded-pill">{{ $deliver->status }}</span>
                                        @endif
                                    </td>



                                    {{-- @if ($categories->status == 0)
                                        <td>
                                            <span class="badge bg-label-danger rounded-pill">Disabled</span>
                                        </td>
                                    @else
                                        <td>
                                            <span class="badge bg-label-success rounded-pill">Active</span>
                                        </td>
                                    @endif --}}
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
        {{-- {{ $customer->links('pagination.using-post') }} --}}
        {!! $delivery->links('vendor.pagination.bootstrap-5') !!}
    </div>
@endsection
