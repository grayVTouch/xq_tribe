<?php
/**
 * Created by PhpStorm.
 * User: grayVTouch
 * Date: 2018/8/5
 * Time: 23:23
 */

namespace App\Rules;

use Illuminate\Contracts\Validation\Rule;

class StrMin implements Rule
{
    public function passes($attr , $value , int $len = 0){
        return mb_strlen($value) > $len;
    }

    public function message(){

    }
}