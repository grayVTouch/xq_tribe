<?php
/**
 * Created by PhpStorm.
 * User: grayVTouch
 * Date: 2018/7/1
 * Time: 17:48
 *
 * api 认证
 */

namespace App\Http\Middleware;

use Closure;

class ApiAuth
{
    public function handle($request , Closure $next){
        $res = $this->authenticate($request);
        if (!$res['status']) {
            return error($res['msg'])->withHeaders(pub_config('cors.headers'));
        }

        return $next($request);
    }

    public function response($status , $msg = ''){
        return [
            'status' => $status ,
            'msg' => $msg
        ];
    }

    public function authenticate($request){
        $token = $request->header('authorization');

        if (empty($token)) {
            return $this->response(false , 'Authorization Failed');
        }

        // 检查是否是 refresh_token
        $res = (bool) \DB::table('auth_token')->where('refresh_token' , $token)->count();

        if ($res) {
            return $this->response(true);
        }

        // 检查是否有 token 记录
        $res = \DB::table('auth_token')->where('access_token' , $token)->first();

        if (!$res) {
            return $this->response(false , 'Authorization Failed');
        }

        // 检查是否是系统平台
        if ($res->permanent == 'y') {
            return $this->response(true);
        }

        // 检查是否过期
        if ($res->access_token_expire < date('Y-m-d H:i:s')) {
            return $this->response(false , 'Access Token Expired');
        }

        return $this->response(true);
    }
}