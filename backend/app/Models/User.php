<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    protected $fillable = [
        'name',
        'email',
        'phone',
        'password',

        'dob',
        'gender',
        'blood_group',

        'present_address',
        'parmanent_address',

        'national_id',
        'religion',

        'role',
        'is_active',

        'photo',

        'tokens',
        'otp',
        'otp_expires_at',

        'email_verified_at',
        'phone_verified_at',
        'last_login_at',
        'last_login_ip',

        'is_profile_completed',
    ];

    protected $hidden = [
        'password',
        'remember_token',
        'otp',
    ];

    protected $casts = [
        'password' => 'hashed',

        'dob' => 'date',
        'is_active' => 'boolean',
        'is_profile_completed' => 'boolean',

        'email_verified_at' => 'datetime',
        'otp_expires_at' => 'datetime',
        'last_login_at' => 'datetime',
    ];
}
