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
                'name' => "Lotus",
                'status' => "1",
                'type' => "Plant",
            ],
            [
                'name' => "Desert Rose",
                'status' => "1",
                'type' => "Plant",
            ],
            [
                'name' => "Cactus",
                'status' => "1",
                'type' => "Plant",
            ],
            [
                'name' => "Hydrangeas",
                'status' => "1",
                'type' => "Plant",
            ],
            [
                'name' => "Soil",
                'status' => "1",
                'type' => "Product",
            ],

            [
                'name' => "Pot",
                'status' => "1",
                'type' => "Product",
            ],

            [
                'name' => "Shovel",
                'status' => "1",
                'type' => "Product",
            ],

        ]);
    }
}
