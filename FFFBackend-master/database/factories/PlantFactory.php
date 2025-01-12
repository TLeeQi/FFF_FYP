<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use App\Models\Category;
use Faker\Generator as Faker;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Plant>
 */
class PlantFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $randomPlantCategoryId = Category::where('type', 'Plant')->inRandomOrder()->value('id');
        $randomElement =  'plant' . fake()->randomElement(['a', 'b', 'c'] + range(1, 100));

        $randomNumber = fake()->numberBetween(1, 20);
        $imageFilename = (string) $randomNumber . '.png';

        return [
            'name' => $randomElement,
            'quantity' => fake()->numberBetween(1, 1000),
            'cat_id' => $randomPlantCategoryId,
            'price' => fake()->randomFloat(2, 2, 100),
            'description' => fake()->paragraph() . fake()->paragraph() . fake()->paragraph(),
            'sunlight_need' => fake()->randomElement(['Full', 'Partial', 'Shade']),
            'water_need' => fake()->randomElement(['High', 'Moderate', 'Low']),
            'mature_height' => fake()->randomFloat(2, 1, 10),
            'origin' => fake()->country(),
            'image' => $imageFilename,
            'status' => "1",
        ];
    }
}
