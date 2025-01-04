<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use DateTimeInterface;

class Delivery extends Model
{
    use HasFactory;

    public $primaryKey = 'id';

    protected $table = 'delivery';

    public $fk = 'order_id';

    protected $fillable = [
        'tracking_number',
        'method',
        'status',
        'details',
        'expected_date',
        'order_id',
        'user_id',
        'prv_img',
        'created_at',
        'updated_at',
        'vendor_id',
    ];

    public const STATUS = [
        '0' => 'Disable',
        '1' => 'Enable',
    ];

    public $appends = [
        'image_url'
    ];

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

    public function getImageUrlAttribute()
    {
        return json_encode(asset('/delivery_prove/' . $this->prv_img));
    }

    public function order()
    {
        return $this->belongsTo(Order::class, 'order_id');
    }

    public function vendor()
    {
        return $this->belongsTo(Vendor::class, 'vendor_id');
    }
}
