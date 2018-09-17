<?php

namespace App\Http\Middleware;

use Closure;

class Options
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {
        // 拦截 options 请求
        if ($request->isMethod('options')) {
            return response('')->withHeaders(pub_config('cors.headers'));
        }

        return $next($request);
    }
}
