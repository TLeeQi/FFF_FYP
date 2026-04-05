<?php


namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Delivery;
use App\Models\Order;
use App\Models\Payment;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Stripe;
use Stripe\StripeClient;
use Exception;
use Carbon\Carbon;


class PaymentApiController extends Controller
{

    public function paymentIntent(Request $request)
    {
        $request->validate([
            'order_id' => ['required'],
        ]);;

        $order = Order::where('id', $request->order_id)->first();

        if (!$order) {
            return $this->fail('Order not found');
        }

        if ($order->status != 'pay') {
            return $this->fail('Some error occur, Please try again later.');
        }

        $ret = [];

        $payment_intent = Payment::where('order_id', $request->order_id)->first();

        if (!$payment_intent) {
            $stripeClient = new Stripe\StripeClient(
                config('services.stripe.STRIPE_SECRET_KEY')
            );

            // Create a PaymentIntent with amount and currency
            $paymentIntent = $stripeClient->paymentIntents->create([
                'amount' => $order->total_amount * 100,
                'currency' => 'myr',
                'automatic_payment_methods' => [
                    'enabled' => true
                ]
            ]);


            Payment::create([
                'status' => 'pending',
                'order_id' => $order->id,
                'details' => $paymentIntent->client_secret,
                'method' => 'Card',
                'amount' =>  $order->total_amount,
                'date' => Carbon::today(),
                'user_id' => Auth::id()
            ]);

            $ret['Client_Secret'] = $paymentIntent->client_secret;
            $ret['response'] = $paymentIntent;
        } else {
            if ($payment_intent->status == "success") {
                return $this->fail('Payment already done');
            }

            $ret['Client_Secret'] = $payment_intent->details;
        }

        return $this->success($ret);
    }

    public function handlePaymentSucceed(Request $request)
    {
        $request->validate([
            'client_secret' => ['required'],
        ]);;

        $payment = Payment::where('details', $request->client_secret)->first();
        $payment->status = 'success';
        $payment->save();

        // If payment succees, update the order status
        $order = Order::where('id', $payment->order_id)->first();
        $order->status = 'prepare';
        $order->save();

        return $this->success($payment);
    }
}
