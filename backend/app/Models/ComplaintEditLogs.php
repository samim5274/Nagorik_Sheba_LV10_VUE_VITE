<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ComplaintEditLogs extends Model
{
    use HasFactory;

    public $timestamps = false;

    protected $fillable = [
        'complaint_id',
        'edited_by',
        'field_name',
        'old_value',
        'new_value',
        'edit_reason',
        'edited_ip',
        'edited_user_agent',
        'created_at',
    ];

    protected $casts = [
        'created_at' => 'datetime',
    ];

    public function complaint()
    {
        return $this->belongsTo(Complaint::class);
    }

    public function editedBy()
    {
        return $this->belongsTo(User::class, 'edited_by');
    }
}
