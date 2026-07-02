<?php

namespace App\Http\Controllers;

use App\Models\Room;
use Illuminate\Http\Request;

class RoomController extends Controller
{
    public function danhsachPhong()
    {
        $rooms = Room::all();
        return response()->json($rooms);
    }
}
