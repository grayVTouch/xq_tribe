<?php
/**
 * Created by PhpStorm.
 * User: grayVTouch
 * Date: 2018/8/6
 * Time: 10:12
 */

namespace App\Http\Controllers;

use Core\Lib\Category;

class Test extends Controller
{
    public function index(){
        $data = [
            [
                'id' => 1 ,
                'name' => 'hobby' ,
                'pid' => 0
            ] ,
            [
                'id' => 2 ,
                'name' => 'play' ,
                'pid' => 1
            ] ,
            [
                'id' => 3 ,
                'name' => 'compute' ,
                'pid' => 2
            ] ,
            [
                'id' => 4 ,
                'name' => 'game' ,
                'pid' => 2
            ] ,
            [
                'id' => 5 ,
                'name' => 'love' ,
                'pid' => 0
            ] ,
            [
                'id' => 6 ,
                'name' => 'sexy' ,
                'pid' => 5
            ] ,
            [
                'id' => 7 ,
                'name' => 'with beautiful face' ,
                'pid' => 6
            ] ,
            [
                'id' => 8 ,
                'name' => 'with milk' ,
                'pid' => 6
            ]
        ];

        $id = 8;
        $res = Category::current($id , $data);
        print_r($res);
        $parents = Category::parents($id , $data , null , true , true);
        print_r($parents);
        $children = Category::children(6 , $data , null);
        print_r($children);
        // 所有后代
        $childs = Category::childrens(5 , $data , null , true , true);
        print_r($childs);
    }
}