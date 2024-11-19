<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use DateTimeInterface;

class Category extends Model
{
    use HasFactory;

    protected $table = "category";

    public $primaryKey = 'id';

    protected $fillable = [
        'name',
        'type',
        'status'
    ];

    public const STATUS = [
        '0' => 'Disable',
        '1' => 'Enable',
    ];

    public function product(): HasMany
    {
        return $this->hasMany(Product::class);
    }

    public function plant(): HasMany
    {
        return $this->hasMany(Plant::class);
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
