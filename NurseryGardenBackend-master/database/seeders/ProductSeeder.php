<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Product;
use Illuminate\Support\Facades\DB;

class ProductSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // $randomPot = fake()->numberBetween(1, 5);
        // $randomSho = fake()->numberBetween(1, 3);
        // $randomSoil = fake()->numberBetween(1, 2);

        // $potFilename =  'pot' . (string)$randomPot . '.png';
        // $shovelFilename =  'shovel' . (string)$randomSho . '.png';
        // $soilFilename =  'soil' . (string)$randomSoil . '.jpeg';

        $potCategoryId = DB::table('category')->where('type', 'Product')->where('name', 'Pot')->value('id');
        $shovelCategoryId = DB::table('category')->where('type', 'Product')->where('name', 'Shovel')->value('id');
        $soilCategoryId = DB::table('category')->where('type', 'Product')->where('name', 'Soil')->value('id');

        for ($i = 1; $i < 30; $i++) {
            $randomPot = fake()->numberBetween(1, 5);
            $randomSho = fake()->numberBetween(1, 3);
            $randomSoil = fake()->numberBetween(1, 2);

            $potFilename =  'pot' . (string)$randomPot . '.png';
            $shovelFilename =  'shovel' . (string)$randomSho . '.png';
            $soilFilename =  'soil' . (string)$randomSoil . '.jpeg';

            $randomName = fake()->regexify('[A-Za-z0-9]{5}');

            DB::table('product')->insertOrIgnore([
                [
                    'name' => "pot" . $i,
                    'price' =>  fake()->randomFloat(2, 1, 100),
                    'description' => fake()->paragraph() . fake()->paragraph() . fake()->paragraph(),
                    'quantity' => fake()->numberBetween(1, 1000),
                    'status' => "1",
                    'image' =>  $potFilename,
                    'cat_id' => $potCategoryId,
                ],
                [
                    'name' => "shovel" . $i,
                    'price' =>  fake()->randomFloat(2, 1, 100),
                    'description' => fake()->paragraph() . fake()->paragraph() . fake()->paragraph(),
                    'quantity' => fake()->numberBetween(1, 1000),
                    'status' => "1",
                    'image' =>  $shovelFilename,
                    'cat_id' => $shovelCategoryId,
                ],
                [
                    'name' => "soil" . $i,
                    'price' =>  fake()->randomFloat(2, 1, 100),
                    'description' => fake()->paragraph() . fake()->paragraph() . fake()->paragraph(),
                    'quantity' => fake()->numberBetween(1, 1000),
                    'status' => "1",
                    'image' =>  $soilFilename,
                    'cat_id' => $soilCategoryId
                ],
            ]);
        }

        DB::table('product')->insertOrIgnore([
            [
                'name' => "Pot Brown",
                'price' =>  20.00,
                'description' => fake()->paragraph() . fake()->paragraph() . fake()->paragraph(),
                'quantity' => 10000,
                'status' => "custom",
                'image' =>  'pot_brown.png',
                'cat_id' => $potCategoryId,
            ],
            [
                'name' => "Pot Choco",
                'price' =>  20.00,
                'description' => fake()->paragraph() . fake()->paragraph() . fake()->paragraph(),
                'quantity' => 10000,
                'status' => "custom",
                'image' =>  'pot_choco.png',
                'cat_id' => $potCategoryId,
            ],
            [
                'name' => "Pot Red",
                'price' =>  20.00,
                'description' => fake()->paragraph() . fake()->paragraph() . fake()->paragraph(),
                'quantity' => 10000,
                'status' => "custom",
                'image' =>  'pot_red.png',
                'cat_id' => $potCategoryId,
            ],
            [
                'name' => "Pot Low",
                'price' =>  40.00,
                'description' => fake()->paragraph() . fake()->paragraph() . fake()->paragraph(),
                'quantity' => 10000,
                'status' => "custom",
                'image' =>  'pot4_low.png',
                'cat_id' => $potCategoryId,
            ],
            [
                'name' => "Black Soil",
                'price' =>  10.00,
                'description' => fake()->paragraph() . fake()->paragraph() . fake()->paragraph(),
                'quantity' => 10000,
                'status' => "custom",
                'image' =>  'soil1.jpeg',
                'cat_id' => $soilCategoryId,
            ],
            [
                'name' => "Yellow Soil",
                'price' =>  10.00,
                'description' => fake()->paragraph() . fake()->paragraph() . fake()->paragraph(),
                'quantity' => 10000,
                'status' => "custom",
                'image' =>  'soil2.jpeg',
                'cat_id' => $soilCategoryId,
            ],
        ]);

        // for ($i = 1; $i < 6; $i++) {
        //     $potFile = 'cpot' . (string)$i . '.jpg';
        //     DB::table('product')->insertOrIgnore([
        //         [
        //             'name' => "cpot" . $i,
        //             'price' =>  fake()->randomFloat(2, 1, 100),
        //             'description' => fake()->paragraph() . fake()->paragraph() . fake()->paragraph(),
        //             'quantity' => fake()->numberBetween(1, 1000),
        //             'status' => "custom",
        //             'image' =>  $potFile,
        //             'cat_id' => $potCategoryId,
        //         ],
        //     ]);
        // }

        // for ($i = 1; $i < 3; $i++) {
        //     $soilFile = 'soil' . (string)$i . '.jpeg';
        //     DB::table('product')->insertOrIgnore([
        //         [
        //             'name' => "soil" . $i,
        //             'price' =>  fake()->randomFloat(2, 1, 100),
        //             'description' => fake()->paragraph() . fake()->paragraph() . fake()->paragraph(),
        //             'quantity' => 1000,
        //             'status' => "custom",
        //             'image' =>  $soilFile,
        //             'cat_id' => $soilCategoryId,
        //         ],
        //     ]);
        // }
        // Product::Factory()->count(100)->create();
    }
}
