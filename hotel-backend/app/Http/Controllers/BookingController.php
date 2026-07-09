<?php

namespace App\Http\Controllers;

use App\Models\Bookings;
use Illuminate\Http\Request;

class BookingController extends Controller
{
    public function show($booking_code)
    {
        $booking = Bookings::with([
            'company',
            'status',
            'bookingRooms' => function ($query) {
                // Ensure we get roomType, roomForm and room (for room_number)
                $query->with(['roomType', 'roomForm', 'room']);
            }
        ])->where('booking_code', $booking_code)->first();

        if (!$booking) {
            return response()->json([
                'success' => false,
                'message' => 'Booking not found'
            ], 404);
        }

        return response()->json([
            'success' => true,
            'data' => $booking
        ]);
    }
}
