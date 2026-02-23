<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\Api\Auth\AuthController;

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
Route::middleware(['auth:sanctum', 'throttle:cart'])->group(function () {
    // Common Routes
    Route::post('/logout', [AuthController::class, 'logout']);
});