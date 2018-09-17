<?php
/**
 * Created by PhpStorm.
 * User: grayVTouch
 * Date: 2018/7/5
 * Time: 14:43
 */

// 表单输出
function form_error($validator , $location = ''){
    $errors = $validator->errors()->toArray();
    $res = [];
    foreach ($errors as $k => $v)
    {
        $res[$k] = is_array($v) ? $v[0] : $v;
    }
    return error($res , $location);
}

// 错误输出
function error($content = '' , $location = ''){
    return json('error' , $content , $location);
}

// 成功输出
function success($content = '' , $location = ''){
    return json('success' , $content , $location);
}

// json 响应
function json($status , $content , $location){
    return response()->json([
        'status' => $status ,
        'msg' => $content ,
        'location' => $location
    ]);
}

// 获取应用公共配置文件
function pub_config($key , $args = []){
    $dir        = app_path();
    $config_dir = "{$dir}/Extra/config/";

    return _config_($config_dir , $key , $args);
}

// 获取用户自定义应用配置文件
function admin_config($key , $args = []){
    $key = 'Admin.' . $key;

    return pub_config($key , $args);
}

// 获取用户自定义应用配置文件
function api_config($key , $args = []){
    $key = 'Api.' . $key;

    return pub_config($key , $args);
}

// 获取用户自定义应用配置文件
function mobile_config($key , $args = []){
    $key = 'Mobile.' . $key;

    return pub_config($key , $args);
}

// 获取语言包配置文件
function lang($key , $args = []){
    $dir        = resource_path();
    $lang       = config('app.locale');
    $lang_dir   = "{$dir}/lang/{$lang}/";

    return _config_($lang_dir , $key , $args);
}

// 获取指
function get_correct_value($value , $key , $prefix = 'public'){
    $prefix_range = ['public' , 'admin' , 'api'];
    $prefix = in_array($prefix , $prefix_range) ? $prefix : 'public';

    switch ($prefix)
    {
        case 'public':
            $range = pub_config($key);
            break;
        case 'admin':
            $range = admin_config($key);
            break;
        case 'api':
            $range = api_config($key);
            break;
        default:
            $range = pub_config($key);
    }

    foreach ($range as $k => $v)
    {
        if ($k == $value) {
            return $v;
        }
    }

    return '';
}

// 生成网络路径
function gen_url($path){
    $https = pub_config('app.https');
    return empty($path) ? '' : ($https ? secure_asset($path) : asset($path));
}

// 生成本地路径
function gen_path($path){
    return public_path('/') . $path;
}