@extends('layouts.app')

@section('content')
    <!-- Basic Layout -->
    <div class="row">
        <div class="col-xl">
            <div class="card mb-4">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Order Detail</h5>
                </div>
                <div class="card-body">
                    <div class="col-md-6 col-lg-4 mb-4">
                        <div class="card">
                            <div class="card-body">
                                <blockquote class="blockquote mb-0">

                                    <p>
                                        @foreach ($orders as $order)
                                            Order ID: {{ $order->id }} <br>
                                            Order Date: {{ Carbon\Carbon::parse($order->date)->format('d/m/Y') }} <br>
                                            @if ($order->note != null)
                                                Order Note: {{ $order->note }} <br>
                                            @endif
                                            Order Status:
                                            @if ($order->status == 'pay')
                                                <span class="badge bg-label-secondary rounded-pill">To
                                                    {{ ucfirst($order->status) }}</span>
                                            @elseif ($order->status == 'ship')
                                                <span class="badge bg-label-warning rounded-pill">To
                                                    {{ ucfirst($order->status) }}</span>
                                            @elseif ($order->status == 'receive')
                                                <span class="badge bg-label-primary rounded-pill">To
                                                    {{ ucfirst($order->status) }}</span>
                                            @elseif (strtolower($order->status) == 'completed')
                                                <span
                                                    class="badge bg-label-success rounded-pill">{{ ucfirst($order->status) }}</span>
                                            @elseif (strtolower($order->status) == 'partial')
                                                <span
                                                    class="badge bg-label-info rounded-pill">{{ ucfirst($order->status) }}</span>
                                            @else
                                                <span
                                                    class="badge bg-label-danger rounded-pill">{{ ucfirst($order->status) }}</span>
                                            @endif
                                        @endforeach

                                    </p>
                                    <footer class="blockquote-footer  mt-1">
                                        @foreach ($user as $users)
                                            <cite title="Order Owner">{{ $users->name }}</cite>
                                        @endforeach
                                    </footer>
                                </blockquote>
                            </div>
                        </div>
                    </div>

                    {{-- Delivery Out --}}
                    <form method="POST" action=""">
                        @csrf
                        <!-- Data Tables -->
                        <div class="col-12 mt-3">
                            <div class="card">
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead class="table-light">
                                            <tr>
                                                <th class="text-truncate col-1">No</th>
                                                <th class="text-truncate col-1">Item Picture</th>
                                                <th class="text-truncate col-1">Item Name</th>
                                                <th class="text-truncate col-1">Price</th>
                                                <th class="text-truncate col-1">Quantity</th>
                                                <th class="text-truncate col-1">Total amount</th>
                                            </tr>

                                        </thead>
                                        <tbody>
                                            @for ($i = 0; $i < count($order_item); $i++)
                                                <tr>
                                                    <td>
                                                        <div class="d-flex align-items-center">
                                                            <p class="fw-normal mb-1">{{ $i + 1 }}</p>
                                                            {{-- <p class="fw-normal mb-1">{{ $order_item[$i]->id }}</p> --}}
                                                        </div>
                                                    </td>
                                                    @if (!is_null($order_item[$i]->plant_id))
                                                        @foreach ($item_detail['plant'] as $plant)
                                                            @if ($plant->id == $order_item[$i]->plant_id)
                                                                <td>
                                                                    <div class="d-flex align-items-center">
                                                                        <img src="{{ asset('plant_image') }}/{{ $plant->image }}"
                                                                            class="img-fluid"
                                                                            style="height:100px; width:100px; object-fit: contain;">
                                                                    </div>
                                                                </td>
                                                                <td class="text-truncate">
                                                                    <p class="fw-normal mb-1">{{ $plant->name }}</p>
                                                                </td>
                                                                <td class="text-truncate">
                                                                    <p class="fw-normal mb-1">RM
                                                                        {{ number_format($plant->price, 2) }}</p>
                                                                </td>
                                                            @endif
                                                        @endforeach
                                                    @elseif (!is_null($order_item[$i]->product_id))
                                                        @foreach ($item_detail['product'] as $product)
                                                            @if ($product->id == $order_item[$i]->product_id)
                                                                <td>
                                                                    <div class="d-flex align-items-center">
                                                                        <img src="{{ asset('product_image') }}/{{ $product->image }}"
                                                                            class="img-fluid"
                                                                            style="height:100px; width:100px; object-fit: contain;">
                                                                    </div>
                                                                </td>
                                                                <td class="text-truncate">
                                                                    <p class="fw-normal mb-1">{{ $product->name }}</p>
                                                                </td>
                                                                <td class="text-truncate">
                                                                    <p class="fw-normal mb-1">RM
                                                                        {{ number_format($product->price, 2) }}</p>
                                                                </td>
                                                            @endif
                                                        @endforeach
                                                    @endif
                                                    <td class="text-truncate">
                                                        <p class="fw-normal mb-1">{{ $order_item[$i]->quantity }}</p>
                                                    </td>
                                                    <td class="text-truncate">
                                                        <p class="fw-normal mb-1">RM
                                                            {{ number_format($order_item[$i]->amount, 2) }}
                                                        </p>
                                                    </td>
                                                </tr>
                                            @endfor
                                            <tr>
                                                <td colspan="5">
                                                    <p class="fw-normal my-3 d-flex align-items-center justify-content-end">
                                                        <b>Total Amount</b>
                                                    </p>
                                                </td>
                                                <td colspan="1">
                                                    <p class="fw-normal my-3"> <b>RM
                                                            {{ number_format($order->total_amount, 2) }}</b>
                                                    </p>
                                                </td>
                                            </tr>


                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    @endsection
