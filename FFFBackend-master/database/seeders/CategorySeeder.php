<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Category;
use Illuminate\Support\Facades\DB;

class CategorySeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('category')->insertOrIgnore([

            [
                'name' => "Wiring",
                'status' => "1",
                'type' => "Product",
            ],

            [
                'name' => "Piping",
                'status' => "1",
                'type' => "Product",
            ],

            [
                'name' => "Gardening",
                'status' => "1",
                'type' => "Product",
            ],

            [
                'name' => "Runner",
                'status' => "1",
                'type' => "Product",
            ],

        ]);
    }
}
