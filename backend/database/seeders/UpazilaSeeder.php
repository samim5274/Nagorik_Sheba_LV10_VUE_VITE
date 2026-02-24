<?php

namespace Database\Seeders;

use App\Models\Upazila;
use App\Models\District;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Http;

class UpazilaSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $url = 'https://raw.githubusercontent.com/nuhil/bangladesh-geocode/master/upazilas/upazilas.json';

        $response = Http::timeout(60)->get($url);

        if ($response->failed()) {
            throw new \Exception("Failed to fetch upazila data from: {$url}");
        }

        $json = $response->json();

        $rows = collect($json)->firstWhere('type', 'table')['data'] ?? [];

        foreach ($rows as $row) {
            $districtId = (int) ($row['district_id'] ?? 0);

            $district = District::find($districtId);
            if (!$district) {
                continue; // skip if district missing
            }

            Upazila::updateOrCreate(
                ['id' => (int) $row['id']],
                [
                    'division_id' => $district->division_id, // ✅ add this
                    'district_id' => $districtId,
                    'name'        => $row['name'] ?? null,
                    'bn_name'     => $row['bn_name'] ?? null,
                    'url'         => $row['url'] ?? null,
                ]
            );
        }
    }
}
