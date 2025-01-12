<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use DateTimeInterface;

class Bidding extends Model
{
    use HasFactory;

    protected $table = 'bidding';

    public $primaryKey = 'id';

    public $fk = 'winner_id';

    public $fk1 = 'plant_id';

    protected $fillable = [
        'intial_amt',
        'min_amt',
        'status',
        'winner_id',
        'highest_amt',
        'start_time',
        'end_time',
        'plant_id',
    ];

    public const STATUS = [
        '0' => 'Disable',
        '1' => 'Enable',
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
