<?php
/**
 * Created by PhpStorm.
 * User: grayVTouch
 * Date: 2018/6/30
 * Time: 0:45
 */

namespace App\Http\Controllers\Api\Admin;

use App\Model\User as _User;
use App\Extra\System\Admin\Page;
use App\Extra\System\File;
use Validator;
use Illuminate\Http\Request;

class User extends Controller
{


    // 用户信息
    public function info(){

    }

    // 用户列表
    public function list(Request $q){
        $inputs = $q->post();
        $where = [];

        if (!empty($inputs['id'])) {
            $where[] = ['id' , '=' , $inputs['id']];
        }

        if (!empty($inputs['username'])) {
            $where[] = ['username' , 'like' , "%{$inputs['username']}%"];
        }

        if (!empty($inputs['sex'])) {
            $where[] = ['sex' , '=' , $inputs['sex']];
        }

        $count  = _User::where($where)->count();
        $page   = Page::deal($inputs['page'] , $count , $inputs['limit']);
        $sort   = empty($inputs['sort']) ? ['id' , 'desc'] : explode('|' , $inputs['sort']);

        $data = _User::where($where)
            ->offset($page['offset'])
            ->limit($page['limit'])
            ->orderBy($sort[0] , $sort[1])
            ->get();
        // 数据处理
        _User::multiple($data);

        $res = [
            'page'  => $page ,
            'users' => $data
        ];
        return success($res);

    }

    // 添加普通用户
    public function add(Request $q){
        $inputs = $q->post();

        $validator = Validator::make($inputs , [
            'username'  => 'required' ,
            'password'  => 'required' ,
            'sex'       => 'required'
        ] , [
            'username.requried' => trans('user.username.required') ,
            'password.requried' => trans('user.password.required') ,
            'sex.requried'      => trans('user.sex.required') ,
        ]);

        if ($validator->fails()) {
            return form_error($validator);
        }

        // 检查用户名长度
        if (!check_len($inputs['username'] , 6 , 'gte')) {
            $validator->errors()->add('username' , trans('user.username.size'));
            return form_error($validator);
        }

        // 检查密码
        if (!preg_match('/^[A-z]\w{5,}$/' , $inputs['password'])) {
            $validator->errors()->add('password' , trans('user.password.format'));
            return form_error($validator);
        }

        // 检查用户名是否已经存在
        $exists = _User::isRepeat($inputs['username']);

        if ($exists) {
            $validator->errors()->add('username' , trans('user.username.repeat'));
            return form_error($validator);
        }

        $inputs['password'] = bcrypt($inputs['password']);
        unset($inputs['id']);
        $id = _User::insertGetId($inputs);
        return success($id);
    }

    // 编辑用户
    public function edit(Request $q){
        $inputs = $q->post();

        // 验证 id 是否存在
        if (!$q->filled('id')) {
            return error(trans('user.id.required'));
        }

        $validator = Validator::make($inputs , [
            'username'  => 'required' ,
            'sex'       => 'required'
        ] , [
            'username.required' => trans('user.username.required') ,
            'sex.required'      => trans('user.sex.required')
        ]);

        if ($validator->fails()) {
            return form_error($validator);
        }

        // 检查用户名长度
        if (!check_len($inputs['username'] , 6 , 'gte')) {
            $validator->errors()->add('username' , trans('user.username.size'));
            return form_error($validator);
        }

        // 检查用户名是否重复
        $exists = (bool) _User::where([
            ['id' , '!=' , $inputs['id']] ,
            ['username' , '=' , $inputs['username']] ,
        ])->count();

        if ($exists) {
            $validator->errors()->add('username' , trans('user.username.repeat'));
            return error($validator);
        }

        // 检查密码是否为空
        if (empty($inputs['password'])) {
            unset($inputs['password']);
        } else {
            if (!check_len($inputs['password'] , 6 , 'gte')) {
                $validator->errors()->add('password' , trans('user.password.format'));
                return form_error($validator);
            }

            $inputs['password'] = bcrypt($inputs['password']);
        }

        _User::where('id' , $inputs['id'])->update($inputs);

        return success($inputs['id']);
    }

    // 更新用户头像
    public function updateAvatar(Request $q){
        $inputs = $q->post();

        _User::where('id' , $inputs['id'])->update([
            'avatar' => $inputs['avatar']
        ]);

        return success(trans('validation.update.success'));
    }

    // 获取用户数据
    public function cur(Request $q){
        $inputs = $q->post();

        if (empty($inputs['id'])) {
            return error(trans('user.id.required'));
        }

        $data = _User::find($inputs['id']);
        _User::single($data);

        return success($data);
    }

    // 删除用户
    public function del(Request $q){
        $inputs = $q->post();
        $inputs['id_list'] = empty($inputs['id_list']) ? [] : json_decode($inputs['id_list'] , true);

        if (empty($inputs['id_list'])) {
            return error(trans('user.id.required'));
        }

        \DB::transaction(function() use($inputs){
            $data = _User::whereIn('id' , $inputs['id_list'])->get();
            // 删除数据库记录
            _User::whereIn('id' , $inputs['id_list'])->delete();
            // 删除图片
            foreach ($data as $v)
            {
                File::del($v->avatar_path);
            }
        });

        return success(trans('user.del.success'));
    }
}