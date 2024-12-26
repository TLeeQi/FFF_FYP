<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class WiringDetail extends Model
{
    use HasFactory;

    // Specify the table name if it doesn't follow Laravel's naming convention
    protected $table = 'wiring_details';

    // Specify the fillable fields
    protected $fillable = [
        'type',
        'fixitem',
        'ishavepart',
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
        'ishavepart' => 'boolean',
        'photo' => 'array',
        'app_date' => 'date',
    ];

    public function orderDetail()
    {
        return $this->hasMany(OrderDetailModel::class, 'wiring_id', 'id');
    }
}
