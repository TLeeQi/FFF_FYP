<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class GardeningDetail extends Model
{
    use HasFactory;

    protected $table = 'gardening_details';

    // Specify the fillable fields
    protected $fillable = [
        'type',
        'area',
        'types_property',
        'app_date',
        'preferred_time',
        'details',
        'photo',
        'budget',
    ];

    // Cast attributes to native types
    protected $casts = [
        'app_date' => 'date',
    ];

    public function orderDetail()
    {
        return $this->hasMany(OrderDetailModel::class, 'gardening_id', 'id');
    }
}
