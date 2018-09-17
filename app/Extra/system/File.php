<?php
/**
 * Created by PhpStorm.
 * User: grayVTouch
 * Date: 2018/8/14
 * Time: 20:53
 */

namespace App\Extra\System;

use Core\Lib\File as _File;

class File
{
    // 删除磁盘文件
    public static function del($file = ''){
        $file = gen_path($file);

        if (_File::isFile($file)) {
            // 删除文件
            _File::dFile($file);
        }

        // 返回被删除文件路径
        return $file;
    }

    // 删除多个
    public static function delAll(array $files = []){
        $res = [];
        foreach ($files as $v)
        {
            $res[] = self::del($v);
        }
        return $res;
    }
}