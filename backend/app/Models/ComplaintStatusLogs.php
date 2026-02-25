<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ComplaintStatusLogs extends Model
{
    use HasFactory;

    public $timestamps = false;

    protected $fillable = [
        'complaint_id',
        'old_status',
        'new_status',
        'changed_by',
        'remark',
        'changed_ip',
        'changed_user_agent',
        'created_at',
    ];

    protected $casts = [
        'created_at' => 'datetime',
    ];

    public function complaint()
    {
        return $this->belongsTo(Complaint::class);
    }

    public function changedBy()
    {
        return $this->belongsTo(User::class, 'changed_by');
    }
}
