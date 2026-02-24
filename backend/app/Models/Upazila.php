<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Upazila extends Model
{
    use HasFactory;

    protected $fillable = ['district_id', 'name', 'bn_name', 'url'];

    public function district(): BelongsTo
    {
        return $this->belongsTo(District::class);
    }

    public function policeStations(): HasMany
    {
        return $this->hasMany(PoliceStation::class);
    }
}
