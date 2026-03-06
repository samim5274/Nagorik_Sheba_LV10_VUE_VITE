<?php

namespace App\Exceptions;

use Illuminate\Foundation\Exceptions\Handler as ExceptionHandler;
use Throwable;
use Symfony\Component\HttpKernel\Exception\TooManyRequestsHttpException;

class Handler extends ExceptionHandler
{
    /**
     * The list of the inputs that are never flashed to the session on validation exceptions.
     *
     * @var array<int, string>
     */
    protected $dontFlash = [
        'current_password',
        'password',
        'password_confirmation',
    ];

    /**
     * Register the exception handling callbacks for the application.
     */
    public function register(): void
    {
        $this->reportable(function (Throwable $e) {
            //
        });
    }

    public function render($request, Throwable $e)
    {
        // API requests -> JSON response for 429
        if (($request->is('api/*') || $request->expectsJson()) && $e instanceof TooManyRequestsHttpException) {
            return response()->json([
                'success' => false,
                'message' => 'Too many requests. Please slow down.',
            ], 429);
        }

        return parent::render($request, $e);
    }
}
