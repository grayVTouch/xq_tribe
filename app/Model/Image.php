<?php
/**
 * Created by PhpStorm.
 * User: grayVTouch
 * Date: 2018/8/31
 * Time: 9:34
 */

namespace App\Model;

use StdClass;
use Illuminate\Database\Eloquent\Model;

class Image extends Model
{
    protected $table = 'image';
    public $timestamps = false;

    public static function multiple($obj){
        foreach ($obj as $v)
        {
            self::single($v);
        }
    }

    public static function single($obj){
        $obj->url = gen_url($obj->path);
        $obj->info = get_image_info(gen_path($obj->path));
    }
}