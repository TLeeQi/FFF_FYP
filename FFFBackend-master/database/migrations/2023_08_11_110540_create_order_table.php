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
        Schema::create('order', function (Blueprint $table) {
            $table->id();
            $table->string('status');
            $table->date('date');
            $table->double('total_amount', 8, 2);
            $table->foreignId('user_id');
            $table->foreign('user_id')->references('id')->on('users');
            $table->string('address');
            $table->string('receiver_name')->nullable();
            $table->longText('note')->nullable();
            $table->string('is_separate')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('order');
    }
};
