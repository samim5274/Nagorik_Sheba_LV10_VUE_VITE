<?php

namespace Database\Seeders;

use App\Models\District;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Http;

class DistrictSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $url = 'https://raw.githubusercontent.com/nuhil/bangladesh-geocode/master/districts/districts.json';

        $json = Http::timeout(60)->get($url)->json();

        $rows = collect($json)
            ->firstWhere('type', 'table')['data'] ?? [];

        foreach ($rows as $row) {
            District::updateOrCreate(
                ['id' => (int) $row['id']],
                [
                    'division_id' => (int) $row['division_id'],
                    'name'        => $row['name'] ?? null,
                    'bn_name'     => $row['bn_name'] ?? null,
                    'lat'         => $row['lat'] ?? null,
                    'lon'         => $row['lon'] ?? null,
                    'url'         => $row['url'] ?? null,
                ]
            );
        }
    }
}
