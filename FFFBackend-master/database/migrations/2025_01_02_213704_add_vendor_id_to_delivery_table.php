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
        Schema::table('delivery', function (Blueprint $table) {
            $table->unsignedBigInteger('vendor_id')->nullable()->after('order_id'); // Add user_id column
            $table->foreign('vendor_id') // Add foreign key constraint
                ->references('id')
                ->on('vendors')
                ->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('delivery', function (Blueprint $table) {
            $table->dropForeign(['vendor_id']); // Drop foreign key constraint
            $table->dropColumn('vendor_id'); // Drop user_id column
        });
    }
};
