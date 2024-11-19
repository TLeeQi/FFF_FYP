<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use DateTimeInterface;

class Custom extends Model
{
    use HasFactory;

    protected $table = 'custom';

    public $primaryKey = 'id';

    protected $fillable = [
        'name',
        'image',
        'video',
        'status',
    ];

    public $appends = [
        'image_url',
        'video_url',
    ];

    public function getImageUrlAttribute()
    {
        return json_encode(asset('/custom/' . $this->image));
    }

    public function getVideoUrlAttribute()
    {
        // return asset('/custom/' . $this->video);
        return json_encode(asset('/custom/' . $this->video));
    }

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
