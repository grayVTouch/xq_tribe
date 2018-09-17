<?php
/**
 * Created by PhpStorm.
 * User: grayVTouch
 * Date: 2018/8/23
 * Time: 14:40
 */

namespace App\Model;

use Illuminate\Database\Eloquent\Model;

class Tag extends Model
{
    protected $table = 'tag';
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
        
    }
}