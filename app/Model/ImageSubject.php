<?php
/**
 * Created by PhpStorm.
 * User: grayVTouch
 * Date: 2018/8/31
 * Time: 9:34
 */

namespace App\Model;

use Illuminate\Database\Eloquent\Model;
use Exception;

class ImageSubject extends Model
{
    protected $table = 'image_subject';
    public $timestamps = false;

    public static function multiple($obj){
        foreach ($obj as $v)
        {
            self::single($v);
        }
    }

    // 获取图片主体对应的用户
    public static function user($user_type , $user_id){
        switch ($user_type)
        {
            case 'admin':
                $data = AdminUser::where('id' , $user_id)->first();
                AdminUser::single($data);
                return $data;
            case 'user':
                $data = User::where('id' , $user_id)->first();
                User::single($data);
                return $data;
            default:
                throw new Exception('未知的用户类型');
        }
    }

    public static function single($obj){
        // 标签
        $obj->_tag = empty($obj->tag) ? [] : json_decode($obj->tag , true);
        // 封面
        $obj->thumb_url = empty($obj->thumb) ? mobile_config('res.thumb') : gen_url($obj->thumb);
        // 发布用户
        $obj->user = self::user($obj->user_type , $obj->user_id);
        // 评论数
        $obj->comment_count = ImageSubjectComment::where('image_subject_id' , $obj->id)->count();
        // 专题内子图片
        $obj->images = self::images($obj->id);
    }

    // 获取图片
    public static function images($id){
        $data = Image::where('image_subject_id' , $id)->get();
        Image::multiple($data);
        return $data;
    }
}