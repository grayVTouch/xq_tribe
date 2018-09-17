<?php
/**
 * Created by PhpStorm.
 * User: grayVTouch
 * Date: 2018/8/4
 * Time: 23:09
 */

namespace App\Http\Middleware;

use Closure;
use App\Model\Token;
use App\Model\AdminUsers;

class AdminUserAuth
{
    public function handle($request , Closure $next)
    {
        // 仅排除用户未登录之前需要使用的 api
        $exclude = [
            'api/Admin/AdminUser/login' ,
            'api/Code/captcha' ,
            'api/Admin/AdminUser/addAdmin'
        ];

        $path = $request->path();

        if (in_array($path, $exclude)) {
            return $next($request);
        }

        $res = $this->authenticate($request);

        if (!$res['status']) {
            return error($res['msg'])->withHeaders(pub_config('cors.headers'));
        }

        return $next($request);
    }

    public function response(bool $status , $msg = ''){
        return [
            'status' => $status ,
            'msg' => $msg
        ];
    }

    // 用户登录状态认证
    public function authenticate($q){
        $token = $q->header('token');

        if (empty($token)) {
            return $this->response(false , 'Auth Failed');
        }

        // 检查 token 是否存在
        $_token = Token::where([
            ['user_type' , '=' , 'admin'] ,
            ['token' , '=' , $token]
        ])->first();

        if (!$_token) {
            return $this->response(false , 'Auth Failed');
        }

        if ($_token->expire < date('Y-m-d H:i:s')) {
            return $this->response( false , 'Auth Time Out');
        }

        // 设置用户数据
        $q->user = AdminUsers::where('id' , $_token->user_id)->first();
        AdminUsers::single($q->user);

        return $this->response(true);
    }
}