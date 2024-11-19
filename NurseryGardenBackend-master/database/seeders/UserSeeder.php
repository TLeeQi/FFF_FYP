<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\User;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('users')->insertOrIgnore([
            [
                'name' => "sadmin",
                'email' => "sadmin@gmail.com",
                'password' => Hash::make("12121212"),
                'type' => "sadmin",
            ],
            [
                'name' => "admin",
                'email' => "admin@gmail.com",
                'password' => Hash::make("12121212"),
                'type' => "admin",
            ],
            [
                'name' => "user",
                'email' => "user@gmail.com",
                'password' => Hash::make("12121212"),
                'type' => "user",
            ],
            [
                'name' => "user1",
                'email' => "user1@gmail.com",
                'password' => Hash::make("12121212"),
                'type' => "user",
            ],
            [
                'name' => "d_01",
                'email' => "delivery@gmail.com",
                'password' => Hash::make("12121212"),
                'type' => "delivery",
            ]
        ]);
        User::factory()->count(50)->create();
    }
}
