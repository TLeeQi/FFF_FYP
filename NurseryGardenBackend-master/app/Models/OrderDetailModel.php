<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use DateTimeInterface;

class OrderDetailModel extends Model
{
    use HasFactory;

    protected $table = "order_detail";

    public $primaryKey = 'id';

    protected $fillable = [
        'quantity',
        'price',
        'amount',
        'order_id',
        'remark',
        'product_id',
        'plant_id',
        'bidding_id',
        'delivery_id'
    ];

    public function order()
    {
        return $this->belongsTo(Order::class, 'order_id');
    }

    /**
     * Prepare a date for array / JSON serialization.
     *
     * @param  \DateTimeInterface  $date
     * @return string
     */
    protected function serializeDate(DateTimeInterface $date)
    {
        return $date->format('Y-m-d H:i:s');
    }
}
