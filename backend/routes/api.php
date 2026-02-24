<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\Api\Auth\AuthController;
use App\Http\Controllers\Api\Complain\ComplainController;

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

// ======================
// Public Routes
// ======================
Route::post('/login', [AuthController::class, 'login']);
Route::post('/register', [AuthController::class, 'register']);

// ======================
// Protected Routes
// ======================
Route::middleware(['auth:sanctum', 'throttle:60, 1'])->group(function () {
    // Common Routes
    Route::post('/logout', [AuthController::class, 'logout']);

    Route::prefix('create')->group(function () {
        Route::get('/get-division', [ComplainController::class, 'getDivision']);
        Route::get('/get-district/{id}', [ComplainController::class, 'getDistrict']);
        Route::get('/get-upazila/{id}', [ComplainController::class, 'getUpazila']);
        Route::get('/get-policeStations/{id}', [ComplainController::class, 'getPoliceStations']);
    });
});