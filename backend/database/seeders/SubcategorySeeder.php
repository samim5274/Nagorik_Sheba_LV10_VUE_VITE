<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Category;
use App\Models\Subcategory;
use Illuminate\Support\Str;

class SubcategorySeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $data = [
            'Road & Transport' => [
                ['Pothole', 'গর্ত'],
                ['Broken Road', 'ভাঙা রাস্তা'],
                ['Road Blocked', 'রাস্তা বন্ধ'],
                ['Traffic Congestion', 'যানজট'],
                ['Damaged Bridge/Culvert', 'ভাঙা সেতু/কালভার্ট'],
            ],

            'Water Supply' => [
                ['No Water Supply', 'পানি নেই'],
                ['Low Water Pressure', 'কম পানির চাপ'],
                ['Water Leakage', 'পানির লিকেজ'],
                ['Dirty/Contaminated Water', 'দূষিত পানি'],
                ['Broken Water Line', 'পানির লাইন নষ্ট'],
            ],

            'Electricity' => [
                ['Power Outage', 'বিদ্যুৎ নেই'],
                ['Loose Electric Wire', 'ঝুলন্ত বৈদ্যুতিক তার'],
                ['Transformer Problem', 'ট্রান্সফরমার সমস্যা'],
                ['Electric Pole Damage', 'বৈদ্যুতিক খুঁটি ক্ষতিগ্রস্ত'],
                ['Frequent Load Shedding', 'ঘন ঘন লোডশেডিং'],
            ],

            'Drainage & Sewerage' => [
                ['Blocked Drain', 'ড্রেন বন্ধ'],
                ['Sewer Overflow', 'পয়ঃনিষ্কাশন উপচে পড়া'],
                ['Water Logging', 'জলাবদ্ধতা'],
                ['Drain Cover Broken', 'ড্রেনের ঢাকনা ভাঙা'],
                ['Bad Smell from Drain', 'ড্রেন থেকে দুর্গন্ধ'],
            ],

            'Waste Management' => [
                ['Garbage Not Collected', 'ময়লা অপসারণ হয়নি'],
                ['Overflowing Dustbin', 'ডাস্টবিন উপচে পড়ছে'],
                ['Illegal Dumping', 'অবৈধভাবে ময়লা ফেলা'],
                ['Dead Animal Removal', 'মরা প্রাণী অপসারণ'],
                ['Medical Waste', 'মেডিকেল বর্জ্য'],
            ],

            'Street Light' => [
                ['Light Not Working', 'লাইট কাজ করছে না'],
                ['Broken Pole Light', 'খুঁটির লাইট নষ্ট'],
                ['Daytime Light On', 'দিনে লাইট জ্বলছে'],
                ['New Street Light Request', 'নতুন স্ট্রিট লাইটের আবেদন'],
            ],

            'Environment' => [
                ['Air Pollution', 'বায়ু দূষণ'],
                ['Noise Pollution', 'শব্দ দূষণ'],
                ['Water Pollution', 'পানি দূষণ'],
                ['Tree Cutting', 'গাছ কাটা'],
                ['Smoke from Factory', 'কারখানার ধোঁয়া'],
            ],

            'Illegal Construction' => [
                ['Unauthorized Building', 'অননুমোদিত ভবন'],
                ['Footpath Occupation', 'ফুটপাত দখল'],
                ['Road Encroachment', 'রাস্তা দখল'],
                ['Unsafe Construction Work', 'অসুরক্ষিত নির্মাণকাজ'],
            ],

            'Market & Business' => [
                ['Overpricing', 'অতিরিক্ত দাম'],
                ['Adulterated Products', 'ভেজাল পণ্য'],
                ['Expired Products', 'মেয়াদোত্তীর্ণ পণ্য'],
                ['Illegal Shop Occupation', 'অবৈধ দোকান দখল'],
                ['No Price List', 'মূল্য তালিকা নেই'],
            ],

            'Public Safety' => [
                ['Open Manhole', 'খোলা ম্যানহোল'],
                ['Broken Footpath', 'ভাঙা ফুটপাত'],
                ['Stray Animals', 'ভাসমান/আবাসহীন প্রাণী'],
                ['Fire Hazard', 'অগ্নিঝুঁকি'],
                ['Dangerous Building', 'ঝুঁকিপূর্ণ ভবন'],
            ],

            'Health & Sanitation' => [
                ['Mosquito Breeding', 'মশার প্রজননস্থল'],
                ['Unclean Public Toilet', 'অপরিচ্ছন্ন পাবলিক টয়লেট'],
                ['Food Hygiene Issue', 'খাদ্য স্বাস্থ্যবিধি সমস্যা'],
                ['Stagnant Water', 'স্থির পানি'],
                ['Open Wastewater', 'খোলা নোংরা পানি'],
            ],

            'Others' => [
                ['General Complaint', 'সাধারণ অভিযোগ'],
                ['Service Delay', 'সেবায় বিলম্ব'],
                ['Staff Misbehavior', 'কর্মচারীর অসদাচরণ'],
                ['Suggestion', 'পরামর্শ'],
            ],
        ];

        foreach ($data as $categoryName => $subcategories) {
            $category = Category::where('name', $categoryName)->first();

            if (!$category) {
                continue;
            }

            foreach ($subcategories as $sub) {
                [$name, $bn_name] = $sub;

                Subcategory::updateOrCreate(
                    [
                        'category_id' => $category->id,
                        'name'        => $name,
                    ],
                    [
                        'bn_name' => $bn_name,
                        'slug'    => Str::slug($name),
                        'status'  => true,
                    ]
                );
            }
        }
    }
}
