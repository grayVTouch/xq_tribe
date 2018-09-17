<?php
/**
 * Created by PhpStorm.
 * User: grayVTouch
 * Date: 2018/8/14
 * Time: 16:36
 */

namespace App\Extra\System;


class Page
{
    // 分页处理
    public static function deal(int $page = 1 , int $count = 1 , int $limit = 10){
        $min_page = 1;
        $max_page = ceil($count / $limit);
        $max_page = max($min_page , $max_page);
        $page   = max($min_page , min($max_page , $page));
        $offset = ($page - 1) * $limit;
        return compact('page' , 'max_page' , 'count' , 'offset' , 'limit');
    }
}