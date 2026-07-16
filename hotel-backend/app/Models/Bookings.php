<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Bookings extends Model
{
    protected $table = 'bookings';

    public function bookingRooms()
    {
        return $this->hasMany(BookingRooms::class, 'booking_code', 'booking_code');
    }

    public function company()
    {
        return $this->belongsTo(Company::class, 'company_code', 'company_code');
    }

    public function status()
    {
        return $this->belongsTo(ReservationStatus::class, 'status_id', 'id');
    }

    public function employee()
    {
        return $this->belongsTo(Employee::class, 'employee_code', 'employee_code');
    }
}
