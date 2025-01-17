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
</head>

<body>
    <!-- Layout wrapper -->
    <div class="layout-wrapper layout-content-navbar">
        <div class="layout-container">
            <!-- Menu -->
            <aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme">
                <div class="app-brand demo">
                    <a href="index.html" class="app-brand-link">
                        <span class="app-brand-logo demo me-1">
                            <img src="{{ url('/icon/fff_icon.png') }}" height="25" width="25">
                        </span>
                        <span class="app-brand-text demo menu-text fw-semibold ms-2" style="font-size: 16px;">FixIt Foliage Frenzy</span>
                    </a>

                    <a href="javascript:void(0);" class="layout-menu-toggle menu-link text-large ms-auto">
                        <i class="mdi menu-toggle-icon d-xl-block align-middle mdi-20px"></i>
                    </a>
                </div>

                <div class="menu-inner-shadow"></div>

                <ul class="menu-inner py-1">

                    <!-- Dashboards -->
                    
                    <li class="menu-item">
                        <a href="{{ route('home') }}" class="menu-link">
                            <i class="menu-icon tf-icons mdi mdi-home-outline"></i>
                            <div data-i18n="Dashboards">Dashboard</div>
                        </a>
                    </li>

                    @if(Auth::user()->type == 'admin' || Auth::user()->type == 'sadmin')
                        <li class="menu-header small text-uppercase">
                            <span class="menu-header-text">Users</span>
                        </li>

                        <!-- Dashboards -->
                        <li class="menu-item">
                            <a href="{{ route('customer.index') }}" class="menu-link">
                                <i class="menu-icon tf-icons mdi mdi-account-multiple-outline"></i>
                                <div data-i18n="Dashboards">Users</div>
                            </a>
                        </li>

                        <li class="menu-header small text-uppercase">
                            <span class="menu-header-text">Vendors</span>
                        </li>

                        <!-- Dashboards -->
                        <li class="menu-item">
                            <a href="{{ route('customer.vendor') }}" class="menu-link">
                                <i class="menu-icon tf-icons mdi mdi-account-multiple-outline"></i>
                                <div data-i18n="Dashboards">Vendors</div>
                            </a>
                        </li>
                    @endif

                    <li class="menu-header small text-uppercase">
                        <span class="menu-header-text">Bookings</span>
                    </li>

                    <!-- Order -->
                    <li class="menu-item">
                        <a href="{{ route('order.index') }}" class="menu-link">
                            <i class="menu-icon tf-icons mdi mdi-file-document-multiple-outline"></i>
                            <div data-i18n="Dashboards">Services Lists</div>
                        </a>
                    </li>

                    <li class="menu-item">
                        <a href="{{ route('delivery.index') }}" class="menu-link">
                            <i class="menu-icon tf-icons mdi mdi-list-status"></i>
                            <div data-i18n="Dashboards">Ongoing Booking</div>
                        </a>
                    </li>


                    {{-- Biddings --}}
                    <!-- <li class="menu-header small text-uppercase">
                        <span class="menu-header-text">Biddings</span>
                    </li>
                    <li class="menu-item">
                        <a href="{{ route('bidding.index') }}" class="menu-link">
                            <i class="menu-icon tf-icons mdi mdi-package-variant-closed"></i>
                            <div data-i18n="Dashboards">Biddings</div>
                        </a>
                    </li>
                    <li class="menu-item">
                        <a href="{{ route('bidding.insert') }}" class="menu-link">
                            <i class="menu-icon tf-icons mdi mdi-plus-box-outline"></i>
                            <div data-i18n="Dashboards">Add Biddings</div>
                        </a>
                    </li> -->
                    @if(Auth::user()->type == 'vendor')
                        <li class="menu-header small text-uppercase">
                            <span class="menu-header-text">Profile</span>
                        </li>
                        <li class="menu-item">
                            <a href="{{ route('verification.verification') }}" class="menu-link">
                                <i class="menu-icon tf-icons mdi mdi-check-decagram-outline"></i>
                                <div data-i18n="Dashboards">Profile Update</div>
                            </a>
                        </li>

                        <li class="menu-header small text-uppercase">
                            <span class="menu-header-text">FAQ</span>
                        </li>
                        <li class="menu-item">
                            <a href="{{ route('faq') }}" class="menu-link">
                                <i class="menu-icon tf-icons mdi mdi-help-circle-outline"></i>
                                <div data-i18n="Dashboards">FAQ</div>
                            </a>
                        </li>
                    @endif

                    <!-- <li class="menu-header small text-uppercase">
                        <span class="menu-header-text">Category</span>
                    </li> -->

                    <!-- Category -->
                    <!-- <li class="menu-item">
                        <a href="{{ route('category.index') }}" class="menu-link">
                            <i class="menu-icon tf-icons mdi mdi-format-list-bulleted"></i>
                            <div data-i18n="Dashboards">Categories</div>
                        </a>
                    </li>
                    <li class="menu-item">
                        <a href="{{ route('category.insert') }}" class="menu-link">
                            <i class="menu-icon tf-icons mdi mdi-plus-box-outline"></i>
                            <div data-i18n="Dashboards">Add Category</div>
                        </a>
                    </li> -->


                    <!-- <li class="menu-header small text-uppercase">
                        <span class="menu-header-text">Plant</span>
                    </li> -->

                    <!-- Plant -->
                    <!-- <li class="menu-item">
                        <a href="{{ route('plant.index') }}" class="menu-link">
                            <i class="menu-icon tf-icons mdi mdi-flower-outline"></i>
                            <div data-i18n="Dashboards">Plants</div>
                        </a>
                    </li>
                    <li class="menu-item">
                        <a href="{{ route('plant.insert') }}" class="menu-link">
                            <i class="menu-icon tf-icons mdi mdi-plus-box-outline"></i>
                            <div data-i18n="Dashboards">Add Plant</div>
                        </a>
                    </li> -->

                    @if(Auth::user()->type == 'admin' || Auth::user()->type == 'sadmin')
                    <li class="menu-header small text-uppercase">
                        <span class="menu-header-text">Services</span>
                    </li>

                    <!-- Product -->
                    <li class="menu-item">
                        <a href="{{ route('product.index') }}" class="menu-link">
                            <i class="menu-icon tf-icons mdi mdi-package-variant-closed"></i>
                            <div data-i18n="Dashboards">Services</div>
                        </a>
                    </li>
                    @endif
                    <!-- <li class="menu-item">
                        <a href="{{ route('product.insert') }}" class="menu-link">
                            <i class="menu-icon tf-icons mdi mdi-plus-box-outline"></i>
                            <div data-i18n="Dashboards">Add Product</div>
                        </a>
                    </li> -->


                    <!-- <li class="menu-header small text-uppercase">
                        <span class="menu-header-text">Custom Style</span>
                    </li> -->

                    <!-- Product -->
                    <!-- <li class="menu-item">
                        <a href="{{ route('custom.index') }}" class="menu-link">
                            <i class="menu-icon tf-icons mdi mdi-package-variant-closed"></i>
                            <div data-i18n="Dashboards">Style</div>
                        </a>
                    </li>
                    <li class="menu-item">
                        <a href="{{ route('custom.insert') }}" class="menu-link">
                            <i class="menu-icon tf-icons mdi mdi-plus-box-outline"></i>
                            <div data-i18n="Dashboards">Add Style</div>
                        </a>
                    </li> -->

                    <!-- @if(Auth::user()->type == 'admin' || Auth::user()->type == 'sadmin') -->
                    <!-- <li class="menu-header small text-uppercase">
                        <span class="menu-header-text">Report</span>
                    </li> -->

                    <!-- Product -->
                    <!--<li class="menu-item">
                        <a href="{{ route('report.index') }}" class="menu-link">
                            <i class="menu-icon tf-icons mdi mdi-file-chart-outline"></i>
                            <div data-i18n="Dashboards">Generate Report</div>
                        </a>
                    </li> -->
                    <!-- @endif -->
                </ul>
            </aside>
            <!-- / Menu -->

            <!-- Layout container -->
            <div class="layout-page">
                <!-- Navbar -->

                <nav class="layout-navbar container-xxl navbar navbar-expand-xl navbar-detached align-items-center bg-navbar-theme"
                    id="layout-navbar">
                    <div class="layout-menu-toggle navbar-nav align-items-xl-center me-3 me-xl-0 d-xl-none">
                        <a class="nav-item nav-link px-0 me-xl-4" href="javascript:void(0)">
                            <i class="mdi mdi-menu mdi-24px"></i>
                        </a>
                    </div>

                    <div class="navbar-nav-right d-flex align-items-center" id="navbar-collapse">

                        <ul class="navbar-nav flex-row align-items-center ms-auto">
                            <!-- Place this tag where you want the button to render. -->
                            <li class="nav-item lh-1 me-3">
                                {{ Auth::user()->name }}
                            </li>

                            <!-- User -->
                            <li class="nav-item navbar-dropdown dropdown-user dropdown">
                                <a class="nav-link dropdown-toggle hide-arrow p-0" href="javascript:void(0);"
                                    data-bs-toggle="dropdown">
                                    <div class="avatar avatar-online">
                                        <img src="../assets/img/avatars/1.png" alt
                                            class="w-px-40 h-auto rounded-circle" />
                                    </div>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end mt-3 py-2">
                                    <li>
                                        <a class="dropdown-item pb-2 mb-1" href="#">
                                            <div class="d-flex align-items-center">
                                                <div class="flex-shrink-0 me-2 pe-1">
                                                    <div class="avatar avatar-online">
                                                        <img src="../assets/img/avatars/1.png" alt
                                                            class="w-px-40 h-auto rounded-circle" />
                                                    </div>
                                                </div>
                                                <div class="flex-grow-1">
                                                    <h6 class="mb-0">{{ Auth::user()->name }}</h6>
                                                    <small class="text-muted">{{ Auth::user()->type }}</small>
                                                </div>
                                            </div>
                                        </a>
                                    </li>
                                    <!-- <li>
                                        <div class="dropdown-divider my-1"></div>
                                    </li> -->
                                    {{-- <li>
                                        <a class="dropdown-item" href="#">
                                            <i class="mdi mdi-account-outline me-1 mdi-20px"></i>
                                            <span class="align-middle">My Profile</span>
                                        </a>
                                    </li> --}}
                                    {{-- <li>
                                        <a class="dropdown-item" href="#">
                                            <i class="mdi mdi-cog-outline me-1 mdi-20px"></i>
                                            <span class="align-middle">Settings</span>
                                        </a>
                                    </li> --}}
                                    <li>
                                        <div class="dropdown-divider my-1"></div>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="{{ route('logout') }}"
                                            onclick="event.preventDefault();
                                                     document.getElementById('logout-form').submit();">
                                            <form id="logout-form" action="{{ route('logout') }}" method="POST"
                                                class="d-none">
                                                @csrf
                                            </form>
                                            <i class="mdi mdi-power me-1 mdi-20px"></i>
                                            <span class="align-middle">Log Out</span>
                                        </a>
                                    </li>
                                </ul>
                            </li>
                            <!--/ User -->
                        </ul>
                    </div>
                </nav>

                <!-- / Navbar -->

                <div class="content-wrapper">
                    <!-- Content -->

                    <div class="container-xxl flex-grow-1 container-p-y">
                        @yield('content')
                    </div>
                    <!-- / Content -->
                </div>

                <!-- Footer -->
                <footer class="content-footer footer bg-footer-theme">
                    <div class="container-xxl">
                        <div
                            class="footer-container d-flex align-items-center justify-content-between py-3 flex-md-row flex-column">
                            <div class="text-body mb-2 mb-md-0">
                                ©
                                <script>
                                    document.write(new Date().getFullYear());
                                </script>
                                - FixIt Foliage Frenzy <span class="text-danger"><i class="tf-icons mdi mdi-heart"></i>
                            </div>

                        </div>
                    </div>
                </footer>
                <!-- / Footer -->

                <div class="content-backdrop fade"></div>
            </div>
            <!-- Content wrapper -->
        </div>
        <!-- / Layout page -->
    </div>

    <!-- Overlay -->
    <div class="layout-overlay layout-menu-toggle"></div>
    </div>
    <!-- / Layout wrapper -->


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
