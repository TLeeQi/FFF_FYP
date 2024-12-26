<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Vendor extends Model
{
    use HasFactory;

    protected $fillable = ['name', 'email', 'phone', 'address', 'rating', 'status', 'image'];

    public function ratings()
    {
        return $this->hasMany(VendorRating::class);
    }
}
