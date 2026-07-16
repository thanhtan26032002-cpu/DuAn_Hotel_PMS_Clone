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
        $now   = Carbon::now('Asia/Ho_Chi_Minh');
        $today = $now->toDateString();

        // Lấy danh sách phòng kèm Loại phòng và Hình thức phòng
        $rooms = Room::with(['roomType', 'roomForm'])->get();

        // Lấy danh sách thông tin đặt phòng liên quan đến ngày hôm nay
        $activeBookings = DB::table('booking_rooms')
            ->join('bookings', 'booking_rooms.booking_code', '=', 'bookings.booking_code')
            ->whereDate('booking_rooms.check_in', '<=', $today)
            ->whereDate('booking_rooms.check_out', '>=', $today)
            ->select(
                'booking_rooms.room_code',
                'booking_rooms.check_in',
                'booking_rooms.check_out',
                'booking_rooms.extra_bed',
                'bookings.booking_code',
                'booking_rooms.guest_name',
                'bookings.booking_color',
                'booking_rooms.adults',
                'booking_rooms.children',
                'booking_rooms.arrival_time',
                'booking_rooms.departure_time',
                'booking_rooms.room_status',
            )
            ->get()
            ->groupBy('room_code');

        $rooms->map(function ($room) use ($activeBookings, $today, $now) {
            $roomBookings = $activeBookings->get($room->room_code);

            $room->is_occupied  = false;
            $room->is_arrival   = false;
            $room->is_departure = false;
            $room->current_booking = null;

            if ($roomBookings) {
                foreach ($roomBookings as $bk) {
                    // Tổng hợp DATETIME check-in / check-out thực tế
                    $arrivalTime   = $bk->arrival_time   ?? '14:00:00';
                    $departureTime = $bk->departure_time ?? '12:00:00';

                    $arrivalDt   = Carbon::parse($bk->check_in . ' ' . $arrivalTime, 'Asia/Ho_Chi_Minh');
                    $departureDt = Carbon::parse($bk->check_out . ' ' . $departureTime, 'Asia/Ho_Chi_Minh');

                    // Chưa đến: check_in hôm nay, chưa đến giờ arrival
                    $isArrivalPending = ($bk->check_in === $today && $now->lt($arrivalDt));

                    // Đã đến (trong 30 phút đầu): check_in hôm nay, đã qua giờ arrival nhưng chưa đủ 30'
                    $arrivedAt30      = $arrivalDt->copy()->addMinutes(30);
                    $isJustArrived    = ($bk->check_in === $today && $now->gte($arrivalDt) && $now->lt($arrivedAt30));

                    // Đang ở thực sự: đã qua 30' kể từ arrival, chưa đến departure
                    $isFullyOccupied  = $now->gte($arrivedAt30) && $now->lt($departureDt)
                                        && ($bk->check_out > $today || ($bk->check_out === $today && $now->lt($departureDt)));

                    // Phòng từ hôm qua trở về trước vẫn còn checkout >= hôm nay
                    $isCarryOver      = ($bk->check_in < $today) && $now->lt($departureDt);

                    // Sắp đi (trong 30' trước departure): chỉ tính hôm nay
                    $warningDt        = $departureDt->copy()->subMinutes(30);
                    $isDepartureSoon  = ($bk->check_out === $today && $now->gte($warningDt) && $now->lt($departureDt));

                    // Đã đi
                    $hasDeparted      = $now->gte($departureDt);

                    // Gắn cờ trạng thái phòng trên thẻ card
                    if ($isArrivalPending) {
                        $room->is_arrival = true; // Chưa đến (màu xanh lá)
                    }
                    if ($isJustArrived || $isFullyOccupied || $isCarryOver) {
                        $room->is_occupied = true;
                    }
                    if ($isDepartureSoon && !$hasDeparted) {
                        $room->is_departure = true; // Sắp đi (màu đỏ)
                    }

                    // Đồng bộ dữ liệu chi tiết trả về cho Vue
                    if (!$hasDeparted) {
                        $room->guest_name      = $bk->guest_name;
                        $room->booking_code    = $bk->booking_code;
                        $room->check_in_date   = Carbon::parse($bk->check_in)->format('d/m/Y');
                        $room->check_out_date  = Carbon::parse($bk->check_out)->format('d/m/Y');
                        $room->extra_beds      = $bk->extra_bed ? 1 : 0;
                        $room->actual_guests   = ($bk->adults ?? 0) + ($bk->children ?? 0);
                        $room->current_booking = [
                            'booking_color' => $bk->booking_color ?? '#3b82f6',
                        ];
                    }
                }
            }

            return $room;
        });

        return response()->json($rooms);
    }

    public function arrivals()
    {
        $now   = Carbon::now('Asia/Ho_Chi_Minh');
        $today = $now->toDateString();

        // Lấy tất cả bookings có booking_rooms có check_in hôm nay
        $bookings = \App\Models\Bookings::with(['bookingRooms' => function ($query) use ($today) {
                $query->with('room')->whereDate('check_in', $today);
            }, 'company', 'status'])
            ->whereHas('bookingRooms', function ($query) use ($today) {
                $query->whereDate('check_in', $today);
            })
            ->get();

        $notArrived = [];
        $arrived    = [];

        foreach ($bookings as $booking) {
            $rooms      = $booking->bookingRooms;
            $totalRooms = $rooms->count();

            // Tính số phòng đã đến dựa theo giờ thực tế
            $arrivedCount = $rooms->filter(function ($r) use ($now) {
                $arrivalTime = $r->arrival_time ?? '14:00:00';
                $arrivalDt   = Carbon::parse($r->check_in . ' ' . $arrivalTime, 'Asia/Ho_Chi_Minh');
                return $now->gte($arrivalDt);
            })->count();

            $statusName = $booking->status ? $booking->status->status_name : 'Unknown';

            $bookingData = [
                'booking_code'     => $booking->booking_code,
                'reference_code'   => $booking->reference_code ?? '',
                'guest_name'       => $booking->guest_name ?? '',
                'company_name'     => $booking->company ? $booking->company->name : '',
                'status'           => $statusName,
                'total_rooms'      => $totalRooms,
                'checked_in_rooms' => $arrivedCount,
                'notes'            => $booking->notes ?? '',
                'booking_color'    => $booking->booking_color ?? '#3b82f6',
                'rooms'            => $rooms->map(function ($r) use ($now) {
                    $arrivalTime = $r->arrival_time ?? '14:00:00';
                    $arrivalDt   = Carbon::parse($r->check_in . ' ' . $arrivalTime, 'Asia/Ho_Chi_Minh');
                    return [
                        'room_code'    => $r->room_code,
                        'room_status'  => $r->room_status,
                        'clean_status' => $r->room ? $r->room->clean_status : null,
                        'check_in'     => $r->check_in,
                        'check_out'    => $r->check_out,
                        'has_arrived'  => $now->gte($arrivalDt),
                    ];
                })->values(),
            ];

            // Nếu tất cả phòng đã đến (theo giờ thực tế) -> đã đến; còn lại -> chưa đến
            if ($arrivedCount >= $totalRooms) {
                $arrived[] = $bookingData;
            } else {
                $notArrived[] = $bookingData;
            }
        }

        return response()->json([
            'not_arrived'       => $notArrived,
            'arrived'           => $arrived,
            'not_arrived_count' => count($notArrived),
            'arrived_count'     => count($arrived),
        ]);
    }

    public function departures()
    {
        $now   = Carbon::now('Asia/Ho_Chi_Minh');
        $today = $now->toDateString();

        // Lấy tất cả bookings có booking_rooms có check_out hôm nay
        $bookings = \App\Models\Bookings::with(['bookingRooms' => function ($query) use ($today) {
                $query->with('room')->whereDate('check_out', $today);
            }, 'company', 'status'])
            ->whereHas('bookingRooms', function ($query) use ($today) {
                $query->whereDate('check_out', $today);
            })
            ->get();

        $notDeparted = [];
        $departed    = [];

        foreach ($bookings as $booking) {
            $rooms      = $booking->bookingRooms;
            $totalRooms = $rooms->count();

            // Đếm số phòng đã thực sự đi (đã qua departure_time)
            $departedCount = $rooms->filter(function ($r) use ($now) {
                $departureTime = $r->departure_time ?? '12:00:00';
                $departureDt   = Carbon::parse($r->check_out . ' ' . $departureTime, 'Asia/Ho_Chi_Minh');
                return $now->gte($departureDt);
            })->count();

            $statusName = $booking->status ? $booking->status->status_name : 'Unknown';

            $bookingData = [
                'booking_code'      => $booking->booking_code,
                'reference_code'    => $booking->reference_code ?? '',
                'guest_name'        => $booking->guest_name ?? '',
                'company_name'      => $booking->company ? $booking->company->name : '',
                'status'            => $statusName,
                'total_rooms'       => $totalRooms,
                'departed_rooms'    => $departedCount,
                'notes'             => $booking->notes ?? '',
                'booking_color'     => $booking->booking_color ?? '#3b82f6',
                'rooms'             => $rooms->map(function ($r) use ($now) {
                    $departureTime = $r->departure_time ?? '12:00:00';
                    $departureDt   = Carbon::parse($r->check_out . ' ' . $departureTime, 'Asia/Ho_Chi_Minh');
                    return [
                        'room_code'      => $r->room_code,
                        'room_status'    => $r->room_status,
                        'clean_status'   => $r->room ? $r->room->clean_status : null,
                        'check_in'       => $r->check_in,
                        'check_out'      => $r->check_out,
                        'departure_time' => $r->departure_time,
                        'has_departed'   => $now->gte($departureDt),
                    ];
                })->values(),
            ];

            // Nếu tất cả phòng đã đi -> departed; còn lại -> chưa đi hết (sắp đi)
            if ($departedCount >= $totalRooms) {
                $departed[] = $bookingData;
            } else {
                $notDeparted[] = $bookingData;
            }
        }

        return response()->json([
            'not_departed'       => $notDeparted,
            'departed'           => $departed,
            'not_departed_count' => count($notDeparted),
            'departed_count'     => count($departed),
        ]);
    }

    public function occupied()
    {
        $now   = Carbon::now('Asia/Ho_Chi_Minh');
        $today = $now->toDateString();

        // Lấy bookings đang ở: check_in <= hôm nay và check_out > hôm nay
        // (bao gồm carry-over và đã vào ở hôm nay >30' sau arrival)
        $bookings = \App\Models\Bookings::with(['bookingRooms' => function ($query) use ($today) {
                $query->with('room')
                      ->whereDate('check_in', '<=', $today)
                      ->whereDate('check_out', '>=', $today);
            }, 'company', 'status'])
            ->whereHas('bookingRooms', function ($query) use ($today) {
                $query->whereDate('check_in', '<=', $today)
                      ->whereDate('check_out', '>=', $today);
            })
            ->get();

        $occupiedList = [];

        foreach ($bookings as $booking) {
            $rooms = $booking->bookingRooms;

            // Lọc các phòng đang thực sự ở (đã qua 30' sau arrival, chưa đến departure)
            $occupiedRooms = $rooms->filter(function ($r) use ($now, $today) {
                $arrivalTime   = $r->arrival_time   ?? '14:00:00';
                $departureTime = $r->departure_time ?? '12:00:00';
                $arrivalDt     = Carbon::parse($r->check_in  . ' ' . $arrivalTime,   'Asia/Ho_Chi_Minh');
                $departureDt   = Carbon::parse($r->check_out . ' ' . $departureTime, 'Asia/Ho_Chi_Minh');
                $arrivedAt30   = $arrivalDt->copy()->addMinutes(30);

                // Carry-over: check_in trước hôm nay, chưa đến departure
                $isCarryOver   = ($r->check_in < $today) && $now->lt($departureDt);
                // Đang ở hôm nay: đã qua 30' kể từ arrival
                $isOccupied    = $now->gte($arrivedAt30) && $now->lt($departureDt);

                return $isCarryOver || $isOccupied;
            });

            if ($occupiedRooms->isEmpty()) {
                continue;
            }

            $statusName = $booking->status ? $booking->status->status_name : 'Unknown';

            $occupiedList[] = [
                'booking_code'   => $booking->booking_code,
                'reference_code' => $booking->reference_code ?? '',
                'guest_name'     => $booking->guest_name ?? '',
                'company_name'   => $booking->company ? $booking->company->name : '',
                'status'         => $statusName,
                'total_rooms'    => $occupiedRooms->count(),
                'notes'          => $booking->notes ?? '',
                'booking_color'  => $booking->booking_color ?? '#3b82f6',
                'rooms'          => $occupiedRooms->map(function ($r) {
                    return [
                        'room_code'    => $r->room_code,
                        'room_status'  => $r->room_status,
                        'clean_status' => $r->room ? $r->room->clean_status : null,
                        'check_in'     => $r->check_in,
                        'check_out'    => $r->check_out,
                    ];
                })->values(),
            ];
        }

        return response()->json([
            'occupied'       => $occupiedList,
            'occupied_count' => count($occupiedList),
        ]);
    }

    public function stats()
    {
        $now   = Carbon::now('Asia/Ho_Chi_Minh');
        $today = $now->toDateString();
        $nowStr = $now->format('Y-m-d H:i:s');

        // ============================================================
        // PHÒNG ĐẾN (ARRIVALS) - chỉ tính check_in hôm nay
        // arrival_datetime = TIMESTAMP(check_in, COALESCE(arrival_time, '14:00:00'))
        // ============================================================

        // Dự kiến: đã booking hôm nay nhưng giờ arrival chưa tới
        $arrivalForecast = DB::table('booking_rooms')
            ->whereDate('check_in', $today)
            ->whereRaw("TIMESTAMP(check_in, COALESCE(arrival_time, '14:00:00')) > ?", [$nowStr])
            ->count();

        // Thực tế: đã qua giờ arrival (xem là đã đến)
        $arrivalActual = DB::table('booking_rooms')
            ->whereDate('check_in', $today)
            ->whereRaw("TIMESTAMP(check_in, COALESCE(arrival_time, '14:00:00')) <= ?", [$nowStr])
            ->count();

        // ============================================================
        // PHÒNG Ở (OCCUPIED)
        // Dự kiến: đã đến nhưng chưa quá 30' (trạng thái "vừa đến")
        // Thực tế: đã qua 30' sau arrival (đang ở thực sự)
        //          + phòng từ ngày trước chưa check-out
        // ============================================================

        // Phòng vừa đến hôm nay (0 - 30' sau arrival_time)
        $occupiedForecast = DB::table('booking_rooms')
            ->whereDate('check_in', $today)
            ->whereDate('check_out', '>', $today)
            ->whereRaw("TIMESTAMP(check_in, COALESCE(arrival_time, '14:00:00')) <= ?", [$nowStr])
            ->whereRaw("TIMESTAMP(check_in, COALESCE(arrival_time, '14:00:00')) + INTERVAL 30 MINUTE > ?", [$nowStr])
            ->count();

        // Phòng đang ở thực sự hôm nay (>30' sau arrival)
        $occupiedActualToday = DB::table('booking_rooms')
            ->whereDate('check_in', $today)
            ->whereDate('check_out', '>', $today)
            ->whereRaw("TIMESTAMP(check_in, COALESCE(arrival_time, '14:00:00')) + INTERVAL 30 MINUTE <= ?", [$nowStr])
            ->count();

        // Phòng từ hôm qua trở về (carry-over), chưa đến giờ checkout
        $occupiedCarryOver = DB::table('booking_rooms')
            ->whereDate('check_in', '<', $today)
            ->whereDate('check_out', '>', $today)
            ->whereRaw("TIMESTAMP(check_out, COALESCE(departure_time, '12:00:00')) > ?", [$nowStr])
            ->count();

        // Carry-over checkout hôm nay nhưng chưa đến giờ checkout
        $occupiedCarryToday = DB::table('booking_rooms')
            ->whereDate('check_in', '<', $today)
            ->whereDate('check_out', $today)
            ->whereRaw("TIMESTAMP(check_out, COALESCE(departure_time, '12:00:00')) > ?", [$nowStr])
            ->count();

        $occupiedActual = $occupiedActualToday + $occupiedCarryOver + $occupiedCarryToday;
        $occupiedTotal  = $occupiedForecast + $occupiedActual;

        // ============================================================
        // PHÒNG ĐI (DEPARTURES) - chỉ tính check_out hôm nay
        // departure_datetime = TIMESTAMP(check_out, COALESCE(departure_time, '12:00:00'))
        // Dự kiến: trong 30' trước departure_time (đang sắp đi)
        // Thực tế: đã qua departure_time (đã đi)
        // ============================================================

        // Dự kiến: toàn bộ phòng check out hôm nay nhưng chưa đi
        $departureForecast = DB::table('booking_rooms')
            ->whereDate('check_out', $today)
            ->whereRaw("TIMESTAMP(check_out, COALESCE(departure_time, '12:00:00')) > ?", [$nowStr])
            ->count();

        // Thực tế: đã qua departure_time
        $departureActual = DB::table('booking_rooms')
            ->whereDate('check_out', $today)
            ->whereRaw("TIMESTAMP(check_out, COALESCE(departure_time, '12:00:00')) <= ?", [$nowStr])
            ->count();

        // ============================================================
        // THỐNG KÊ TRẠNG THÁI PHÒNG (status section)
        // ============================================================
        $totalRooms      = DB::table('rooms')->count();
        $readyRooms      = DB::table('rooms')->where('clean_status', 'Clean')->count();
        $dirtyRooms      = DB::table('rooms')->where('clean_status', 'Dirty')->count();
        $inspectedRooms  = DB::table('rooms')->where('clean_status', 'Inspected')->count();
        $internalRooms   = DB::table('rooms')->where('is_internal', true)->count();
        $ownerRooms      = DB::table('rooms')->where('is_owner_room', true)->count();
        $dndRooms        = DB::table('rooms')->where('is_dnd', true)->count();
        $makeupRooms     = DB::table('rooms')->where('is_makeup_room', true)->count();

        $complimentaryRooms = DB::table('booking_rooms')
            ->join('bookings', 'booking_rooms.booking_code', '=', 'bookings.booking_code')
            ->where('bookings.payment_method_code', 'CL')
            ->count();

        $lateCheckIns = DB::table('booking_rooms')
            ->whereDate('check_in', $today)
            ->whereNotNull('arrival_time')
            ->where('arrival_time', '>', '14:00:00')
            ->count();

        $extraBeds = DB::table('booking_rooms')
            ->where('extra_bed', true)
            ->whereDate('check_in', '<=', $today)
            ->whereDate('check_out', '>=', $today)
            ->count();

        $oosCount    = 0;
        $oooCount    = 0;
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

        // Số phòng đang bị chiếm dụng = tổng phòng đang ở thực sự
        $occupiedRoomsTotal = $occupiedActual;
        $vacantRooms        = max(0, $totalRooms - $occupiedRoomsTotal);
        $occupiedPercent    = $totalRooms > 0 ? round(($occupiedRoomsTotal / $totalRooms) * 100, 0) : 0;

        return response()->json([
            'overview' => [
                'arrivalForecast'   => $arrivalForecast,
                'arrivalActual'     => $arrivalActual,
                'departureForecast' => $departureForecast,
                'departureActual'   => $departureActual,
                'occupiedActual'    => $occupiedForecast,   // Dự kiến phòng ở = phòng vừa đến (0-30')
                'occupiedEndOfDay'  => $occupiedActual,     // Thực tế phòng ở = đang ở (>30' hoặc carry-over)
                'occupiedTotal'     => $occupiedTotal,
                'total'             => $totalRooms,
            ],
            'status' => [
                'ready'          => $readyRooms,
                'clean'          => $readyRooms,
                'dirty'          => $dirtyRooms,
                'occupied'       => $occupiedRoomsTotal,
                'vacant'         => $vacantRooms,
                'locked'         => $lockedRooms,
                'inspection'     => $inspectedRooms,
                'lateCheckIn'    => $lateCheckIns,
                'complimentary'  => $complimentaryRooms,
                'extraBeds'      => $extraBeds,
                'internal'       => $internalRooms,
                'owner'          => $ownerRooms,
                'dnd'            => $dndRooms,
                'oos'            => $oosCount,
                'ooo'            => $oooCount,
                'occupiedPercent'=> $occupiedPercent,
            ],
        ]);
    }
}
