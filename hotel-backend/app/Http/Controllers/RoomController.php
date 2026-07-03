<?php

namespace App\Http\Controllers;

use App\Models\Room;
use Illuminate\Http\Request;

class RoomController extends Controller
{
    public function index()
    {
       $rooms = Room::with(['roomType', 'roomForm'])->get();
       return response()->json($rooms);
    }
}
