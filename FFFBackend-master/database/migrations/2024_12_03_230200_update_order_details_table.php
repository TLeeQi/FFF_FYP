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
        //
        Schema::table('order_detail', function (Blueprint $table) {
            $table->unsignedBigInteger('wiring_id')->nullable();
            $table->unsignedBigInteger('piping_id')->nullable();
            $table->unsignedBigInteger('gardening_id')->nullable();
            $table->unsignedBigInteger('runner_id')->nullable();
            //$table->dropColumn(['plant_id', 'bidding_id']);
    
            $table->foreign('wiring_id')->references('id')->on('wiring_details')->onDelete('cascade');
            $table->foreign('piping_id')->references('id')->on('piping_details')->onDelete('cascade');
            $table->foreign('gardening_id')->references('id')->on('gardening_details')->onDelete('cascade');
            $table->foreign('runner_id')->references('id')->on('runner_details')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        //
        Schema::table('order_detail', function (Blueprint $table) {
            $table->dropForeign(['wiring_id']);
            $table->dropForeign(['piping_id']);
            $table->dropForeign(['gardening_id']);
            $table->dropForeign(['runner_id']);
            
            $table->dropColumn(['wiring_id', 'piping_id', 'gardening_id', 'runner_id']);
        });
    }
};
