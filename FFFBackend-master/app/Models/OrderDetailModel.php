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
        'delivery_id',
        'wiring_id',
        'piping_id',
        'gardening_id',
        'runner_id'
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

    public function wiringDetail()
    {
    return $this->belongsTo(WiringDetail::class, 'wiring_id', 'id');
    }
    public function pipingDetail()
    {
        return $this->belongsTo(PipingDetail::class, 'piping_id', 'id');
    }

    public function gardeningDetail()
    {
        return $this->belongsTo(GardeningDetail::class, 'gardening_id', 'id');
    }

    public function runnerDetail()
    {
        return $this->belongsTo(RunnerDetail::class, 'runner_id', 'id');
    }
}
