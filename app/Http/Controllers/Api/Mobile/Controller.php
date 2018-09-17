<?php
/**
 * Created by PhpStorm.
 * User: grayVTouch
 * Date: 2018/9/7
 * Time: 8:22
 */

namespace App\Http\Controllers\Api\Mobile;

use App\Http\Controllers\Api\Controller as BaseController;
use Illuminate\Http\Request;
use App\Model\Token;

class Controller extends BaseController
{
    function __construct(Request $q){
        parent::__construct();
        // 当前登陆用户
        $this->user = $this->user($q);
        // 共享
        $this->request = $q;
    }

    // 获取登陆用户
    public function user(Request $q){
        // 获取用户信息
        $token = $q->header('token');
        return Token::user($token);
    }
}