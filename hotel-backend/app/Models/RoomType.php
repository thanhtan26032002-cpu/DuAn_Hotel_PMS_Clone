<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class RoomType extends Model
{
    // Báo cho Laravel biết Model này kết nối với bảng room_types trong MySQL
    protected $table = 'room_types';
}
