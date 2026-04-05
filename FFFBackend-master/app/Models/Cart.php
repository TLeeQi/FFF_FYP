<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use DateTimeInterface;

class Cart extends Model
{
    use HasFactory;

    protected $table = 'cart';

    public $primaryKey = 'id';

    public $fk1 = 'product_id';

    public $fk2 = 'plant_id';

    public $fk3 = 'bidding__id';

    public $fk4 = 'user_id';

    protected $fillable = [
        'quantity',
        'price',
        'date_added',
        'is_purchase',
        'product_id',
        'plant_id',
        'bidding_id',
        'user_id'
    ];

    public function product(): HasMany
    {
        return $this->hasMany(Product::class, 'product_id');
    }

    public function plant(): HasMany
    {
        return $this->hasMany(Plant::class, 'plant_id');
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
