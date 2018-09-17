<?php
/**
 * Created by PhpStorm.
 * User: grayVTouch
 * Date: 2018/8/23
 * Time: 11:23
 */

namespace App\Http\Controllers\Api\Admin;

use Validator;
use DB;
use Illuminate\Http\Request;
use App\Model\AdminUser as _AdminUser;
use App\Model\AdminLandLog;
use App\Model\Token;

class AdminUser extends Controller
{
    /**
     * 后台用户登录
     */
    public function login(Request $q){
        $inputs = $q->post();
        $validator = Validator::make($inputs , [
            'username'      => 'bail|required' ,
            'password'  => 'bail|required|min:6' ,
            'code'      => 'bail|required' ,
            'remember'  => 'bail|required'
        ] , [
            'username.required' => trans('user.username.required') ,
            'password.required' => trans('user.password.required') ,
            'password.min' => trans('user.password.format') ,
            'code.required' => trans('validation.code.required') ,
            'remember.required' => trans('user.remember.required'),
        ]);

        if ($validator->fails()) {
            return form_error($validator);
        }

        // 检查验证码
        if (!captcha_api_check($inputs['code'] , $inputs['code_key'])) {
            $validator->errors()->add('code' , trans('validation.code.error'));
            return form_error($validator);
        }

        // 检查用户名密码是否正确
        $user = _AdminUser::where('username' , $inputs['username'])->first();

        if (!$user || !\Hash::check($inputs['password'] , $user->password)) {
            $validator->errors()->add('system' , trans('user.system.auth_error'));
            return form_error($validator);
        }

        $inputs['remember'] = in_array($inputs['remember'] , ['y' , 'n']) ? $inputs['remember'] : 'n';
        $duration = $inputs['remember'] == 'y' ? pub_config('time.long_time') : pub_config('time.short_time');
        $res = [];

        DB::transaction(function() use($inputs , $duration , $user , &$res){
            $last_ip    = $this->request->server('REMOTE_ADDR');
            $last_time  = date('Y-m-d H:i:s' , time());
            $log = [
                'user_id' => $user->id ,
                'ip' => $last_ip ,
                'create_time' => $last_time
            ];

            // 记录登陆日志
            AdminLandLog::insert($log);
            // 更新用户表
            _AdminUser::where('id' , $user->id)->update([
                'last_ip' => $last_ip ,
                'last_time' => $last_time ,
            ]);
            // 传递 token 给用户
            $data = [
                'user_type' => 'admin' ,
                'user_id' => $user->id ,
                'token' => ssl_random() ,
                'expire' => date('Y-m-d H:i:s' , time() + $duration) ,
            ];
            Token::create($data);
            $res = [
                'token' => $data['token'] ,
                'token_expire' => $data['expire']
            ];
        });

        // 否则为验证成功
        return success($res);
    }

    // 管理员列表
    public function admins(){

    }

    // 注销
    public function loginOut(Request $q){
        $token = $q->header('token');
        Token::where('token', $token)->delete();
        return success(trans('user.loginOut'));
    }

    // 添加管理员用户
    public function addAdmin(){
        // 后台用户
        _AdminUser::insert([
            'username' => 'yueshu' ,
            'password' => bcrypt('364793')
        ]);
    }
}