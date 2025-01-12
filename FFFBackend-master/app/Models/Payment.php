<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use DateTimeInterface;

class Payment extends Model
{
    use HasFactory;

    public $table = 'payment';

    public $primaryKey = 'id';

    public $fk1 = 'order_id';

    public $fk2 = 'bidding_id';

    protected $fillable = [
        'status',
        'amount',
        'details',
        'method',
        'date',
        'order_id',
        'user_id',
        'bidding_id'
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
}
