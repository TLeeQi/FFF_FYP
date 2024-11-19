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
        Schema::create('bidding', function (Blueprint $table) {
            $table->id();
            $table->double('intial_amt', 8, 2);
            $table->double('min_amt', 8, 2);
            $table->string('status');
            $table->foreignId('winner_id')->nullable();
            $table->foreign('winner_id')->references('id')->on('users');
            $table->double('highest_amt', 8, 2)->nullable();
            $table->timestamp('start_time', $precision = 0)->nullable();
            $table->timestamp('end_time', $precision = 0)->nullable();
            $table->foreignId('plant_id');
            $table->foreign('plant_id')->references('id')->on('plant');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('bidding');
    }
};
