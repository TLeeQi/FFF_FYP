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
        Schema::table('wiring_details', function (Blueprint $table) {
            $table->string('photo')->nullable()->change();
        });

        // Update photo column in piping_details
        Schema::table('piping_details', function (Blueprint $table) {
            $table->string('photo')->nullable()->change();
        });

        // Update photo column in gardening_details
        Schema::table('gardening_details', function (Blueprint $table) {
            $table->string('photo')->nullable()->change();
        });

        // Update photo column in runner_details
        Schema::table('runner_details', function (Blueprint $table) {
            $table->string('photo')->nullable()->change();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // Schema::table('wiring_piping_gardening_runner', function (Blueprint $table) {
        //     //
        // });
    }
};
