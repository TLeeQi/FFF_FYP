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
        Schema::create('gardening_details', function (Blueprint $table) {
            $table->id();
            $table->string('type'); // e.g., Service
            $table->string('area'); // Stores area size
            $table->string('types_property'); // e.g., residential, commercial
            $table->date('app_date'); // Appointment Date
            $table->string('preferred_time'); // Appointment Time
            $table->string('details')->nullable(); // Additional details
            $table->json('photo')->nullable(); // JSON array of uploaded photos
            $table->string('budget'); // Budget
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
         // Ensure all foreign key constraints are dropped before dropping the table
         Schema::table('order_detail', function (Blueprint $table) {
            if (Schema::hasColumn('order_detail', 'gardening_id')) {
                $table->dropForeign(['gardening_id']);
            }
        });

        Schema::dropIfExists('gardening_details');
    }
};
