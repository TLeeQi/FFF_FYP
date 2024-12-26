<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class VendorRating extends Model
{
    use HasFactory;

    protected $fillable = ['vendor_id', 'user_id', 'rating', 'review'];

    public function vendor()
    {
        return $this->belongsTo(Vendor::class);
    }
}