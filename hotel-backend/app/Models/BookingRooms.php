<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class BookingRooms extends Model
{
    protected $table = 'booking_rooms';

    // Kết nối ngược từ booking_rooms về bảng bookings tổng để lấy màu sắc
    public function booking()
    {
        return $this->belongsTo(Bookings::class, 'booking_code', 'booking_code');
    }

    public function room()
    {
        return $this->belongsTo(Room::class, 'room_code', 'room_code');
    }
    public function roomType()
    {
        return $this->belongsTo(RoomType::class, 'room_type_id', 'id');
    }

    public function roomForm()
    {
        return $this->belongsTo(RoomForm::class, 'room_form_id', 'id');
    }
}
