<?php
/**
 * Created by PhpStorm.
 * User: grayVTouch
 * Date: 2018/8/8
 * Time: 22:27
 */

namespace App\Http\Controllers\Api;


class Code extends Controller
{
    // 验证码
    public function captcha(){
        return success(\Captcha::create('default' , true));
    }
}