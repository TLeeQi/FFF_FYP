<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::prefix('v1')->namespace('App\\Http\\Controllers\\Api')->group(function () {
    // Unauthorized
    Route::post('login', 'AuthApiController@login');
    Route::post('register', 'AuthApiController@store');

    Route::middleware('auth:sanctum')->group(function () {
        /* User*/
        Route::get('logout', 'AuthApiController@destroy');
        Route::get('profile', 'UserApiController@show');
        Route::post('profile/update', 'UserApiController@update');
        Route::post('profile/password/update', 'UserApiController@updatePassword');
        Route::post('profile/avatar/update', 'UserApiController@handleUploadUserImage');

        /* Plant*/
        Route::get('plant', 'PlantApiController@plant');
        Route::get('plantlist', 'PlantApiController@plantList');
        Route::get('plant/search/keyword', 'PlantApiController@searchKeyword');
        Route::any('plant/search', 'PlantApiController@searchPlant');
        Route::get('plant/category', 'PlantApiController@getCategory');
        Route::get('plant/detail', 'PlantApiController@show');

        /* Product */
        Route::get('product', 'ProductApiController@product');
        Route::get('productlist', 'ProductApiController@productList');
        Route::get('product/search/keyword', 'ProductApiController@searchKeyword');
        Route::any('product/search', 'ProductApiController@searchProduct');
        Route::get('product/category', 'ProductApiController@getCategory');
        Route::get('product/detail', 'ProductApiController@show');

        /* Wiring */
        // Route::get('wiring', 'WiringApiController@wiring');
        // Route::post('wiring/detail', 'WiringApiController@store');

        /* Cart */
        Route::get('cart', 'CartApiController@show');
        Route::post('cart/add', 'CartApiController@add');
        Route::post('cart/delete', 'CartApiController@delete');
        Route::post('cart/update', 'CartApiController@update');

        /* Order */
        Route::get('order', 'OrderApiController@show');
        Route::get('order/detail', 'OrderApiController@order_detail');
        Route::post('order/create', 'OrderApiController@create');
        Route::get('order/receipt', 'OrderApiController@receipt');
        Route::post('order/cancel', 'OrderApiController@cancel');
        Route::post('order/address/change', 'OrderApiController@updateOrderAddress');

        Route::post('order/wiringdetail', 'OrderApiController@storeWiringDetail');
        Route::post('order/pipingdetail', 'OrderApiController@storePipingDetail');
        Route::post('order/gardeningdetail', 'OrderApiController@storeGardeningDetail');
        Route::post('order/runnerdetail', 'OrderApiController@storeRunnerDetail');

        /* Vendor */
        Route::get('vendor', 'VendorApiController@index');
        Route::get('vendor/{id}', 'VendorApiController@show');
        Route::post('vendor/{id}/rate', 'VendorApiController@rate');

        /* Order Detail */
        // Route::get('order/detail/wiring', 'OrderApiController@wiringDetail');
        // Route::get('order/detail/piping', 'OrderApiController@pipingDetail');
        // Route::get('order/detail/gardening', 'OrderApiController@gardeningDetail');
        // Route::get('order/detail/runner', 'OrderApiController@runnerDetail');

        /* Payment */
        Route::post('order/payment/intent', 'PaymentApiController@paymentIntent');
        Route::post('order/payment/succeed', 'PaymentApiController@handlePaymentSucceed');

        /* Address */
        Route::get('address', 'AddressApiController@addressList');
        Route::post('address/add', 'AddressApiController@addAddress');
        Route::post('address/update', 'AddressApiController@updateAddress');
        Route::post('address/delete', 'AddressApiController@deleteAddress');

        /* Delivery */
        Route::get('delivery', 'DeliveryApiController@index');
        Route::get('delivery/detail', 'DeliveryApiController@show');
        Route::get('delivery/receipt', 'DeliveryApiController@receipt');

        /* Custom */
        Route::post('custom', 'CustomApiController@add');
        Route::post('custom/order', 'CustomApiController@order');
        Route::get('custom/show', 'CustomApiController@show');

        /* Bidding */
        Route::get('bidding', 'BiddingApiController@index');
        Route::get('bidding/show', 'BiddingApiController@show');
        Route::post('bidding/payment/intent', 'BiddingApiController@paymentIntent');
        Route::post('bidding/payment', 'BiddingApiController@payment');
        Route::get('bidding/refund/list', 'BiddingApiController@refundList');
    });
});
