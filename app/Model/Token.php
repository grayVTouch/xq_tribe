<?php
/**
 * Created by PhpStorm.
 * User: grayVTouch
 * Date: 2018/9/2
 * Time: 17:08
 */

namespace App\Model;

use Illuminate\Database\Eloquent\Model;

class Token extends Model
{
    protected $table = 'token';
    public $timestamps = false;
    protected $fillable = ['user_type' , 'user_id' , 'token' , 'expire'];

    // 获取用户
    public static function user($token = null){
        if (empty($token)) {
            return null;
        }
        $_token = self::where([
            ['user_type' , '=' , 'user'] ,
            ['token' , '=' , $token]
        ])->first();

        if (empty($_token)) {
            return null;
        }

        $user = User::where('id' , $_token->user_id)->first();
        User::single($user);
        return $user;
    }
}