<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Room extends Model
{
    protected $table = 'rooms';

    // Hàm này giúp nối bảng rooms với bảng room_types
    public function roomType()
    {
        return $this->belongsTo(RoomType::class, 'room_type_id', 'id');
    }

    // Hàm này giúp nối bảng rooms với bảng room_forms
    public function roomForm()
    {
        return $this->belongsTo(RoomForm::class, 'room_form_id', 'id');
    }

    //  Hàm này giúp nối bảng rooms với bảng booking_rooms
    public function bookingRooms()
    {
        // Một phòng có thể nằm trong nhiều booking_rooms (theo lịch sử thời gian)
        return $this->hasMany(BookingRooms::class, 'room_code', 'room_code');
    }
}
