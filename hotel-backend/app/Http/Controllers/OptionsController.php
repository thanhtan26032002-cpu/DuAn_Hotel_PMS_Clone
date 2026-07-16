<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class OptionsController extends Controller
{
    public function index()
    {
        $reservationStatuses = DB::table('reservation_statuses')->select('id', 'status_name as name', 'status_color as color')->get();
        $companies = DB::table('companies')->select('company_code', 'name')->get();
        $paymentMethods = DB::table('payment_methods')->select('payment_code', 'payment_name')->get();
        $employees = DB::table('employees')->select('employee_code', 'fullname')->get();
        $marketSegments = DB::table('market_segments')->select('code', 'name')->get();
        $bookingSources = DB::table('booking_sources')->select('code', 'name')->get();
        $bookers = DB::table('bookers')->select('id', 'name', 'phone', 'email', 'address', 'notes')->get();
        $roomTypes = DB::table('room_types')->select('id', 'type_name', 'type_short_name')->where('is_active', 1)->orderBy('id')->get();

        return response()->json([
            'reservation_statuses' => $reservationStatuses,
            'companies' => $companies,
            'payment_methods' => $paymentMethods,
            'employees' => $employees,
            'market_segments' => $marketSegments,
            'booking_sources' => $bookingSources,
            'bookers' => $bookers,
            'room_types' => $roomTypes,
        ]);
    }
}
