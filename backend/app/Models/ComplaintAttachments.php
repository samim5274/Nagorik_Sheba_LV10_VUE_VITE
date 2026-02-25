<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ComplaintAttachments extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = [
        'complaint_id',
        'uploaded_by',
        'context_type',
        'context_id',

        'original_name',
        'file_name',
        'file_path',
        'file_disk',
        'mime_type',
        'file_extension',
        'file_size',
        'file_hash',

        'is_image',
        'is_public',
        'sort_order',

        'uploaded_ip',
    ];

    protected $casts = [
        'is_image' => 'boolean',
        'is_public' => 'boolean',
    ];

    public function complaint()
    {
        return $this->belongsTo(Complaint::class);
    }

    public function uploadedBy()
    {
        return $this->belongsTo(User::class, 'uploaded_by');
    }

    // Optional generic parent helper (manual usage)
    public function contextComment()
    {
        return $this->belongsTo(ComplaintComment::class, 'context_id')
            ->where('context_type', 'comment');
    }
}
