<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class RunnerDetail extends Model
{
    use HasFactory;

    protected $table = 'runner_details';

    // Specify the fillable fields
    protected $fillable = [
        'type',
        'area',
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
        return $this->hasMany(OrderDetailModel::class, 'runner_id', 'id');
    }
}
