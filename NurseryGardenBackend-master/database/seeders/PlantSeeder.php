<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Plant;
use Illuminate\Support\Facades\DB;

class PlantSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $lotusCategoryId = DB::table('category')->where('type', 'Plant')->where('name', 'Lotus')->value('id');
        $cactusCategoryId = DB::table('category')->where('type', 'Plant')->where('name', 'Cactus')->value('id');
        $hydranCategoryId = DB::table('category')->where('type', 'Plant')->where('name', 'Hydrangeas')->value('id');
        $dRoseCategoryId = DB::table('category')->where('type', 'Plant')->where('name', 'Desert Rose')->value('id');

        for ($i = 1; $i < 30; $i++) {
            $randomLotus = fake()->numberBetween(1, 6);
            $randomCactus = fake()->numberBetween(1, 2);
            $randomHydran = fake()->numberBetween(1, 3);
            $randomDRose = fake()->numberBetween(1, 4);

            $lotusFilename =  'Lotus' . (string)$randomLotus . '.png';
            $cactusFilename =  'cactus' . (string)$randomCactus . '.png';
            $hydranFilename =  'Hydran' . (string)$randomHydran . '.png';
            $dRoseFilename =  'DRose' . (string)$randomDRose . '.png';

            $randomName = fake()->regexify('[A-Za-z0-9]{5}');

            DB::table('plant')->insertOrIgnore([
                [
                    'name' => "Lotus" . $i,
                    'quantity' => fake()->numberBetween(1, 1000),
                    'cat_id' => $lotusCategoryId,
                    'price' => fake()->randomFloat(2, 2, 100),
                    'description' => fake()->paragraph() . fake()->paragraph() . fake()->paragraph(),
                    'sunlight_need' => fake()->randomElement(['Full', 'Partial', 'Shade']),
                    'water_need' => fake()->randomElement(['High', 'Moderate', 'Low']),
                    'mature_height' => fake()->randomFloat(2, 1, 10),
                    'origin' => fake()->country(),
                    'image' => $lotusFilename,
                    'status' => "1",
                ],
                [
                    'name' => "Cactus" . $i,
                    'quantity' => fake()->numberBetween(1, 1000),
                    'cat_id' => $cactusCategoryId,
                    'price' => fake()->randomFloat(2, 2, 100),
                    'description' => fake()->paragraph() . fake()->paragraph() . fake()->paragraph(),
                    'sunlight_need' => fake()->randomElement(['Full', 'Partial', 'Shade']),
                    'water_need' => fake()->randomElement(['High', 'Moderate', 'Low']),
                    'mature_height' => fake()->randomFloat(2, 1, 10),
                    'origin' => fake()->country(),
                    'image' => $cactusFilename,
                    'status' => "1",
                ],
                [
                    'name' => "Desert Rose" . $i,
                    'quantity' => fake()->numberBetween(1, 1000),
                    'cat_id' => $dRoseCategoryId,
                    'price' => fake()->randomFloat(2, 2, 100),
                    'description' => fake()->paragraph() . fake()->paragraph() . fake()->paragraph(),
                    'sunlight_need' => fake()->randomElement(['Full', 'Partial', 'Shade']),
                    'water_need' => fake()->randomElement(['High', 'Moderate', 'Low']),
                    'mature_height' => fake()->randomFloat(2, 1, 10),
                    'origin' => fake()->country(),
                    'image' => $dRoseFilename,
                    'status' => "1",
                ],
                [
                    'name' => "Hydrangeas" . $i,
                    'quantity' => fake()->numberBetween(1, 1000),
                    'cat_id' => $hydranCategoryId,
                    'price' => fake()->randomFloat(2, 2, 100),
                    'description' => fake()->paragraph() . fake()->paragraph() . fake()->paragraph(),
                    'sunlight_need' => fake()->randomElement(['Full', 'Partial', 'Shade']),
                    'water_need' => fake()->randomElement(['High', 'Moderate', 'Low']),
                    'mature_height' => fake()->randomFloat(2, 1, 10),
                    'origin' => fake()->country(),
                    'image' => $hydranFilename,
                    'status' => "1",
                ]
            ]);
        }

        DB::table('plant')->insertOrIgnore([
            [
                'name' => "Desert Rose Pink Red",
                'quantity' => 10000,
                'cat_id' => $dRoseCategoryId,
                'price' => 20.00,
                'description' => fake()->paragraph() . fake()->paragraph() . fake()->paragraph(),
                'sunlight_need' =>  'Partial',
                'water_need' => 'Moderate',
                'mature_height' => 1.2,
                'origin' => 'Malaysia',
                'image' => 'DesertRosePinkRed.jpg',
                'status' => "custom",
            ],
            [
                'name' => "Desert Rose Red",
                'quantity' => 10000,
                'cat_id' => $dRoseCategoryId,
                'price' => 20.00,
                'description' => fake()->paragraph() . fake()->paragraph() . fake()->paragraph(),
                'sunlight_need' =>  'Partial',
                'water_need' => 'Moderate',
                'mature_height' => 1.2,
                'origin' => 'Malaysia',
                'image' => 'DesertRoseRed.jpg',
                'status' => "custom",
            ],
            [
                'name' => "Desert Rose Pink White",
                'quantity' => 10000,
                'cat_id' => $dRoseCategoryId,
                'price' => 50.00,
                'description' => fake()->paragraph() . fake()->paragraph() . fake()->paragraph(),
                'sunlight_need' =>  'Partial',
                'water_need' => 'Moderate',
                'mature_height' => 1.2,
                'origin' => 'Malaysia',
                'image' => 'DesertRosePinkWhite.jpg',
                'status' => "custom",
            ],
        ]);
    }
}
