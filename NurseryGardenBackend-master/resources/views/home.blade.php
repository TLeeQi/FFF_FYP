@extends('layouts.app')
@section('content')
    <div class="content-wrapper">
        <!-- Content -->

        <div class="container-xl flex-grow-1 container-p-y">
            @if(Auth::user()->type === 'vendor' && $vendor && $vendor->status != '1')
                @if($vendor->description === 'NULL')
                    <div class="alert alert-warning">
                        Your profile is incomplete. Please <a href="{{ route('verification.verification') }}">update your profile</a> to access the dashboard.
                    </div>
                @else
                    <div class="alert alert-warning">
                        Your profile is pending approved by admins. 
                        Please wait for approval. 
                        You can update your profile <a href="{{ route('verification.verification') }}">here</a> before approval.
                    </div>
                @endif
            @elseif(Auth::user()->type === 'vendor' && $vendor && $vendor->status == '1')
            <div class="row gy-4">
                    <!-- Congratulations card -->
                    <div class="col-md-12 col-lg-4">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title mb-1">Congratulations🎉</h4>
                                <p class="pb-0">{{$vendor->name}} has earned</p>
                                <h4 class="text-primary mb-4 pb-1">RM {{ $totalPayments }}</h4>
                            </div>
                            <img src="../assets/img/icons/misc/triangle-light.png"
                                class="scaleX-n1-rtl position-absolute bottom-0 end-0" width="166" alt="triangle background"
                                data-app-light-img="icons/misc/triangle-light.png"
                                data-app-dark-img="icons/misc/triangle-dark.png" />
                            <img src="../assets/img/illustrations/trophy.png"
                                class="scaleX-n1-rtl position-absolute bottom-0 end-0 me-4 mb-4 pb-2" width="83"
                                alt="view sales" />
                        </div>
                    </div>
                    <!--/ Congratulations card -->

                    <!-- Transactions -->
                    <div class="col-lg-8">
                        <div class="card">
                            <div class="card-header">
                                <div class="d-flex align-items-center justify-content-between">
                                    <h5 class="card-title m-0 me-2">Transactions</h5>
                                    <div class="d-flex">
                                        <div class="d-flex align-items-center me-4">
                                            <div class="avatar">
                                                <div class="avatar-initial bg-primary rounded shadow">
                                                    <i class="mdi mdi-trending-up mdi-24px"></i>
                                                </div>
                                            </div>
                                            <div class="ms-3">
                                                <div class="small mb-1">Sales</div>
                                                <h5 class="mb-0">RM {{ $totalPayments }}</h5>
                                            </div>
                                        </div>
                                        <div class="d-flex align-items-center">
                                            <div class="avatar">
                                                <div class="avatar-initial bg-success rounded shadow">
                                                    <i class="mdi mdi-account-outline mdi-24px"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <p class="mt-3"><span class="fw-medium">Total</span> 😎 </p>
                            </div>
                            <div class="card-body">
                                <div class="row g-3">
                                    <!-- Four Services -->
                                    <div class="col-md-3 col-6">
                                        <div class="d-flex align-items-center">
                                            <div class="avatar">
                                                <div class="avatar-initial bg-warning rounded shadow">
                                                    <i class="mdi mdi-lightning-bolt mdi-24px"></i>
                                                </div>
                                            </div>
                                            <div class="ms-3">
                                                <div class="small mb-1">Wiring</div>
                                                <h5 class="mb-0">{{ $totalWiring }}</h5>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3 col-6">
                                        <div class="d-flex align-items-center">
                                            <div class="avatar">
                                                <div class="avatar-initial bg-info rounded shadow">
                                                    <i class="mdi mdi-pipe mdi-24px"></i>
                                                </div>
                                            </div>
                                            <div class="ms-3">
                                                <div class="small mb-1">Piping</div>
                                                <h5 class="mb-0">{{ $totalPiping }}</h5>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3 col-6">
                                        <div class="d-flex align-items-center">
                                            <div class="avatar">
                                                <div class="avatar-initial bg-success rounded shadow">
                                                    <i class="mdi mdi-tree mdi-24px"></i>
                                                </div>
                                            </div>
                                            <div class="ms-3">
                                                <div class="small mb-1">Gardening</div>
                                                <h5 class="mb-0">{{ $totalGardening }}</h5>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3 col-6">
                                        <div class="d-flex align-items-center">
                                            <div class="avatar">
                                                <div class="avatar-initial bg-info rounded shadow">
                                                    <i class="mdi mdi-run mdi-24px"></i>
                                                </div>
                                            </div>
                                            <div class="ms-3">
                                                <div class="small mb-1">Runner</div>
                                                <h5 class="mb-0">{{ $totalRunner }}</h5>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--/ Transactions -->

                    <!-- Total Earnings -->
                    <div class="col-xl-4 col-md-6">
                        <div class="card">
                            <div class="card-header d-flex align-items-center justify-content-between">
                                <h5 class="card-title m-0 me-2">Total Earning</h5>
                            </div>
                            <div class="card-body">
                                <div class="mb-3 mt-md-3 mb-md-3">
                                    <div class="d-flex align-items-center">
                                        <h2 class="mb-0">RM {{ $totalPayments }}</h2>
                                        <span class="text-success ms-2 fw-medium">
                                            <i class="mdi mdi-menu-up mdi-24px"></i>
                                            <small></small>
                                        </span>
                                    </div>
                                    <small class="mt-1"></small>
                                </div>
                                <ul class="p-0 m-0">
                                    <li class="d-flex pb-md-2">
                                        <div class="avatar flex-shrink-0 me-3">
                                            <img src="../assets/img/icons/misc/zipcar.png" alt="zipcar" class="rounded" />
                                        </div>
                                        <div class="d-flex w-100 flex-wrap align-items-center justify-content-between gap-2">
                                            <div class="me-2">
                                                <h6 class="mb-0">Stripe</h6>
                                                <small>Payment by Card</small>
                                            </div>
                                            <div>
                                                <h6 class="mb-2">RM {{ $totalPayments }}</h6>
                                                <div class="progress bg-label-primary" style="height: 4px">
                                                    <div class="progress-bar bg-primary" style="width: 75%" role="progressbar"
                                                        aria-valuenow="75" aria-valuemin="0" aria-valuemax="100"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <!--/ Total Earnings -->

                    <!-- Four Cards -->
                    <div class="col-xl-4 col-md-6">
                        <div class="row gy-4">
                            <!-- Total Profit Weekly Project -->
                            <div class="col-sm-12 mb-4">
                                <div class="card h-100 shadow-sm rounded">
                                    <div class="card-header d-flex align-items-center justify-content-center">
                                        <div class="avatar">
                                            <div class="avatar-initial bg-primary rounded-circle shadow-sm">
                                                <i class="mdi mdi-poll mdi-24px text-white"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-body text-center">
                                        <h6 class="mb-2">Total Services</h6>
                                        <h4 class="mb-0">{{ $totalServices }} </h4>
                                    </div>
                                </div>
                            </div>
                            <!--/ Total Profit Weekly Project -->
                            <!-- New Yearly Project -->
                            <div class="col-sm-6 mb-4">
                                <div class="card h-100 shadow-sm rounded">
                                    <div class="card-header d-flex align-items-center justify-content-center">
                                        <div class="avatar">
                                            <div class="avatar-initial bg-warning rounded-circle shadow-sm">
                                                <i class="mdi mdi-lightning-bolt mdi-24px text-white"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-body text-center">
                                        <h6 class="mb-2">Total Wiring Booking</h6>
                                        <h4 class="mb-0">{{ $totalWiring }}</h4>
                                    </div>
                                </div>
                            </div>
                            <!--/ New Yearly Project -->
                            <!-- New Yearly Project -->
                            <div class="col-sm-6 mb-4">
                                <div class="card h-100 shadow-sm rounded">
                                    <div class="card-header d-flex align-items-center justify-content-center">
                                        <div class="avatar">
                                            <div class="avatar-initial bg-info rounded-circle shadow-sm">
                                                <i class="mdi mdi-pipe mdi-24px text-white"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-body text-center">
                                        <h6 class="mb-2">Total Piping Booking</h6>
                                        <h4 class="mb-0">{{ $totalPiping }}</h4>
                                    </div>
                                </div>
                            </div>
                            <!--/ New Yearly Project -->
                            <!-- New Yearly Project -->
                            <div class="col-sm-6 mb-4">
                                <div class="card h-100 shadow-sm rounded">
                                    <div class="card-header d-flex align-items-center justify-content-center">
                                        <div class="avatar">
                                            <div class="avatar-initial bg-success rounded-circle shadow-sm">
                                                <i class="mdi mdi-tree mdi-24px text-white"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-body text-center">
                                        <h6 class="mb-2">Total Gardening Booking</h6>
                                        <h4 class="mb-0">{{ $totalGardening }}</h4>
                                    </div>
                                </div>
                            </div>
                            <!--/ New Yearly Project -->
                            <!-- New Yearly Project -->
                            <div class="col-sm-6 mb-4">
                                <div class="card h-100 shadow-sm rounded">
                                    <div class="card-header d-flex align-items-center justify-content-center">
                                        <div class="avatar">
                                            <div class="avatar-initial bg-info rounded-circle shadow-sm">
                                                <i class="mdi mdi-run mdi-24px text-white"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-body text-center">
                                        <h6 class="mb-2">Total Runner Booking</h6>
                                        <h4 class="mb-0">{{ $totalRunner }}</h4>
                                    </div>
                                </div>
                            </div>
                            <!--/ New Yearly Project -->
                        </div>
                    </div>
                    <!--/ Total Earning -->

                    <!-- Sales by Countries -->
                    <div class="col-xl-4 col-md-6">
                        <div class="card">
                            <div class="card-header d-flex align-items-center justify-content-between">
                                <h5 class="card-title m-0 me-2">Sales by Countries</h5>
                            </div>
                            <div class="card-body">
                                <div class="d-flex flex-wrap justify-content-between align-items-center mb-4">
                                    <div class="d-flex align-items-center">
                                        <div class="avatar me-3">
                                            <div class="avatar-initial bg-label-success rounded-circle">MY</div>
                                        </div>
                                        <div>
                                            <div class="d-flex align-items-center gap-1">
                                                <h6 class="mb-0">{{ $totalPayments }}</h6>
                                                <i class="mdi mdi-chevron-up mdi-24px text-success"></i>
                                            </div>
                                            <small>Malaysia - Johor</small>
                                        </div>
                                    </div>                                    
                                </div>
                            </div>
                        </div>
                        <!--/ Sales by Countries -->
                    </div>
                </div>
            @endif
            @if(Auth::user()->type === 'sadmin' || Auth::user()->type === 'admin')
                <div class="row gy-4">
                    <!-- Congratulations card -->
                    <div class="col-md-12 col-lg-4">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title mb-1">Congratulations🎉</h4>
                                <p class="pb-0">The company has earned</p>
                                <h4 class="text-primary mb-4 pb-1">RM {{ $totalPayments }}</h4>
                                {{-- <a href="javascript:;" class="btn btn-sm btn-primary">View Sales</a> --}}
                            </div>
                            <img src="../assets/img/icons/misc/triangle-light.png"
                                class="scaleX-n1-rtl position-absolute bottom-0 end-0" width="166" alt="triangle background"
                                data-app-light-img="icons/misc/triangle-light.png"
                                data-app-dark-img="icons/misc/triangle-dark.png" />
                            <img src="../assets/img/illustrations/trophy.png"
                                class="scaleX-n1-rtl position-absolute bottom-0 end-0 me-4 mb-4 pb-2" width="83"
                                alt="view sales" />
                        </div>
                    </div>
                    <!--/ Congratulations card -->

                    <!-- Transactions -->
                    <div class="col-lg-8">
                        <div class="card">
                            <div class="card-header">
                                <div class="d-flex align-items-center justify-content-between">
                                    <h5 class="card-title m-0 me-2">Transactions</h5>
                                    <div class="d-flex">
                                        <div class="d-flex align-items-center me-4">
                                            <div class="avatar">
                                                <div class="avatar-initial bg-primary rounded shadow">
                                                    <i class="mdi mdi-trending-up mdi-24px"></i>
                                                </div>
                                            </div>
                                            <div class="ms-3">
                                                <div class="small mb-1">Sales</div>
                                                <h5 class="mb-0">RM {{ $totalPayments }}</h5>
                                            </div>
                                        </div>
                                        <div class="d-flex align-items-center">
                                            <div class="avatar">
                                                <div class="avatar-initial bg-success rounded shadow">
                                                    <i class="mdi mdi-account-outline mdi-24px"></i>
                                                </div>
                                            </div>
                                            <div class="ms-3">
                                                <div class="small mb-1">Customers</div>
                                                <h5 class="mb-0">{{ $totalUsers }}</h5>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <p class="mt-3"><span class="fw-medium">Total</span> 😎 </p>
                            </div>
                            <div class="card-body">
                                <div class="row g-3">
                                    <!-- Four Services -->
                                    <div class="col-md-3 col-6">
                                        <div class="d-flex align-items-center">
                                            <div class="avatar">
                                                <div class="avatar-initial bg-warning rounded shadow">
                                                    <i class="mdi mdi-lightning-bolt mdi-24px"></i>
                                                </div>
                                            </div>
                                            <div class="ms-3">
                                                <div class="small mb-1">Wiring</div>
                                                <h5 class="mb-0">{{ $totalWiring }}</h5>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3 col-6">
                                        <div class="d-flex align-items-center">
                                            <div class="avatar">
                                                <div class="avatar-initial bg-info rounded shadow">
                                                    <i class="mdi mdi-pipe mdi-24px"></i>
                                                </div>
                                            </div>
                                            <div class="ms-3">
                                                <div class="small mb-1">Piping</div>
                                                <h5 class="mb-0">{{ $totalPiping }}</h5>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3 col-6">
                                        <div class="d-flex align-items-center">
                                            <div class="avatar">
                                                <div class="avatar-initial bg-success rounded shadow">
                                                    <i class="mdi mdi-tree mdi-24px"></i>
                                                </div>
                                            </div>
                                            <div class="ms-3">
                                                <div class="small mb-1">Gardening</div>
                                                <h5 class="mb-0">{{ $totalGardening }}</h5>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3 col-6">
                                        <div class="d-flex align-items-center">
                                            <div class="avatar">
                                                <div class="avatar-initial bg-info rounded shadow">
                                                    <i class="mdi mdi-run mdi-24px"></i>
                                                </div>
                                            </div>
                                            <div class="ms-3">
                                                <div class="small mb-1">Runner</div>
                                                <h5 class="mb-0">{{ $totalRunner }}</h5>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--/ Transactions -->

                    <!-- Total Earnings -->
                    <div class="col-xl-4 col-md-6">
                        <div class="card">
                            <div class="card-header d-flex align-items-center justify-content-between">
                                <h5 class="card-title m-0 me-2">Total Earning</h5>
                            </div>
                            <div class="card-body">
                                <div class="mb-3 mt-md-3 mb-md-3">
                                    <div class="d-flex align-items-center">
                                        <h2 class="mb-0">RM {{ $totalPayments }}</h2>
                                        <span class="text-success ms-2 fw-medium">
                                            <i class="mdi mdi-menu-up mdi-24px"></i>
                                            <small></small>
                                        </span>
                                    </div>
                                    <small class="mt-1"></small>
                                </div>
                                <ul class="p-0 m-0">
                                    <li class="d-flex pb-md-2">
                                        <div class="avatar flex-shrink-0 me-3">
                                            <img src="../assets/img/icons/misc/zipcar.png" alt="zipcar" class="rounded" />
                                        </div>
                                        <div class="d-flex w-100 flex-wrap align-items-center justify-content-between gap-2">
                                            <div class="me-2">
                                                <h6 class="mb-0">Stripe</h6>
                                                <small>Payment by Card</small>
                                            </div>
                                            <div>
                                                <h6 class="mb-2">RM {{ $totalPayments }}</h6>
                                                <div class="progress bg-label-primary" style="height: 4px">
                                                    <div class="progress-bar bg-primary" style="width: 75%" role="progressbar"
                                                        aria-valuenow="75" aria-valuemin="0" aria-valuemax="100"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <!--/ Total Earnings -->

                    <!-- Four Cards -->
                    <div class="col-xl-4 col-md-6">
                        <div class="row gy-4">
                            <!-- Total Profit Weekly Project -->
                            <div class="col-sm-12 mb-4">
                                <div class="card h-100 shadow-sm rounded">
                                    <div class="card-header d-flex align-items-center justify-content-center">
                                        <div class="avatar">
                                            <div class="avatar-initial bg-primary rounded-circle shadow-sm">
                                                <i class="mdi mdi-poll mdi-24px text-white"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-body text-center">
                                        <h6 class="mb-2">Total Services</h6>
                                        <h4 class="mb-0">{{ $totalServices }} </h4>
                                    </div>
                                </div>
                            </div>
                            <!--/ Total Profit Weekly Project -->
                            <!-- New Yearly Project -->
                            <div class="col-sm-6 mb-4">
                                <div class="card h-100 shadow-sm rounded">
                                    <div class="card-header d-flex align-items-center justify-content-center">
                                        <div class="avatar">
                                            <div class="avatar-initial bg-warning rounded-circle shadow-sm">
                                                <i class="mdi mdi-lightning-bolt mdi-24px text-white"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-body text-center">
                                        <h6 class="mb-2">Total Wiring Booking</h6>
                                        <h4 class="mb-0">{{ $totalWiring }}</h4>
                                    </div>
                                </div>
                            </div>
                            <!--/ New Yearly Project -->
                            <!-- New Yearly Project -->
                            <div class="col-sm-6 mb-4">
                                <div class="card h-100 shadow-sm rounded">
                                    <div class="card-header d-flex align-items-center justify-content-center">
                                        <div class="avatar">
                                            <div class="avatar-initial bg-info rounded-circle shadow-sm">
                                                <i class="mdi mdi-pipe mdi-24px text-white"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-body text-center">
                                        <h6 class="mb-2">Total Piping Booking</h6>
                                        <h4 class="mb-0">{{ $totalPiping }}</h4>
                                    </div>
                                </div>
                            </div>
                            <!--/ New Yearly Project -->
                            <!-- New Yearly Project -->
                            <div class="col-sm-6 mb-4">
                                <div class="card h-100 shadow-sm rounded">
                                    <div class="card-header d-flex align-items-center justify-content-center">
                                        <div class="avatar">
                                            <div class="avatar-initial bg-success rounded-circle shadow-sm">
                                                <i class="mdi mdi-tree mdi-24px text-white"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-body text-center">
                                        <h6 class="mb-2">Total Gardening Booking</h6>
                                        <h4 class="mb-0">{{ $totalGardening }}</h4>
                                    </div>
                                </div>
                            </div>
                            <!--/ New Yearly Project -->
                            <!-- New Yearly Project -->
                            <div class="col-sm-6 mb-4">
                                <div class="card h-100 shadow-sm rounded">
                                    <div class="card-header d-flex align-items-center justify-content-center">
                                        <div class="avatar">
                                            <div class="avatar-initial bg-info rounded-circle shadow-sm">
                                                <i class="mdi mdi-run mdi-24px text-white"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-body text-center">
                                        <h6 class="mb-2">Total Runner Booking</h6>
                                        <h4 class="mb-0">{{ $totalRunner }}</h4>
                                    </div>
                                </div>
                            </div>
                            <!--/ New Yearly Project -->
                        </div>
                    </div>
                    <!--/ Total Earning -->

                    <!-- Sales by Countries -->
                    <div class="col-xl-4 col-md-6">
                        <div class="card">
                            <div class="card-header d-flex align-items-center justify-content-between">
                                <h5 class="card-title m-0 me-2">Sales by Countries</h5>
                            </div>
                            <div class="card-body">
                                <div class="d-flex flex-wrap justify-content-between align-items-center mb-4">
                                    <div class="d-flex align-items-center">
                                        <div class="avatar me-3">
                                            <div class="avatar-initial bg-label-success rounded-circle">MY</div>
                                        </div>
                                        <div>
                                            <div class="d-flex align-items-center gap-1">
                                                <h6 class="mb-0">{{ $totalPayments }}</h6>
                                                <i class="mdi mdi-chevron-up mdi-24px text-success"></i>
                                            </div>
                                            <small>Malaysia - Johor</small>
                                        </div>
                                    </div>
                                    <div class="text-end">
                                        <h6 class="mb-0">{{ $totalOrder }}</h6>
                                        <small>Total Order</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--/ Sales by Countries -->
                    </div>
                </div>
            @endif
        </div>
    </div>
@endsection
