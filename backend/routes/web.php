<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/upload-debug', function () {
    return response()->json([
        'php_ini' => php_ini_loaded_file(),
        'upload_max_filesize' => ini_get('upload_max_filesize'),
        'post_max_size' => ini_get('post_max_size'),
        'memory_limit' => ini_get('memory_limit'),
        'max_file_uploads' => ini_get('max_file_uploads'),
        'max_execution_time' => ini_get('max_execution_time'),
        'content_length' => request()->server('CONTENT_LENGTH'),
    ]);
});