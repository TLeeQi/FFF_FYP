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
        Schema::create('order_detail', function (Blueprint $table) {
            $table->id();
            $table->integer('quantity');
            $table->double('price', 8, 2);
            $table->double('amount', 8, 2);
            $table->foreignId('order_id');
            $table->foreign('order_id')->references('id')->on('order');
            $table->String('remark')->nullable();
            $table->foreignId('product_id')->nullable();
            $table->foreign('product_id')->references('id')->on('product');
            $table->foreignId('plant_id')->nullable();
            $table->foreign('plant_id')->references('id')->on('plant');
            $table->foreignId('delivery_id')->nullable();
            $table->foreign('delivery_id')->references('id')->on('delivery');
            $table->foreignId('bidding_id')->nullable();
            $table->foreign('bidding_id')->references('id')->on('bidding');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('order_detail');
    }
};
