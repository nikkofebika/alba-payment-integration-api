<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;
use App\Models\User;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        User::create([
        	'first_name' => 'Nikko',
            'last_name' => 'Febika',
            'phone' => '085691977176',
        	'email' => 'admin@gmail.com',
        	'password' => Hash::make('admin'),
        ]);
    }
}
