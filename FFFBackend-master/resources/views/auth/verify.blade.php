<!DOCTYPE html>

<html lang="en" class="light-style layout-menu-fixed layout-compact" dir="ltr" data-theme="theme-default"
    data-assets-path="../assets/" data-template="vertical-menu-template-free">

<head>
    <meta charset="utf-8" />
    <meta name="viewport"
        content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />

    <title>FixIt Foliage Frenzy</title>

    <meta name="description" content="" />

    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="{{ url('/icon/fff_icon.png') }}" />

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&ampdisplay=swap"
        rel="stylesheet" />

    <link rel="stylesheet" href="{{ url('/assets/vendor/fonts/materialdesignicons.css') }}" />

    <!-- Menu waves for no-customizer fix -->
    <link rel="stylesheet" href="{{ url('/assets/vendor/libs/node-waves/node-waves.css"') }}" />

    <!-- Core CSS -->
    <link rel="stylesheet" href="{{ url('/assets/vendor/css/core.css') }}" class="template-customizer-core-css" />
    <link rel="stylesheet" href="{{ url('/assets/vendor/css/theme-default.css') }}"
        class="template-customizer-theme-css" />
    <link rel="stylesheet" href="{{ url('/assets/css/demo.css') }}" />

    <!-- Vendors CSS -->
    <link rel="stylesheet" href="{{ url('/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css') }}" />
    <link rel="stylesheet" href="{{ url('/assets/vendor/libs/apex-charts/apex-charts.css') }}" />

    <!-- Page CSS -->

    <!-- Helpers -->
    <script src="{{ url('/assets/vendor/js/helpers.js') }}"></script>
    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
    <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
    <script src="{{ url('/assets/js/config.js') }}"></script>

    <style>
        .register-container {
            margin-top: 50px;
        }

        .register-card {
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .register-header {
            background: linear-gradient(135deg, #6a11cb, #2575fc);
            color: white;
            padding: 20px;
            text-align: center;
        }

        .register-header h4 {
            margin: 0;
            font-weight: bold;
        }

        .register-body {
            padding: 30px;
        }

        .form-control {
            border-radius: 5px;
            border: 1px solid #ddd;
            transition: border-color 0.3s ease;
        }

        .form-control:focus {
            border-color: #2575fc;
            box-shadow: none;
        }

        .btn-register {
            background-color: #2575fc;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            font-size: 16px;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        .btn-register:hover {
            background-color: #1a5bb8;
        }
    </style>
</head>

<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">{{ __('Verify Your Email Address') }}</div>

                <div class="card-body">
                    @if (session('resent'))
                        <div class="alert alert-success" role="alert">
                            {{ __('A fresh verification link has been sent to your email address.') }}
                        </div>
                    @endif

                    {{ __('Before proceeding, please check your email for a verification link.') }}
                    {{ __('If you did not receive the email') }},
                    <form class="d-inline" method="POST" action="{{ route('verification.resend') }}">
                        @csrf
                        <button type="submit" class="btn btn-link p-0 m-0 align-baseline">{{ __('click here to request another') }}</button>.
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Core JS -->
    <!-- build:js assets/vendor/js/core.js -->
    <script src="{{ url('/assets/vendor/libs/jquery/jquery.js') }}"></script>
    <script src="{{ url('/assets/vendor/libs/popper/popper.js') }}"></script>
    <script src="{{ url('/assets/vendor/js/bootstrap.js') }}"></script>
    <script src="{{ url('/assets/vendor/libs/node-waves/node-waves.js') }}"></script>
    <script src="{{ url('/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js') }}"></script>
    <script src="{{ url('/assets/vendor/js/menu.js') }}"></script>

    <!-- endbuild -->

    <!-- Vendors JS -->
    <script src="{{ url('/assets/vendor/libs/apex-charts/apexcharts.js') }}/"></script>

    <!-- Main JS -->
    <script src="{{ url('/assets/js/main.js') }}"></script>

    <!-- Page JS -->
    <script src="{{ url('/assets/js/dashboards-analytics.js') }}"></script>

    <!-- Place this tag in your head or just before your close body tag. -->
    <script async defer src="https://buttons.github.io/buttons.js"></script>
</body>

</html>