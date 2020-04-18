<?php
/**
 * Created by PhpStorm.
 * User: grayVTouch
 * Date: 2018/8/4
 * Time: 21:27
 */

namespace App\Model;

use Illuminate\Database\Eloquent\Model;

class AdminUser extends Model
{
    protected $table = 'admin_user';
    public $timestamps = false;

    public static function multiple($obj){
        foreach ($obj as $v)
        {
            self::single($v);
        }
    }

    public static function single($obj){
        $obj->sex_explain = get_correct_value($obj->sex , 'business.sex');
        $obj->avatar_url = empty($obj->avatar) ? pub_config('res.avatar') : gen_url($obj->avatar);
    }
}