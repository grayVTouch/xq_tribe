<?php
/**
 * Created by PhpStorm.
 * User: grayVTouch
 * Date: 2018/8/23
 * Time: 14:40
 */

namespace App\Model;

use Illuminate\Database\Eloquent\Model;

class Subject extends Model
{
    protected $table = 'subject';
    public $timestamps = false;

    // 多条处理
    public static function multiple($obj){
        foreach ($obj as $v)
        {
            self::single($v);
        }
    }

    // 单条处理
    public static function single($obj){
        $obj->attrs = json_decode($obj->attr , true);
        $obj->thumb_url = gen_url($obj->thumb);
    }
}