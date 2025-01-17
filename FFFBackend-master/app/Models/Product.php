<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use DateTimeInterface;

class Product extends Model
{
    use HasFactory;

    protected $table = "product";

    public $primaryKey = 'id';

    public $fk = 'cat_id';

    protected $fillable = [
        'name',
        'sales_amount',
        'price',
        'description',
        'quantity',
        'status',
        'image',
        'cat_id'
    ];

    public $appends = [
        'image_url'
    ];

    public const STATUS = [
        '0' => 'Disable',
        '1' => 'Enable',
    ];

    public function getImageUrlAttribute()
    {
        \Log::info('image: ' . $this->image);
        \Log::info('asset: ' . asset('/product_image/' . $this->image));
        \Log::info('json_encode: ' . json_encode(asset('/product_image/' . $this->image)));
        return  json_encode(asset('/product_image/' . $this->image));
    }

    public function category(): BelongsTo
    {
        return $this->belongsTo(Category::class, 'cat_id');
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
