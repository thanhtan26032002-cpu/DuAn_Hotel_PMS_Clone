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
}
