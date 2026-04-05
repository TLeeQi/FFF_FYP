<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use DateTimeInterface;

class BiddingDetailModel extends Model
{
    use HasFactory;

    protected $table = 'bidding_detail';

    public $primaryKey = 'id';

    public $fk = 'user_id';

    public $fk1 = 'bidding_id';

    protected $fillable = [
        'amount',
        'refund_status',
        'payment_way',
        'user_id',
        'bidding_id',
        'created_at',
        'updated_at',
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
