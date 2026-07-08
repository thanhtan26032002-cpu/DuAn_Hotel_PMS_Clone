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

        $today = \Carbon\Carbon::today()->toDateString();

        // Lấy danh sách phòng kèm Loại phòng và Hình thức phòng
        $rooms = Room::with(['roomType', 'roomForm'])->get();

        // Lấy danh sách thông tin đặt phòng liên quan đến ngày hôm nay
        $activeBookings = \Illuminate\Support\Facades\DB::table('booking_rooms')
            ->join('bookings', 'booking_rooms.booking_code', '=', 'bookings.booking_code')
            ->whereDate('booking_rooms.check_in', '<=', $today)
            ->whereDate('booking_rooms.check_out', '>=', $today)
            ->select(
                'booking_rooms.room_code',
                'booking_rooms.check_in',
                'booking_rooms.check_out',
                'booking_rooms.extra_bed',
                'bookings.booking_code',
                'bookings.guest_name',
                'bookings.booking_color'
            )
            ->get()
            ->groupBy('room_code');

        $rooms->map(function ($room) use ($activeBookings, $today) {
            $roomBookings = $activeBookings->get($room->room_code);

            // Đặt trạng thái mặc định ban đầu dựa trên DB rooms
            $room->is_occupied = (bool)$room->is_occupied;
            $room->is_arrival = false;
            $room->is_departure = false;
            $room->current_booking = null;

            if ($roomBookings) {
                foreach ($roomBookings as $bK) {
                    // Trạng thái: Khách đến hôm nay
                    if ($bK->check_in === $today) {
                        $room->is_arrival = true;
                    }
                    // Trạng thái: Khách đi hôm nay
                    if ($bK->check_out === $today) {
                        $room->is_departure = true;
                    }
                    // Trạng thái: Đang ở thực tế
                    if ($bK->check_in <= $today && $bK->check_out > $today) {
                        $room->is_occupied = true;
                    }

                    // Đồng bộ dữ liệu chi tiết trả về cho Vue
                    if ($room->is_occupied || $room->is_arrival || $room->is_departure) {
                        $room->guest_name = $bK->guest_name;
                        $room->booking_code = $bK->booking_code;
                        $room->check_in_date = \Carbon\Carbon::parse($bK->check_in)->format('d/m/Y');
                        $room->check_out_date = \Carbon\Carbon::parse($bK->check_out)->format('d/m/Y');
                        $room->extra_beds = $bK->extra_bed ? 1 : 0;
                        $room->current_booking = [
                            'booking_color' => $bK->booking_color ?? '#3b82f6' // Màu mặc định nếu DB trống
                        ];
                    }
                }
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
