<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class CustomSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('custom')->insertOrIgnore([
            [
                'name' => "Style 1",
                'image' => 'pinkred.jpg',
                'video' => 'pinkredlotus_video.mp4',
                'status' => "1",
            ],
            [
                'name' => "Style 2",
                'image' => 'pink_white.jpg',
                'video' => 'pinkwhitelotus_video.mp4',
                'status' => "1",
            ],
            [
                'name' => "Style 3",
                'image' => 'red.jpg',
                'video' => 'redlotus_video.mp4',
                'status' => "1",
            ],
        ]);
    }
}
