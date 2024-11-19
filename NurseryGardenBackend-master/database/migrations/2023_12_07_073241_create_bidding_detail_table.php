<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('bidding_detail', function (Blueprint $table) {
            $table->id();
            $table->foreignId('bidding_id');
            $table->foreign('bidding_id')->references('id')->on('bidding');
            $table->foreignId('user_id');
            $table->foreign('user_id')->references('id')->on('users');
            $table->double('amount', 8, 2);
            $table->string('refund_status');
            $table->string('payment_way');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('bidding_detail');
    }
};
