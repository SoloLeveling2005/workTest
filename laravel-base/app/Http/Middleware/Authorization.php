<?php

namespace App\Http\Middleware;

use App\Models\User;
use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Symfony\Component\HttpFoundation\Response;

class Authorization
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        $user = User::where('api_token', $request->header()['authorization'][0])->first();
        dd($request->header(), $request->user());
        if (Auth::guard('web')->check()) {
            return $next($request);
        }
        return response()->json(["message"=>"Пользователь не авторизован"], 401);
    }
}
