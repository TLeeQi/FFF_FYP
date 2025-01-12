@extends('layouts.app')

@section('content')
    @foreach ($deliver as $delivery)
        @if ($delivery->status == 'confirm')
            <div class="card mb-4 p-4">
                <div class="card-header d-flex justify-content-between align-items-center mb-3 px-0">
                    <h5 class="mb-0">Edit Status</h5>
                </div>

                <form method="POST"
                    action="{{ route('delivery.update', ['id' => $delivery->id, 'order_id' => $delivery->order_id]) }}"
                    enctype="multipart/form-data">
                    @csrf
                    <input type="hidden" name="status" id="status" value="confirm">
                    <div class="form-floating form-floating-outline mb-4">
                        <select class="form-select" id="selectOption" aria-label="Default select example" name="selectOption">
                            <option hidden value="Completed">Completed</option>
                            <!-- <option value="prepare">Prepare</option> -->
                            <option value="Completed" selected>Completed</option>
                        </select>
                        <label for="exampleFormControlSelect1">Booking Status</label>
                    </div>

                    <div class="form-floating form-floating-outline mb-4">
                        <input type="text" id="method" name="method" class="form-control"
                            value="{{ $delivery->method }}" placeholder="Service Provider Company"
                            readonly />
                        <label for="method">Service Provider Company</label>
                    </div>

                    <div class="form-floating form-floating-outline mb-4">
                        <input type="text" id="track_num" name="track_num" class="form-control"
                            value="{{ $delivery->tracking_number }}" placeholder="Contact Number" readonly />
                        <label for="track_num">Contact Number</label>
                    </div>

                    <div class="col-12">
                        <h6 class="mt-2">Proof of Service Completed</h6>
                        <!-- Message to indicate image upload requirement -->
                        <p id="uploadMessage" style="color: red; display: none;">Please upload an image as proof of service completion.</p>
                    </div>

                    <div class="col-md-12">
                        <div class="form-floating form-floating-outline">
                            <img id="frame" class="img-fluid m-1" style="height:200px; width:200px" />
                        </div>
                    </div>

                    <div class="col-md-12">
                        <div class="form-floating form-floating-outline my-3">
                            <input class="form-control" type="file" id="formFile" name="image_proof"
                                onchange="preview()" required>
                            <label for="formValidationFile">Proof of Service Completed</label>
                        </div>
                        
                    </div>
                    <button type="submit" class="btn btn-primary">Save</button>
                </form>
            </div>
        @elseif($delivery->status == 'Completed')
            <div class="row">
                <div class="col-xl">
                    <div class="card mb-4">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">Service Detail</h5>
                        </div>
                        <div class="card-body">
                            {{-- Order Information --}}
                            <div class="col-md-6 col-lg-4 mb-4">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="card-header px-0 py-2">
                                            <h5 class="mb-0">Service Information</h5>
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
                                            <h5 class="mb-0">Service Provider Information</h5>
                                        </div>
                                        <blockquote class="blockquote mb-0">
                                            <p>
                                                @foreach ($vendors as $vendor)
                                                    <b>Company: </b>{{$vendor->name}}<br>
                                                    <b>Contact Number: </b>{{$vendor->contact_number}}
                                                    <br>
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
                                            <h5 class="mb-0">Service Requestor Information</h5>
                                        </div>
                                        <blockquote class="blockquote mb-0">
                                            <p>
                                                @foreach ($user as $users)
                                                    <b>Service Requestor: </b>{{ $users->name }} <br>
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

                            </form>
                        </div>
                    </div>
                </div>
        @endif
    @endforeach
    </form>
    <script>
        document.getElementById('selectOption').addEventListener('change', function() {
            var fileInput = document.getElementById('formFile');
            var uploadMessage = document.getElementById('uploadMessage');
            if (this.value === 'Completed') {
                fileInput.setAttribute('required', 'required');
                uploadMessage.style.display = 'block'; // Show the message
            } else {
                fileInput.removeAttribute('required');
                uploadMessage.style.display = 'none'; // Hide the message
            }
        });

        function preview() {
            var frame = document.getElementById('frame');
            var file = document.getElementById('formFile').files[0];
            if (file) {
                frame.src = URL.createObjectURL(file);
            }
        }
    </script>
@endsection
