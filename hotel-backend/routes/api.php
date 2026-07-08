<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\RoomController;

Route::get('/rooms', [RoomController::class, 'index']);
Route::get('/room-stats', [RoomController::class, 'stats']);
Route::get('/arrivals', [RoomController::class, 'arrivals']);
