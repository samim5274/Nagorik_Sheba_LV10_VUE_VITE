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

    // public complaint
    Route::prefix('complaints')->group(function () {
        Route::get('/', [ComplainController::class, 'index']);
        Route::get('/{id}', [ComplainController::class, 'show']);
    });

    Route::prefix('create')->group(function () {
        // get location
        Route::get('/get-division', [ComplainController::class, 'getDivision']);
        Route::get('/get-district/{id}', [ComplainController::class, 'getDistrict']);
        Route::get('/get-upazila/{id}', [ComplainController::class, 'getUpazila']);
        Route::get('/get-policeStations/{id}', [ComplainController::class, 'getPoliceStations']);

        // get category and sub category
        Route::get('/get-category', [ComplainController::class, 'getCategory']);
        Route::get('/get-subcategory/{id}', [ComplainController::class, 'getSubcategory']);

        // create complaint
        Route::post('/', [ComplainController::class, 'store']);
    });
});