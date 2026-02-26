<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Complaint extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = [
        'complaint_no',
        'user_id',
        'category_id',
        'sub_category_id',
        'title',
        'description',
        'priority',
        'status',

        'division_id',
        'district_id',
        'upazila_id',
        'police_station_id',
        'ward_no',
        'address_line',
        'landmark',
        'latitude',
        'longitude',

        'complainant_name',
        'complainant_phone',
        'complainant_email',

        'attachment',
        'attachments',

        'assigned_to',
        'assigned_at',
        'admin_remark',
        'action_taken',
        'rejected_reason',
        'resolved_at',
        'closed_at',

        'is_public',
        'is_anonymous',

        'source',
        'submitted_ip',
        'submitted_user_agent',
        'submitted_device',
        'submitted_platform',
        'submitted_browser',

        'is_edited',
        'is_deleted_by_user',
        'is_spam',
        'is_duplicate',
    ];

    protected $casts = [
        'attachments' => 'array',
        'latitude' => 'decimal:7',
        'longitude' => 'decimal:7',
        'assigned_at' => 'datetime',
        'resolved_at' => 'datetime',
        'closed_at' => 'datetime',

        'is_public' => 'boolean',
        'is_anonymous' => 'boolean',
        'is_edited' => 'boolean',
        'is_deleted_by_user' => 'boolean',
        'is_spam' => 'boolean',
        'is_duplicate' => 'boolean',
    ];

    /*
    |--------------------------------------------------------------------------
    | Relationships
    |--------------------------------------------------------------------------
    */

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function assignedUser()
    {
        return $this->belongsTo(User::class, 'assigned_to');
    }

    public function category()
    {
        return $this->belongsTo(Category::class);
    }

    public function subCategory()
    {
        return $this->belongsTo(Subcategory::class, 'sub_category_id');
    }

    public function division()
    {
        return $this->belongsTo(Division::class);
    }

    public function district()
    {
        return $this->belongsTo(District::class);
    }

    public function upazila()
    {
        return $this->belongsTo(Upazila::class);
    }

    public function policeStation()
    {
        return $this->belongsTo(PoliceStation::class);
    }

    public function statusLogs()
    {
        return $this->hasMany(ComplaintStatusLog::class);
    }

    public function comments()
    {
        return $this->hasMany(ComplaintComment::class);
    }

    public function publicComments()
    {
        return $this->hasMany(ComplaintComment::class)
            ->where('is_internal', false)
            ->where('is_deleted', false);
    }

    public function attachmentsList()
    {
        return $this->hasMany(ComplaintAttachment::class);
    }

    public function editLogs()
    {
        return $this->hasMany(ComplaintEditLog::class);
    }

    public function activityLogs()
    {
        return $this->hasMany(ComplaintActivityLog::class);
    }
}
