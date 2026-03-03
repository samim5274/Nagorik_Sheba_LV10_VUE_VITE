<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ComplaintReaction extends Model
{
    use HasFactory;

    protected $table = 'complaint_reactions';

    protected $fillable = [
        'complaint_id',
        'user_id',
        'type', // like | dislike
    ];

    protected $casts = [
        'complaint_id' => 'integer',
        'user_id'      => 'integer',
    ];

    // relations
    public function complaint()
    {
        return $this->belongsTo(Complaint::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    // optional helpers (counts)
    public function scopeLike($q)
    {
        return $q->where('type', 'like');
    }

    public function scopeDislike($q)
    {
        return $q->where('type', 'dislike');
    }
}
