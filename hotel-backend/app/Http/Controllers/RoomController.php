<?php

namespace App\Http\Controllers;

use App\Models\Room;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class RoomController extends Controller
{
    public function index()
    {
       $rooms = Room::with(['roomType', 'roomForm'])->get();
       return response()->json($rooms);
    }

    public function stats()
    {
        $today = Carbon::today()->toDateString();

        $totalRooms = DB::table('rooms')->count();
        $readyRooms = DB::table('rooms')->where('clean_status', 'Clean')->count();
        $dirtyRooms = DB::table('rooms')->where('clean_status', 'Dirty')->count();
        $inspectedRooms = DB::table('rooms')->where('clean_status', 'Inspected')->count();
        $internalRooms = DB::table('rooms')->where('is_internal', true)->count();
        $ownerRooms = DB::table('rooms')->where('is_owner_room', true)->count();
        $dndRooms = DB::table('rooms')->where('is_dnd', true)->count();
        $makeupRooms = DB::table('rooms')->where('is_makeup_room', true)->count();

        $arrivalsToday = DB::table('booking_rooms')->where('check_in', $today)->count();
        $departuresToday = DB::table('booking_rooms')->where('check_out', $today)->count();
        $occupiedRooms = DB::table('booking_rooms')
            ->where('check_in', '<=', $today)
            ->where('check_out', '>', $today)
            ->distinct('room_code')
            ->count('room_code');

        $complimentaryRooms = DB::table('booking_rooms')
            ->join('bookings', 'booking_rooms.booking_code', '=', 'bookings.booking_code')
            ->where('bookings.payment_method_code', 'CL')
            ->count();

        $lateCheckIns = DB::table('booking_rooms')
            ->where('check_in', $today)
            ->whereNotNull('arrival_time')
            ->where('arrival_time', '>', '14:00:00')
            ->count();

        $extraBeds = DB::table('booking_rooms')->where('extra_bed', true)->count();
        $lockedRooms = 0;
        if (DB::getSchemaBuilder()->hasTable('room_locks')) {
            $lockedRooms = DB::table('room_locks')->where('status', 'Locked')->count();
        }

        return response()->json([
            'overview' => [
                'arrivalForecast' => $arrivalsToday,
                'arrivalActual' => $arrivalsToday,
                'departureForecast' => $departuresToday,
                'departureActual' => $departuresToday,
                'occupiedActual' => $occupiedRooms,
                'occupiedEndOfDay' => $occupiedRooms,
                'total' => $totalRooms,
            ],
            'status' => [
                'ready' => $readyRooms,
                'clean' => $readyRooms,
                'dirty' => $dirtyRooms,
                'occupied' => $occupiedRooms,
                'vacant' => max(0, $totalRooms - $occupiedRooms),
                'locked' => $lockedRooms,
                'inspection' => $makeupRooms,
                'lateCheckIn' => $lateCheckIns,
                'complimentary' => $complimentaryRooms,
                'extraBeds' => $extraBeds,
                'internal' => $internalRooms,
                'sellable' => max(0, $totalRooms - $internalRooms - $ownerRooms),
                'owner' => $ownerRooms,
                'dnd' => $dndRooms,
            ],
        ]);
    }
}
