<?php
/**
 * Created by PhpStorm.
 * User: grayVTouch
 * Date: 2018/8/28
 * Time: 18:39
 */

namespace App\Model;

use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    protected $table = 'category';
    public $timestamps = false;

    // 获取上级分类名称
    public static function getParentName($pid = 0){
        if ($pid == 0) {
            return '顶级分类';
        }
        return self::where('id' , $pid)->value('name');
    }

    public static function single($obj){
        $obj->disabled_explain = get_correct_value($obj->disabled , 'business.bool');
        $obj->system_explain = get_correct_value($obj->system , 'business.bool');
        $obj->parent = self::getParentName($obj->pid);


    }

    public static function multiple($obj){
        foreach ($obj as $v)
        {
            self::single($v);
        }
    }
}