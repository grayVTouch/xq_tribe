<?php
/**
 * Created by PhpStorm.
 * User: grayVTouch
 * Date: 2018/9/7
 * Time: 8:28
 */

namespace App\Http\Controllers\Api\Mobile;

use App\Model\User as _User;
use App\Model\Token;
use Validator;
use DB;
use Hash;

class User extends Controller
{
    // 获取登陆用户信息
    public function cur(){
        if (empty($this->user)) {
            return error(trans('user.not_login'));
        }
        return success($this->user);
    }

    // 用户登陆
    public function login(){
        $inputs = $this->request->post();
        $validator = Validator::make($inputs , [
            'username' => 'required' ,
            'password' => 'required'
        ] , [
            'username.required' => trans('user.username.required') ,
            'password.required' => trans('user.password.required') ,
        ]);
        if ($validator->fails()) {
            return form_error($validator);
        }
        $user = _User::where('username' , $inputs['username'])->first();
        if (empty($user)) {
            $validator->errors()->add('username' , trans('user.username.not_exists'));
            return form_error($validator);
        }
        if (!Hash::check($inputs['password'] , $user->password)) {
            $validator->errors()->add('password' , trans('user.password.fail'));
            return form_error($validator);
        }
        $res = [];
        // 登陆成功
        DB::transaction(function() use($user ,  &$res){
            $last_time = date('Y-m-d H:i:s');
            $last_ip = $this->request->server('REMOTE_ADDR');

            // 更新用户表
            _User::where('id' , $user->id)->update([
                'last_ip' => $last_ip ,
                'last_time' => $last_time
            ]);

            // 生成用户登陆 token
            $token = [
                'user_type' => 'user' ,
                'user_id' => $user->id ,
                'token' => ssl_random() ,
                'expire' => date('Y-m-d H:i:s' , time() + pub_config('time.long_time'))
            ];
            Token::insert($token);
            $res = [
                'token' => $token['token'] ,
                'expire' => $token['expire'] ,
            ];
        });
        return success($res);
    }
}