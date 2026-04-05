@extends('layouts.app')

@section('content')
    <!-- Error -->
    <div class="misc-wrapper">
        <h1 class="mb-2 mx-2" style="font-size: 6rem">404</h1>
        <h4 class="mb-2">Page Not Found ⚠️</h4>
        <p class="mb-4 mx-2">we couldn't find the page you are looking for</p>
        <div class="d-flex justify-content-center mt-5">
            <img src="../assets/img/illustrations/tree.png" alt="misc-tree"
                class="img-fluid misc-object d-none d-lg-inline-block" width="80" />
            <img src="../assets/img/illustrations/misc-mask-light.png" alt="misc-error"
                class="scaleX-n1-rtl misc-bg d-none d-lg-inline-block"
                data-app-light-img="illustrations/misc-mask-light.png"
                data-app-dark-img="illustrations/misc-mask-dark.png" />
            <div class="d-flex flex-column align-items-center">
                <div>
                    <a href="index.html" class="btn btn-primary text-center my-4">Back to home</a>
                </div>
            </div>
        </div>
    </div>
@endsection
