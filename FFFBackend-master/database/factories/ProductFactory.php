<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use App\Models\Category;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Product>
 */
class ProductFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $randomProductCategoryId = Category::where('type', 'Product')->inRandomOrder()->value('id');
        $randomElement =  'Product' . fake()->randomElement(['a', 'b', 'c'] + range(1, 100));

        $randomNumber = fake()->numberBetween(1, 12);
        $imageFilename =  (string)$randomNumber . '.png';

        return [
            'name' => $randomElement,
            'price' => fake()->randomFloat(2, 1, 100),
            'description' => fake()->paragraph() . fake()->paragraph() . fake()->paragraph(),
            'quantity' => fake()->numberBetween(1, 1000),
            'status' => "1",
            'image' =>  $imageFilename,
            'cat_id' => $randomProductCategoryId,
        ];
    }
}
