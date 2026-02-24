<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Division;
use Illuminate\Support\Facades\Http;

class DivisionSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $url = 'https://raw.githubusercontent.com/nuhil/bangladesh-geocode/master/divisions/divisions.json';

        $json = Http::timeout(60)->get($url)->json();

        $rows = collect($json)
            ->firstWhere('type', 'table')['data'] ?? [];

        foreach ($rows as $row) {
            Division::updateOrCreate(
                ['id' => (int) $row['id']],
                [
                    'name'    => $row['name'] ?? null,
                    'bn_name' => $row['bn_name'] ?? null,
                    'url'     => $row['url'] ?? null,
                ]
            );
        }
    }
}
