<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Category;
use Illuminate\Support\Str;

class CategorySeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $categories = [
            ['name' => 'Road & Transport', 'bn_name' => 'রাস্তা ও পরিবহন'],
            ['name' => 'Water Supply', 'bn_name' => 'পানি সরবরাহ'],
            ['name' => 'Electricity', 'bn_name' => 'বিদ্যুৎ'],
            ['name' => 'Drainage & Sewerage', 'bn_name' => 'ড্রেনেজ ও পয়ঃনিষ্কাশন'],
            ['name' => 'Waste Management', 'bn_name' => 'বর্জ্য ব্যবস্থাপনা'],
            ['name' => 'Street Light', 'bn_name' => 'স্ট্রিট লাইট'],
            ['name' => 'Environment', 'bn_name' => 'পরিবেশ'],
            ['name' => 'Illegal Construction', 'bn_name' => 'অবৈধ নির্মাণ'],
            ['name' => 'Market & Business', 'bn_name' => 'বাজার ও ব্যবসা'],
            ['name' => 'Public Safety', 'bn_name' => 'জননিরাপত্তা'],
            ['name' => 'Health & Sanitation', 'bn_name' => 'স্বাস্থ্য ও স্যানিটেশন'],
            ['name' => 'Others', 'bn_name' => 'অন্যান্য'],
        ];

        foreach ($categories as $item) {
            Category::updateOrCreate(
                ['name' => $item['name']],
                [
                    'bn_name' => $item['bn_name'],
                    'slug'    => Str::slug($item['name']),
                    'status'  => true,
                ]
            );
        }
    }
}
