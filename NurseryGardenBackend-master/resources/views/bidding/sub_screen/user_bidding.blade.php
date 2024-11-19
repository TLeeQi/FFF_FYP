@extends('layouts.app')

@section('content')
    <p class="display-5">Bidding ID: {{ $bidding->id }}</p>

    <!-- Search -->
    <form action="{{ route('bidding.paymentHistorySearch', ['bidding_id' => $bidding->id]) }}" method="POST">
        @csrf
        <div class="navbar-nav align-items-left">
            <div class="nav-item d-flex align-items-left">
                <i class="mdi mdi-magnify mdi-24px lh-0"></i>
                <input type="search" class="form-control border-0 shadow-none bg-body" id="name" name="name"
                    placeholder="Search by User ID" aria-label="Search..." />
            </div>
        </div>
    </form>

    <p class="display-7 mt-3">Payment Detail</p>

    <!-- Data Tables -->
    <div class="col-12 mt-3">
        <div class="card">
            <div class="table-responsive">
                <table class="table">
                    <thead class="table-light">
                        <tr>
                            <th class="text-truncate">ID</th>
                            <th class="text-truncate">Amount</th>
                            <th class="text-truncate">Status</th>
                            <th class="text-truncate">Method</th>
                            <th class="text-truncate">Date</th>
                            <th class="text-truncate">User ID</th>
                        </tr>
                    </thead>
                    <tbody>
                        @if (count($payment) < 1)
                            <tr>
                                <td class="text-truncate">
                                    <p class="fw-normal mb-1">Data no found.</p>
                                </td>
                            </tr>
                        @else
                            @foreach ($payment as $payments)
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <p class="fw-bold mb-1">{{ $payments->id }}</p>
                                        </div>
                                    </td>

                                    <td class="text-truncate">
                                        <p class="fw-normal mb-1">RM {{ $payments->amount }}</p>
                                    </td>
                                    @if ($payments->status == 'pending')
                                        <td>
                                            <span class="badge bg-label-danger rounded-pill">Pending</span>
                                        </td>
                                    @elseif($payments->status == 'success')
                                        <td>
                                            <span class="badge bg-label-success rounded-pill">Success</span>
                                        </td>
                                    @endif
                                    <td class="text-truncate">
                                        <p class="fw-normal mb-1">{{ $payments->method }}</p>
                                    </td>
                                    <td class="text-truncate">
                                        <p class="fw-normal mb-1">{{ $payments->date }}</p>
                                    </td>
                                    <td class="text-truncate">
                                        <p class="fw-normal mb-1">{{ $payments->user_id }}</p>
                                    </td>
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
        {!! $payment->render() !!}
    </div>
@endsection
