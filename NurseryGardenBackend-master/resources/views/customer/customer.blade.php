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

    <p class="display-5">Customers</p>

    <!-- Search -->
    <form action="{{ route('customer.search') }}" method="POST">
        @csrf
        <div class="navbar-nav align-items-left">
            <div class="nav-item d-flex align-items-left">
                <i class="mdi mdi-magnify mdi-24px lh-0"></i>
                <input type="search" class="form-control border-0 shadow-none bg-body" id="name" name="name"
                    placeholder="Search..." aria-label="Search..." />
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
                            <th class="text-truncate">Name</th>
                            <th class="text-truncate">Email</th>
                            @if (Auth::user()->type == 'sadmin')
                                <th class="text-truncate">Role</th>
                            @endif
                            <th class="text-truncate">Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($customers as $customer)
                            <tr>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <p class="fw-bold mb-1">{{ $customer->id }}</p>
                                    </div>
                                </td>
                                <td class="text-truncate">
                                    <p class="fw-normal mb-1">{{ $customer->name }}</p>
                                </td>
                                <td class="text-truncate">
                                    <p class="fw-normal mb-1">{{ $customer->email }}</p>
                                </td>
                                @if (Auth::user()->type == 'sadmin')
                                    <td class="text-truncate">
                                        <p class="fw-normal mb-1">
                                            @if ($customer->type == 'sadmin')
                                                {{ $customer->type }}
                                            @else
                                                <a href="{{ route('customer.edit', $customer->id) }}">{{ $customer->type }}
                                            @endif

                                        </p></a>

                                    </td>
                                @endif
                                <td>
                                    <span class="badge bg-label-success rounded-pill">Active</span>
                                </td>
                            </tr>
                        @endforeach

                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <!--/ Data Tables -->
    <div class="m-4 d-flex justify-content-between">
        {{-- {{ $customer->links('pagination.using-post') }} --}}
        {!! $customers->links('vendor.pagination.bootstrap-5') !!}
    </div>
@endsection
