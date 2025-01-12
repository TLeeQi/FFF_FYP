<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Vendor extends Model
{
    use HasFactory;

    protected $table = "vendors";
    public $primaryKey = 'id';

    protected $fillable = [
        'rating', 
        'status', 
        'description',
        'user_id',
        'ssm_path',
        'category',
        'comment'
    ];

    public $appends = [
        'image_url'
    ];

    public const STATUS = [
        '0' => 'Disable',
        '1' => 'Enable',
    ];

    public function getImageUrlAttribute()
    {
        return  json_encode(asset('/user_image/' . $this->image));
    }
    
    public function ratings()
    {
        return $this->hasMany(VendorRating::class);
    }
    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function delivery()
    {
        return $this->hasMany(Delivery::class);
    }

}

