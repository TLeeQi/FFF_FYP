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

    <p class="display-5">Categories</p>

    <!-- Search -->
    <form action="{{ route('category.search') }}" method="POST">
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
                            <th class="text-truncate">Type</th>
                            <th class="text-truncate">Action</th>
                            <th class="text-truncate">Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        @if (count($category) < 1)
                            <tr>
                                <td class="text-truncate">
                                    <p class="fw-normal mb-1">Data no found.</p>
                                </td>
                            </tr>
                        @else
                            @foreach ($category as $categories)
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <p class="fw-bold mb-1">{{ $categories->id }}</p>
                                        </div>
                                    </td>
                                    <td class="text-truncate">
                                        <p class="fw-normal mb-1">{{ $categories->name }}</p>
                                    </td>
                                    <td class="text-truncate">
                                        <p class="fw-normal mb-1">{{ $categories->type }}</p>
                                    </td>
                                    <td class="text-truncate">
                                        <a class="navbar-brand" href="{{ route('category.edit', $categories->id) }}">
                                            <i class="mdi mdi-pencil-box-outline mdi-24px lh-0"></i>
                                        </a>

                                        <a class="navbar-brand"
                                            onclick="return confirm('Are you sure you want to change the status?')"
                                            href="{{ route('category.delete', $categories->id) }}">
                                            @if ($categories->status == 0)
                                                <i class="mdi mdi-checkbox-blank-outline mdi-24px lh-0"></i>
                                            @else
                                                <i class="mdi mdi-checkbox-marked-outline mdi-24px lh-0"></i>
                                            @endif

                                        </a>
                                    </td>

                                    @if ($categories->status == 0)
                                        <td>
                                            <span class="badge bg-label-danger rounded-pill">Disabled</span>
                                        </td>
                                    @else
                                        <td>
                                            <span class="badge bg-label-success rounded-pill">Active</span>
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
        {{-- {{ $customer->links('pagination.using-post') }} --}}
        {!! $category->links('vendor.pagination.bootstrap-5') !!}
    </div>
@endsection
