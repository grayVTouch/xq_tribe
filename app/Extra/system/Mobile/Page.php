<?php
/**
 * Created by PhpStorm.
 * User: grayVTouch
 * Date: 2018/8/14
 * Time: 16:51
 */

namespace App\Extra\System\Mobile;

use App\Extra\System\Page as _Page;

class Page
{
    // 分页处理
    public static function deal($page , $count){
        $page   = isset($page)  ? intval($page) : 1;
        $limit  = admin_config('page.limit');
        $limit  = intval($limit);
        return _Page::deal($page , $count , $limit);
    }
}