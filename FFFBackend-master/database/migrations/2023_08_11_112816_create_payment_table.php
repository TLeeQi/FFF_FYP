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
        Schema::create('payment', function (Blueprint $table) {
            $table->id();
            $table->string('status');
            $table->double('amount', 8, 2);
            $table->string('details');
            $table->string('method');
            $table->date('date');
            $table->foreignId('order_id')->nullable();
            $table->foreign('order_id')->references('id')->on('order');
            $table->foreignId('bidding_id')->nullable();
            $table->foreign('bidding_id')->references('id')->on('bidding');
            $table->foreignId('user_id');
            $table->foreign('user_id')->references('id')->on('users');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('payment');
    }
};
