<?php

namespace App\Http\Controllers;

use App\Models\Room;
//use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class RoomController extends Controller
{
    public function index()
    {
       $today = \Carbon\Carbon::today()->toDateString();

        // 1. Lấy danh sách phòng cơ bản (giữ nguyên gốc của bạn)
        $rooms = Room::with(['roomType', 'roomForm'])->get();

        // 2. Dùng DB::table để lấy trực tiếp mã màu từ bảng bookings (Giống cách bạn làm ở hàm stats)
        $activeBookings = \Illuminate\Support\Facades\DB::table('booking_rooms')
            ->join('bookings', 'booking_rooms.booking_code', '=', 'bookings.booking_code')
            ->whereDate('booking_rooms.check_in', '<=', $today)
            ->whereDate('booking_rooms.check_out', '>', $today)
            ->select('booking_rooms.room_code', 'bookings.booking_code', 'bookings.booking_color', 'bookings.guest_name')
            ->get()
            ->keyBy('room_code'); // Gom nhóm theo mã phòng để dễ tra cứu

        // 3. Gắn màu sắc vào danh sách phòng trả về cho Vue
        $rooms->map(function ($room) use ($activeBookings) {
            if ($activeBookings->has($room->room_code)) {
                $booking = $activeBookings->get($room->room_code);
                $room->current_booking = [
                    'booking_code'  => $booking->booking_code,
                    'guest_name'    => $booking->guest_name,
                    'booking_color' => $booking->booking_color // Lấy mã màu từ DB
                ];
            } else {
                $room->current_booking = null;
            }

            return $room;
    });

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

        $oosCount = 0;
        $oooCount = 0;
        $lockedRooms = 0;
        if (DB::getSchemaBuilder()->hasTable('room_locks')) {
            $oosCount = DB::table('room_locks')
                ->where('lock_type', 'OOS')
                ->whereDate('start_date', '<=', $today)
                ->whereDate('end_date', '>=', $today)
                ->count();
            $oooCount = DB::table('room_locks')
                ->where('lock_type', 'OOO')
                ->whereDate('start_date', '<=', $today)
                ->whereDate('end_date', '>=', $today)
                ->count();
            $lockedRooms = DB::table('room_locks')
                ->whereNotNull('lock_type')
                ->whereDate('start_date', '<=', $today)
                ->whereDate('end_date', '>=', $today)
                ->count();
        }

        $occupiedPercent = $totalRooms > 0 ? round(($occupiedRooms / $totalRooms) * 100, 0) : 0;

        return response()->json([
            'overview' => [
                'arrivalForecast' => $arrivalsToday,
                'arrivalActual' => $arrivalsToday,
                'departureForecast' => $departuresToday,
                'departureActual' => $departuresToday,
                'occupiedActual' => $occupiedRooms,
                'occupiedEndOfDay' => $occupiedRooms,
                'occupiedTotal' => 0,
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
                'owner' => $ownerRooms,
                'dnd' => $dndRooms,
                'oos' => $oosCount,
                'ooo' => $oooCount,
                'occupiedPercent' => $occupiedPercent,
            ],
        ]);
    }
}
