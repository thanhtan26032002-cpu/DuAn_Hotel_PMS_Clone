<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\RoomController;

use App\Http\Controllers\BookingController;

Route::get('/rooms', [RoomController::class, 'index']);
Route::get('/room-stats', [RoomController::class, 'stats']);
Route::get('/arrivals', [RoomController::class, 'arrivals']);
Route::get('/departures', [RoomController::class, 'departures']);
Route::get('/occupied', [RoomController::class, 'occupied']);
Route::get('/bookings/{code}', [BookingController::class, 'show']);
