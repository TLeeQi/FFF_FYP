<?php

namespace App\Console\Commands;

use App\Models\Address;
use Illuminate\Console\Command;
use App\Models\Bidding;
use App\Models\BiddingDetailModel;
use App\Models\Payment;
use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;
use App\Models\Order;
use App\Models\OrderDetailModel;


class BidExpirationCheck extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'app:bid-expiration-check';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Process bids that have ended';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $this->info('Processing bids...');

        // Check the validty and pass the bid
        $datetime = Carbon::now()->toDateTimeString();

        $biddings = Bidding::where('status', '1')
            ->where('end_time', '<=', $datetime)
            ->get();

        foreach ($biddings as $bidding) {
            $this->processBid($bidding);
        }

        $this->info('Bid processing completed.');
    }

    private function processBid(Bidding $bid)
    {
        // Change the Status of the Bidding, Since it end
        $bidding = Bidding::where('id', $bid->id)->first();
        $bidding->status = '2';
        $bidding->save();

        // Get the Highest Bidding User ID
        $bidding_detail = BiddingDetailModel::where('bidding_id', $bidding->id)
            ->orderBy('amount', 'desc')
            ->where('user_id', '=', $bidding->winner_id)
            ->where('refund_status', '=', 'pay')
            ->first();

        // If not exist, mean nobody bid
        if (!$bidding_detail) {
            // 0 == no one bid
            // 1 == active
            // 2 == end
            $bidding->status = '0';
            $bidding->save();
            return;
        }

        // Bidding Detail Change for the Winner
        $bidding_detail->refund_status = 'win';
        $bidding_detail->save();

        // Bidding Detail for loser
        $bidding_loser = BiddingDetailModel::where('bidding_id', $bidding->id)
            ->where('refund_status', '=', 'pay')
            ->where('user_id', '!=', $bidding->winner_id)
            ->get();

        // Create a order for the winner

        // Get the address of the winner
        $address = Address::where('user_id', $bidding->winner_id)
            ->orderBy('updated_at', 'desc')
            ->where('status', '1')
            ->first();
        if (!$address) {
            $this->info("No address found for user ID: {$bidding->winner_id}");
            $address = "No Default Address Found";
        } else {
            $address = $address->address;
        }

        // Fill up the information at client side for address
        $order = Order::create([
            'status' =>  'ship',
            'date' => Carbon::now(),
            'total_amount' => $bidding_detail->amount,
            'user_id' => $bidding->winner_id,
            'address' => $address,
            'note' => "Bidding Winner Order",
        ]);

        OrderDetailModel::create([
            'quantity' => '1',
            'price' => $bidding_detail->amount,
            'amount' => $bidding_detail->amount,
            'order_id' => $order->id,
            'product_id' => null,
            'plant_id' => $bidding->plant_id,
            'bidding_id' => $bidding->id,
        ]);

        $this->info("Processed bid ID: {$bidding->id}");
    }
}
