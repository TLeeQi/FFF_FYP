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
        'name', 
        'email', 
        'phone', 
        'address', 
        'rating', 
        'status', 
        'image',
        'description'];

    public $appends = [
        'image_url'
    ];

    public const STATUS = [
        '0' => 'Disable',
        '1' => 'Enable',
    ];

    public function getImageUrlAttribute()
    {
        return  json_encode(asset('/vendor_image/' . $this->image));
    }
    
    public function ratings()
    {
        return $this->hasMany(VendorRating::class);
    }
}
