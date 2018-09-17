<?php
/**
 * Created by PhpStorm.
 * User: grayVTouch
 * Date: 2018/8/5
 * Time: 11:42
 */

namespace App\Model;

use Illuminate\Database\Eloquent\Model;

class User extends Model
{
    protected $table = 'user';
    public $timestamps = false;

    public function token(){
        return $this->hasMany(Token::class);
    }

    // 数据处理：多条
    public static function multiple($obj){
        foreach ($obj as $v)
        {
            self::single($v);
        }
    }

    // 获取数据
    public static function single($obj){
        $obj->sex_explain = get_correct_value($obj->sex , 'business.sex');
        $obj->avatar_url = empty($obj->avatar) ? mobile_config('res.avatar') : gen_url($obj->avatar);
    }

    // 检查用户名是否重复
    public static function isRepeat($username){
        return (bool) self::where('username' , $username)->count();
    }
}