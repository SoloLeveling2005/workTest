<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class News extends Model
{
    use HasFactory, SoftDeletes;

    protected $guarded = [];

    public function comments() {
        return $this->hasMany(Comment::class);
    }
    public function assessments() {
        return $this->hasMany(Assessment::class);
    }
    public function wakes() {
        return $this->hasMany(Wake::class);
    }

    public function author() {
        return $this->belongsTo(User::class, 'user_id');
    }
}
