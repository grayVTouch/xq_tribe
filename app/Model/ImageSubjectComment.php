<?php
/**
 * Created by PhpStorm.
 * User: grayVTouch
 * Date: 2018/9/11
 * Time: 22:43
 */

namespace App\Model;

use Illuminate\Database\Eloquent\Model;
use StdClass;

class ImageSubjectComment extends Model
{
    protected $table = 'image_subject_comment';
    public $timestamps = false;
//    protected $fillable = ['content' , 'user_id' , 'reply_user_id'];
    protected $guarded = ['id' , 'hot'];

    public static function multiple($obj){
        foreach ($obj as $v)
        {
            self::single($v);
        }
    }

    public static function single($obj){
        // 仅展示最多 3 条数据
        $obj->user = User::find($obj->user_id);
        User::single($obj->user);
        $reply = self::reply($obj->id);
        $obj->reply_count = count($reply);
        $obj->simple_reply = array_slice($reply , 0 , 3);
        if (empty($obj->pid)) {
            $obj->reply = null;
        } else {
            $obj->reply =self::find($obj->pid);
            $obj->reply->user = User::find($obj->reply->user_id);
            self::single($obj->reply);
        }
    }

    // 获取当前评论的回复
    public static function reply($id){
        $res = [];
        $all = function($id) use(&$all , &$res){
            $data = self::where('pid' , $id)->get();
            foreach ($data as $v)
            {
                $v->user = User::find($v->user_id);
                $v->reply = self::find($v->pid);
                $v->reply->user = User::find($v->reply->user_id);
                User::single($v->user);
                User::single($v->reply->user);
                $res[] = $v;
                $all($v->id);
            }
        };
        $all($id);
        self::sort($res , 'id' , 'desc');
        return $res;
    }

    // 选择排序
    public static function sort(&$data , $field = 'id' , $type = 'desc'){
        $range = ['asc' , 'desc'];
        $type = in_array($type , $range) ? $type : 'desc';
        $count = count($data);
        for ($i = 0; $i < $count; ++$i)
        {
            $index = $i;
            for ($n = $i + 1; $n < $count; ++$n)
            {
                $one = $data[$index];
                $two = $data[$n];
                if ($type === 'asc') {
                    // 升序
                    if ($one[$field] > $two[$field]) {
                        $index = $n;
                    }
                } else {
                    // 降序
                    if ($one[$field] < $two[$field]) {
                        $index = $n;
                    }
                }
            }
            if ($index !== $i) {
                $tmp = $data[$i];
                $data[$i] = $data[$index];
                $data[$index] = $tmp;
            }
        }
    }
}