<?php

namespace App\Http\Controllers;

use App\Models\Room;
use Illuminate\Http\Request;

class RoomController extends Controller
{
    public function index()
    {
       $rooms = \App\Models\Room::with('roomType')->get();
       return response()->json($rooms);
    }
}
