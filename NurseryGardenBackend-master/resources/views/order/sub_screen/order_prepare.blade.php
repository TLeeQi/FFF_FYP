@extends('layouts.app')
@section('content')
    <!-- Basic Layout -->
    <div class="row">
        <div class="col-xl">
            <div class="card mb-4">
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
                                                <b>Booking Placed Date:</b>
                                                {{ Carbon\Carbon::parse($order->date)->format('d/m/Y') }}<br>
                                                @if ($order->note != null)
                                                    <b>Order Remark:</b> {{ $order->note }} <br>
                                                @endif
                                                <br>
                                                <!-- <b>Order Address:</b><br> {{ $order->address }}<br><br> -->
                                                <b>Status:</b>
                                                <span class="badge bg-label-warning rounded-pill">To
                                                    {{ ucfirst($order->status) }}</span>
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
                            <h5 class="mb-0">Booking Details</h5>
                        </div>

                        <!-- display each booking services details from database -->
                        <div class="card-body">
                        <!-- Wiring Details -->
                        @if(!empty($item_detail['wiring']))
                            <div class="row">
                                @foreach($item_detail['wiring'] as $wiring)
                                    <div class="col-md-6 mb-4">
                                        <div class="card shadow-sm">
                                            <div class="card-body">
                                                <h5 class="card-title">Wiring ID: {{ $wiring->id }}</h5>
                                                <ul class="list-unstyled">
                                                    <li><strong>Type:</strong> {{ $wiring->type }}</li>
                                                    <li><strong>Fix Item:</strong> {{ implode(', ', $wiring->fixitem) }}</li>
                                                    <li><strong>Has Part:</strong> {{ $wiring->ishavepart ? 'Yes' : 'No' }}</li>
                                                    <li><strong>Property Type:</strong> {{ $wiring->types_property }}</li>
                                                    <li><strong>Appointment Date:</strong> {{ $wiring->app_date->format('d/m/Y') }}</li>
                                                    <li><strong>Preferred Time:</strong> {{ $wiring->preferred_time }}</li>
                                                    <li><strong>Budget:</strong> {{ $wiring->budget ?? 'N/A' }}</li>
                                                    <li><strong>Details:</strong> {{ $wiring->details ?? 'N/A' }}</li>
                                                    <li><strong>Address:</strong> {{ $order->address }}</li>
                                                    <li><strong>Deposit:</strong> RM {{ number_format($order->price, 2) }}</li>
                                                </ul>
                                                <div class="mt-3">
                                                    <strong>Photos:</strong>
                                                    <div class="d-flex flex-wrap">
                                                        @php
                                                            $photos = explode(',', $wiring->photo);
                                                        @endphp
                                                        @foreach($photos as $photo)
                                                            <img src="{{ asset('service_image/' . trim($photo)) }}" alt="Wiring Photo" class="img-thumbnail me-2 mb-2" style="max-width: 100px;">
                                                        @endforeach
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                @endforeach
                            </div>
                        @endif

                        <!-- Piping Details -->
                        @if(!empty($item_detail['piping']))
                            <div class="row">
                                @foreach($item_detail['piping'] as $piping)
                                    <div class="col-md-6 mb-4">
                                        <div class="card shadow-sm">
                                            <div class="card-body">
                                                <h5 class="card-title">Piping ID: {{ $piping->id }}</h5>
                                                <ul class="list-unstyled">
                                                    <li><strong>Type:</strong> {{ $piping->type }}</li>
                                                    <li><strong>Fix Item:</strong> {{ implode(', ', $piping->fixitem) }}</li>
                                                    <li><strong>Problem:</strong> {{ implode(', ', ($piping->problem)) }}</li>
                                                    <li><strong>Property Type:</strong> {{ $piping->types_property }}</li>
                                                    <li><strong>Appointment Date:</strong> {{ $piping->app_date->format('d/m/Y') }}</li>
                                                    <li><strong>Preferred Time:</strong> {{ $piping->preferred_time }}</li>
                                                    <li><strong>Budget:</strong> {{ $piping->budget ?? 'N/A' }}</li>
                                                    <li><strong>Details:</strong> {{ $piping->details ?? 'N/A' }}</li>
                                                    <li><strong>Address:</strong> {{ $order->address }}</li>
                                                    <li><strong>Deposit:</strong> RM {{ number_format($order->price, 2) }}</li>
                                                </ul>
                                                <div class="mt-3">
                                                    <strong>Photos:</strong>
                                                    <div class="d-flex flex-wrap">
                                                        @php
                                                            $photos = explode(',', $piping->photo);
                                                        @endphp
                                                        @foreach($photos as $photo)
                                                            <img src="{{ asset('service_image/' . trim($photo)) }}" alt="Piping Photo" class="img-thumbnail me-2 mb-2" style="max-width: 100px;">
                                                        @endforeach
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                @endforeach
                            </div>
                        @endif

                        <!-- Gardening Details -->
                        @if(!empty($item_detail['gardening']))
                        <div class="row">
                                @foreach($item_detail['gardening'] as $gardening)
                                    <div class="col-md-6 mb-4">
                                        <div class="card shadow-sm">
                                            <div class="card-body">
                                                <h5 class="card-title">Gardening ID: {{ $gardening->id }}</h5>
                                                <ul class="list-unstyled">
                                                    <li><strong>Type:</strong> {{ $gardening->type }}</li>
                                                    <li><strong>Area:</strong> {{ $gardening->area }}</li>
                                                    <li><strong>Property Type:</strong> {{ $gardening->types_property }}</li>
                                                    <li><strong>Appointment Date:</strong> {{ $gardening->app_date->format('d/m/Y') }}</li>
                                                    <li><strong>Preferred Time:</strong> {{ $gardening->preferred_time }}</li>
                                                    <li><strong>Budget:</strong> {{ $gardening->budget ?? 'N/A' }}</li>
                                                    <li><strong>Details:</strong> {{ $gardening->details ?? 'N/A' }}</li>                                                    
                                                    <li><strong>Address:</strong> {{ $order->address }}</li>
                                                    <li><strong>Deposit:</strong> RM {{ number_format($order->price, 2) }}</li>
                                                </ul>
                                                <div class="mt-3">
                                                    <strong>Photos:</strong>
                                                    <div class="d-flex flex-wrap">
                                                        @php
                                                            $photos = explode(',', $gardening->photo);
                                                        @endphp
                                                        @foreach($photos as $photo)
                                                            <img src="{{ asset('service_image/' . trim($photo)) }}" alt="Gardening Photo" class="img-thumbnail me-2 mb-2" style="max-width: 100px;">
                                                        @endforeach
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                @endforeach
                            </div>
                        @endif

                        <!-- Runner Details -->
                        @if(!empty($item_detail['runner']))
                        <div class="row">
                                @foreach($item_detail['runner'] as $runner)
                                    <div class="col-md-6 mb-4">
                                        <div class="card shadow-sm">
                                            <div class="card-body">
                                                <h5 class="card-title">Runner ID: {{ $runner->id }}</h5>
                                                <ul class="list-unstyled">
                                                    <li><strong>Type:</strong> {{ $runner->type }}</li>
                                                    <li><strong>Area:</strong> {{ $runner->area }}</li>
                                                    <li><strong>Appointment Date:</strong> {{ $runner->app_date->format('d/m/Y') }}</li>
                                                    <li><strong>Preferred Time:</strong> {{ $runner->preferred_time }}</li>
                                                    <li><strong>Budget:</strong> {{ $runner->budget ?? 'N/A' }}</li>
                                                    <li><strong>Details:</strong> {{ $runner->details ?? 'N/A' }}</li>
                                                    <li><strong>Address:</strong> {{ $order->address }}</li>
                                                    <li><strong>Deposit:</strong> RM {{ number_format($order->price, 2) }}</li>
                                                </ul>
                                                <div class="mt-3">
                                                    <strong>Photos:</strong>
                                                    <div class="d-flex flex-wrap">
                                                        @php
                                                            $photos = explode(',', $runner->photo);
                                                        @endphp
                                                        @foreach($photos as $photo)
                                                            <img src="{{ asset('service_image/' . trim($photo)) }}" alt="Runner Photo" class="img-thumbnail me-2 mb-2" style="max-width: 100px;">
                                                        @endforeach
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                @endforeach
                            </div>
                        @endif
                    </div>

                        {{-- Not Delivery Out --}}
                        <!-- Data Tables -->
                        <!-- <div class="col-12 mt-3">
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
                                                    <td>
                                                        <span class="form-check mb-0">
                                                            <input class="form-check-input me-1" type="checkbox"
                                                                name="cid[]" id="cid[]"
                                                                value="{{ $order_item[$i]->id }}" onclick="cal()" />
                                                        </span>
                                                    </td>
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
                        </div> -->

                        <div class="card mb-4 mt-5 p-4 mx-2">

                            <div class="card-header d-flex justify-content-between align-items-center my-3 px-0">
                                <h5 class="mb-0">Assign a vendor</h5>
                            </div>

                            <form method="POST" action="{{ route('delivery.update', ['order_id' => $order->id]) }}"
                               ">
                                @csrf
                                <input type="hidden" name="items[]" id="items[]" value="">
                                <input type="hidden" name="status" id="status" value="prepare">

                                <div class="form-floating form-floating-outline mb-4">
                                    <input type="text" id="method" name="method" class="form-control"
                                        id="basic-default-fullname" placeholder="Service Provider Company" required />
                                    <label for="basic-default-fullname">Service Provider Company</label>
                                </div>
                                <div class="form-floating form-floating-outline mb-4">
                                    <input type="text" id="track_num" name="track_num" class="form-control"
                                        id="basic-default-fullname" placeholder="Contact Number" required />
                                    <label for="basic-default-fullname">Contact Number</label>
                                </div>
                                <!-- <div class="form-floating form-floating-outline mb-4">
                                    <input class="form-control" type="date" id="html5-date-input" required
                                        name="expected_date" />
                                    <label for="html5-date-input">Expected date</label>
                                </div> -->
                                <button type="submit" class="btn btn-primary">Save</button>
                            </form>
                        </div>



                    </div>
                </div>
            </div>
            <script>
                //Calculate the total price
                // function cal() {
                //     var items = document.getElementsByName('items[]');
                //     var cboxes = document.getElementsByName('cid[]');
                //     console.log(items);
                //     console.log(cboxes.length);
                //     var id = [];
                //     var len = cboxes.length;

                //     for (var i = 0; i < len; i++) {
                //         if (cboxes[i].checked) {
                //             id.push(cboxes[i].value);
                //         }
                //     }
                //     document.getElementById('items[]').value = id;
                // }

                // function getSelectedOption() {
                //     var selectedItem = document.getElementById('items[]').value;
                //     console.log(selectedItem.length);

                //     if (selectedItem === "" || selectedItem === null) {
                //         alert("Please tick the item you want to deliver at first");
                //         return false; // Prevent form submissions
                //     }

                //     var selectElement = document.getElementById("selectOption");
                //     var selectedOptionValue = selectElement.value;

                //     if (selectedOptionValue === "pack") {
                //         alert("Please update the delivery status of the order");
                //         return false; // Prevent form submission
                //     } else {
                //         // You can now use the selectedOptionValue in your further processing
                //         return true; // Allow form submission
                //     }
                // }

                // function validateCompleted() {
                //     var selectElement = document.getElementById("selectOption");
                //     var selectedOptionValue = selectElement.value;

                //     if ((selectedOptionValue === "Confirmed" && frame.src === "") ||
                //         (selectedOptionValue === "prepare" && frame.src !== "")
                //     ) {
                //         alert("Please update the delivery status of the order and ensure the prove of delivery is updated");
                //         return false; // Prevent form submission
                //     } else {
                //         // You can now use the selectedOptionValue in your further processing
                //         return true; // Allow form submission
                //     }
                // }

                function preview() {
                    frame.src = URL.createObjectURL(event.target.files[0]);
                }

                function clearImage() {
                    document.getElementById('formFile').value = null;
                    frame.src = "";
                }
            </script>

        @endsection
