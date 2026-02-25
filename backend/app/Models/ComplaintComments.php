<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ComplaintComments extends Model
{
    use HasFactory;

    protected $fillable = [
        'complaint_id',
        'user_id',
        'parent_id',
        'comment',

        'is_admin',
        'is_internal',

        'is_edited',
        'edited_at',
        'edited_by',

        'is_deleted',
        'deleted_at',
        'deleted_by',
        'delete_reason',

        'comment_ip',
        'comment_user_agent',
    ];

    protected $casts = [
        'is_admin' => 'boolean',
        'is_internal' => 'boolean',
        'is_edited' => 'boolean',
        'is_deleted' => 'boolean',
        'edited_at' => 'datetime',
        'deleted_at' => 'datetime',
    ];

    public function complaint()
    {
        return $this->belongsTo(Complaint::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function parent()
    {
        return $this->belongsTo(ComplaintComment::class, 'parent_id');
    }

    public function replies()
    {
        return $this->hasMany(ComplaintComment::class, 'parent_id');
    }

    public function editedBy()
    {
        return $this->belongsTo(User::class, 'edited_by');
    }

    public function deletedBy()
    {
        return $this->belongsTo(User::class, 'deleted_by');
    }

    public function reactions()
    {
        return $this->hasMany(ComplaintCommentReaction::class, 'comment_id');
    }

    public function attachments()
    {
        return $this->hasMany(ComplaintAttachment::class, 'context_id')
            ->where('context_type', 'comment');
    }
}
