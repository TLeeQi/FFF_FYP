<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use DateTimeInterface;

class Order extends Model
{
    use HasFactory;

    public $primaryKey = 'id';

    public $table = 'order';

    protected $fillable = [
        'status',
        'date',
        'total_amount',
        'address',
        'user_id',
        'receiver_name',
        'note',
        'price',
        'created_at',
        'updated_at',
    ];

    public const STATUS = [
        '0' => "cancel",
        '1' => "To Pay",
        '2' => "Completed",
        '3' => "To Ship",
        '4' => "Cancel"
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function order_detail()
    {
        return $this->hasMany(OrderDetailModel::class, 'order_id');
    }

    public function delivery()
    {
        return $this->hasOne(Delivery::class, 'order_id');
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
