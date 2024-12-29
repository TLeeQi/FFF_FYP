@extends('layouts.app')
@section('content')
    <!-- Basic Layout -->
    <div class="row">
        <div class="col-xl">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Order Status</h5>
                </div>
                <div class="card-body">
                    <div class="card-body row">
                        <div class="col-md-6 col-lg-4">
                            <div class="card">
                                <div class="card-body">
                                    <blockquote class="blockquote mb-0">
                                        <p>
                                            @foreach ($orders as $order)
                                                <b>Order ID:</b> {{ $order->id }} <br>
                                                <b>Order Date:</b> {{ Carbon\Carbon::parse($order->date)->format('d/m/Y') }}
                                                <br>
                                                <b>Order Address:</b><br> {{ $order->address }}<br><br>
                                                <b>Order Status:</b>
                                                <span class="badge bg-label-info rounded-pill">
                                                    {{ ucfirst($order->status) }} for delivery</span>
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

                        <div class="card-header d-flex justify-content-between align-items-center px-0">
                            <h5 class="mb-0 mt-2">Select the Item to pack</h5>
                        </div>


                        {{-- Delivery Out --}}
                        <!-- Data Tables -->
                        <div class="col-12 mt-3">
                            <div class="card">
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead class="table-light">
                                            <tr>
                                                <th class="text-truncate col-1">Checkout</th>
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
                                                    @if ($order_item[$i]->remark == true)
                                                        <td>
                                                            <i class="mdi mdi-check mdi-24px"></i>
                                                        </td>
                                                    @else
                                                        <td>
                                                            <span class="form-check mb-0">
                                                                <input class="form-check-input me-1" type="checkbox"
                                                                    name="cid[]" id="cid[]"
                                                                    value="{{ $order_item[$i]->id }}" onclick="cal()" />

                                                            </span>
                                                        </td>
                                                    @endif
                                                    <td>
                                                        <div class="d-flex align-items-center">
                                                            <p class="fw-normal mb-1">{{ $i + 1 }}</p>
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
                                                                    <p class="fw-normal mb-1">{{ $plant->name }}
                                                                    </p>
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
                                                                    <p class="fw-normal mb-1">{{ $product->name }}
                                                                    </p>
                                                                </td>
                                                                <td class="text-truncate">
                                                                    <p class="fw-normal mb-1">RM
                                                                        {{ number_format($product->price, 2) }}</p>
                                                                </td>
                                                            @endif
                                                        @endforeach
                                                    @endif
                                                    <td class="text-truncate">
                                                        <p class="fw-normal mb-1">{{ $order_item[$i]->quantity }}
                                                        </p>
                                                    </td>
                                                    <td class="text-truncate">
                                                        <p class="fw-normal mb-1">RM
                                                            {{ number_format($order_item[$i]->amount, 2) }}
                                                        </p>
                                                    </td>
                                                </tr>
                                            @endfor


                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        @if ($isfull != true)
                            <div class="card mb-4 mt-5 p-4 mx-2">

                                <div class="card-header d-flex justify-content-between align-items-center my-3 px-0">
                                    <h5 class="mb-0">Create a new delivery</h5>
                                </div>
                                <form method="POST" action="{{ route('delivery.update', ['order_id' => $order->id]) }}"
                                    onsubmit="return getSelectedOption() ">
                                    @csrf
                                    <input type="hidden" name="items[]" id="items[]" value="">
                                    <input type="hidden" name="status" id="status" value="prepare">

                                    <div class="form-floating form-floating-outline mb-4">
                                        <input type="text" id="method" name="method" class="form-control"
                                            id="basic-default-fullname" placeholder="Delivery Company" required />
                                        <label for="basic-default-fullname">Delivery company</label>
                                    </div>
                                    <div class="form-floating form-floating-outline mb-4">
                                        <input type="text" id="track_num" name="track_num" class="form-control"
                                            id="basic-default-fullname" placeholder="Tracking Number" required />
                                        <label for="basic-default-fullname">Tracking Number</label>
                                    </div>
                                    <div class="form-floating form-floating-outline mb-4">
                                        <input class="form-control" type="date" id="html5-date-input" required
                                            name="expected_date" />
                                        <label for="html5-date-input">Expected date</label>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Save</button>
                                </form>
                            </div>
                        @endif

                        <div class="card mb-4 mt-5 p-4 mx-2">
                            <p>Please go to the <a href="{{ route('delivery.search', ['name' => $order->id]) }}">delivery
                                    page</a>
                                to update the
                                delivery status</p>
                        </div>



                    </div>


                    <script>
                        //Calculate the total price
                        function cal() {
                            var items = document.getElementsByName('items[]');
                            var cboxes = document.getElementsByName('cid[]');

                            var id = [];
                            var len = cboxes.length;

                            for (var i = 0; i < len; i++) {
                                if (cboxes[i].checked) {
                                    id.push(cboxes[i].value);
                                }
                            }
                            document.getElementById('items[]').value = id;
                        }

                        function getSelectedOption() {
                            var selectedItem = document.getElementById('items[]').value;
                            console.log(selectedItem);
                            if (selectedItem === "") {
                                alert("Please tick the item you want to deliever at first");
                                return false; // Prevent form submission
                            }

                            var selectElement = document.getElementById("selectOption");
                            var selectedOptionValue = selectElement.value;

                            if (selectedOptionValue === "pack") {
                                alert("Please update the delivery status of the order");
                                return false; // Prevent form submission
                            } else {
                                // You can now use the selectedOptionValue in your further processing
                                return true; // Allow form submission
                            }
                        }

                        function validateCompleted() {
                            var selectElement = document.getElementById("selectOption");
                            var selectedOptionValue = selectElement.value;

                            if ((selectedOptionValue === "Confirmed" && frame.src === "") ||
                                (selectedOptionValue === "prepare" && frame.src !== "")
                            ) {
                                alert("Please update the delivery status of the order and ensure the prove of delivery is updated");
                                return false; // Prevent form submission
                            } else {
                                // You can now use the selectedOptionValue in your further processing
                                return true; // Allow form submission
                            }
                        }

                        function preview() {
                            frame.src = URL.createObjectURL(event.target.files[0]);
                        }

                        function clearImage() {
                            document.getElementById('formFile').value = null;
                            frame.src = "";
                        }
                    </script>

                @endsection
