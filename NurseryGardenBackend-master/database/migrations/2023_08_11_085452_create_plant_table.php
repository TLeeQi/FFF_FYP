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
        Schema::create('plant', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->integer('sales_amount')->nullable();
            $table->double('price', 8, 2);
            $table->longText('description');
            $table->integer('quantity');
            $table->string('sunlight_need');
            $table->string('water_need');
            $table->string('mature_height');
            $table->string('origin');
            $table->string('status')->default('1');;
            $table->string('image');
            $table->foreignId('cat_id');
            $table->foreign('cat_id')->references('id')->on('category');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('plant');
    }
};
