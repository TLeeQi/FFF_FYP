@extends('layouts.app')

@section('content')
    @foreach ($deliver as $delivery)
        @if ($delivery->status == 'prepare')
            <div class="card mb-4 p-4">
                <div class="card-header d-flex justify-content-between align-items-center mb-3 px-0">
                    <h5 class="mb-0">Edit Order Delivery Status</h5>
                </div>

                <form method="POST"
                    action="{{ route('delivery.update', ['id' => $delivery->id, 'order_id' => $delivery->order_id]) }}"
                    enctype="multipart/form-data" onsubmit="return validateCompleted()">
                    @csrf
                    <div class="form-floating form-floating-outline mb-4">
                        <select class="form-select" id="selectOption" aria-label="Default select example" name="status">
                            <option hidden value="prepare">Deliver in progress</option>
                            <option value="prepare">Deliver in progress</option>
                            <option value="Completed">Completed</option>
                        </select>
                        <label for="exampleFormControlSelect1">Delivery Status</label>
                    </div>

                    <div class="form-floating form-floating-outline mb-4">
                        <input type="text" id="method" name="method" class="form-control"
                            value="{{ $delivery->method }}" id="basic-default-fullname" placeholder="Delivery Company"
                            required />
                        <label for="basic-default-fullname">Delivery Company</label>
                    </div>

                    <div class="form-floating form-floating-outline mb-4">
                        <input type="text" id="track_num" name="track_num" class="form-control"
                            value="{{ $delivery->tracking_number }}" id="basic-default-fullname"
                            placeholder="Tracking Number" required />
                        <label for="basic-default-fullname">Tracking Number</label>
                    </div>

                    <div class="form-floating form-floating-outline mb-4">
                        <input class="form-control" type="date" id="html5-date-input" required
                            value="{{ $delivery->expected_date }}" name="expected_date" />
                        <label for="html5-date-input">Expected Date</label>
                    </div>

                    <div class="col-12">
                        <h6 class="mt-2">Proof of Delivery</h6>
                    </div>

                    {{-- <div class="col-md-12">
                <div class="form-floating form-floating-outline">
                    <img id="frame" class="img-fluid m-1" style="height:200px; width:200px"
                    src="{{ asset('delivery_prove') }}/{{ $delivery->prv_img}}" alt="Proof of Delivery"
                    />
                </div>
            </div> --}}

                    <div class="col-md-12">
                        <div class="form-floating form-floating-outline">
                            <img id="frame" class="img-fluid m-1" style="height:200px; width:200px" />
                        </div>
                    </div>

                    <div class="col-md-12">
                        <div class="form-floating form-floating-outline my-3">
                            <input class="form-control" type="file" id="formFile" name="image_proof"
                                onchange="preview()">
                            <label for="formValidationFile">Proof of Delivery</label>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary">Save</button>
            </div>
        @elseif($delivery->status == 'Completed')
            <div class="row">
                <div class="col-xl">
                    <div class="card mb-4">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">Delivery Order Detail</h5>
                        </div>
                        <div class="card-body">
                            {{-- Order Information --}}
                            <div class="col-md-6 col-lg-4 mb-4">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="card-header px-0 py-2">
                                            <h5 class="mb-0">Order Information</h5>
                                        </div>
                                        <blockquote class="blockquote mb-0">
                                            <p>
                                                @foreach ($orders as $order)
                                                    <b>Order ID:</b> {{ $order->id }} <br>
                                                    <b>Order Date:</b>
                                                    {{ Carbon\Carbon::parse($order->date)->format('d/m/Y') }} <br>
                                                    <b>Order Status: </b>{{ $order->status }} <br>
                                                @endforeach

                                            </p>
                                        </blockquote>
                                    </div>
                                </div>
                            </div>


                            {{-- Sender Information --}}
                            <div class="col-md-6 col-lg-4 mb-4">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="card-header px-0 py-2">
                                            <h5 class="mb-0">Sender Information</h5>
                                        </div>
                                        <blockquote class="blockquote mb-0">
                                            <p>
                                                <b>Sender: </b>Nursery Garden SDN Berhad <br>
                                                <b>Address: </b>Nursery Garden, Pontian Besar, 82000, Pontian, Johor
                                                <br>
                                            </p>
                                        </blockquote>
                                    </div>
                                </div>
                            </div>

                            {{-- Sender Information --}}
                            <div class="col-md-6 col-lg-4 mb-4">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="card-header px-0 py-2">
                                            <h5 class="mb-0">Service Requestor Information</h5>
                                        </div>
                                        <blockquote class="blockquote mb-0">
                                            <p>
                                                @foreach ($user as $users)
                                                    <b>Sender: </b>{{ $users->name }} <br>
                                                @endforeach
                                                <b>Address: </b>{{ $order->address }}<br>
                                            </p>
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
                                                                            <p class="fw-normal mb-1">
                                                                                {{ $plant->name }}</p>
                                                                        </td>
                                                                        <td class="text-truncate">
                                                                            <p class="fw-normal mb-1">RM
                                                                                {{ number_format($plant->price, 2) }}
                                                                            </p>
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
                                                                            <p class="fw-normal mb-1">
                                                                                {{ $product->name }}</p>
                                                                        </td>
                                                                        <td class="text-truncate">
                                                                            <p class="fw-normal mb-1">RM
                                                                                {{ number_format($product->price, 2) }}
                                                                            </p>
                                                                        </td>
                                                                    @endif
                                                                @endforeach
                                                            @endif
                                                            <td class="text-truncate">
                                                                <p class="fw-normal mb-1">
                                                                    {{ $order_item[$i]->quantity }}</p>
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
                                                            <p
                                                                class="fw-normal my-3 d-flex align-items-center justify-content-end">
                                                                <b>Total Amount</b>
                                                            </p>
                                                        </td>
                                                        <td colspan="1">
                                                            <p class="fw-normal my-3"> <b>RM
                                                                    {{ number_format($delivery_total_price, 2) }}</b>
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
        @endif
    @endforeach
    </form>
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

            if ((selectedOptionValue === "Completed" && frame.src === "") ||
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
