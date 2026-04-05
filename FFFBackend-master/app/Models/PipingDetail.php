<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PipingDetail extends Model
{
    use HasFactory;

    protected $table = 'piping_details';

    // Specify the fillable fields
    protected $fillable = [
        'type',
        'fixitem',
        'problem',
        'types_property',
        'app_date',
        'preferred_time',
        'details',
        'photo',
        'budget',
    ];

    // Cast attributes to native types
    protected $casts = [
        'fixitem' => 'array',
        'problem' => 'array',
        'app_date' => 'date',
    ];

    public function orderDetail()
    {
        return $this->hasMany(OrderDetailModel::class, 'piping_id', 'id');
    }
}
