<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\Api\Auth\AuthController;
use App\Http\Controllers\Api\Auth\ProfileController;
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
Route::middleware(['auth:sanctum'])->group(function () {
    // Common Routes
    Route::post('/logout', [AuthController::class, 'logout']);

    // public complaint
    Route::prefix('complaints')->group(function () {

        // READ: higher rate
        Route::middleware('throttle:12000,1')->group(function () {
            Route::get('/', [ComplainController::class, 'index']);
            Route::get('/view', [ComplainController::class, 'myComplain']);
            Route::get('/stats', [ComplainController::class, 'stats']);
            Route::get('/{id}', [ComplainController::class, 'show'])->whereNumber('id');
            Route::get('/get-comment/{id}', [ComplainController::class, 'showComment'])->whereNumber('id');
        });

        // WRITE: lower rate
        Route::middleware('throttle:2000,1')->group(function () {
            Route::delete('/delete/{id}', [ComplainController::class, 'delete'])->whereNumber('id');
            Route::post('/like/{id}', [ComplainController::class, 'getLike'])->whereNumber('id');
            Route::post('/dis-like/{id}', [ComplainController::class, 'getDislike'])->whereNumber('id');
            Route::post('/comment', [ComplainController::class, 'storeComment']);
            Route::delete('/delete-comment/{id}', [ComplainController::class, 'deleteComment'])->whereNumber('id');
        });
    });

    Route::get('/user', fn(Request $r) => $r->user()); // already available often
    Route::put('/profile', [ProfileController::class, 'update']);
    Route::put('/profile/password', [ProfileController::class, 'changePassword']);

    Route::prefix('create')->group(function () {

        Route::middleware('throttle:12000,1')->group(function () {
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
});