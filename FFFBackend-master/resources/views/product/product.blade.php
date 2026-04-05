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
    <p class="display-5">Services</p>

    <!-- Search -->
    <form action="{{ route('product.search') }}" method="POST">
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
                            <!-- <th class="text-truncate">Category</th>
                            <th class="text-truncate">Quantity</th> -->
                            <th class="text-truncate">Deposit (RM)</th>
                            <th class="text-truncate">Action</th>
                            <th class="text-truncate">Status</th>
                        </tr>

                    </thead>
                    <tbody>
                        @if (count($product) < 1)
                            <tr>
                                <td class="text-truncate">
                                    <p class="fw-normal mb-1">Data no found.</p>
                                </td>
                            </tr>
                        @else
                            @foreach ($product as $products)
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <p class="fw-bold mb-1">{{ $products->id }}</p>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <img src="{{ asset('product_image') }}/{{ $products->image }}" class="img-fluid"
                                                style="height:100px; width:100px; object-fit: contain;">
                                        </div>
                                    </td>

                                    <td class="text-truncate">
                                        <p class="fw-normal mb-1">{{ $products->name }}</p>
                                    </td>
                                    <!-- <td class="text-truncate">
                                        <p class="fw-normal mb-1">{{ $products->cat_name }}</p>
                                    </td>
                                    <td class="text-truncate">
                                        <p class="fw-normal mb-1">{{ $products->quantity }}</p>
                                    </td> -->
                                    <td class="text-truncate">
                                        <p class="fw-normal mb-1">{{ $products->price }}</p>
                                    </td>

                                    <td class="text-truncate">
                                        <a class="navbar-brand" href="{{ route('product.edit', $products->id) }}">
                                            <i class="mdi mdi-pencil-box-outline mdi-24px lh-0"></i>
                                        </a>

                                        @if ($products->status != 'custom')
                                            <a class="navbar-brand"
                                                onclick="return confirm('Are you sure you want to change the status?')"
                                                href="{{ route('product.delete', $products->id) }}">
                                                @if ($products->status == 0)
                                                    <i class="mdi mdi-checkbox-blank-outline mdi-24px lh-0"></i>
                                                @else
                                                    <i class="mdi mdi-checkbox-marked-outline mdi-24px lh-0"></i>
                                                @endif
                                            </a>
                                        @endif
                                    </td>

                                    @if ($products->status == '0')
                                        <td>
                                            <span class="badge bg-label-danger rounded-pill">Disabled</span>
                                        </td>
                                    @elseif($products->status == '1')
                                        <td>
                                            <span class="badge bg-label-success rounded-pill">Active</span>
                                        </td>
                                    @elseif($products->status == 'custom')
                                        <td>
                                            <span class="badge bg-label-warning rounded-pill">Custom</span>
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
        {!! $product->render() !!}
    </div>

@endsection
