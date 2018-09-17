<?php
/**
 * Created by PhpStorm.
 * User: grayVTouch
 * Date: 2018/7/1
 * Time: 17:48
 */

namespace App\Http\Middleware;

use Closure;

class Cors
{
    public function handle($request , Closure $next){
        return $next($request)->withHeaders(pub_config('cors.headers'));
    }
}