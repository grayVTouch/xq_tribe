<?php
/**
 * Created by PhpStorm.
 * User: grayVTouch
 * Date: 2018/9/11
 * Time: 22:20
 */

namespace App\Http\Controllers\Api\Mobile;

use App\Model\ImageSubject;
use App\Model\ImageSubjectComment;
use App\Extra\System\Mobile\Page;

class Image extends Controller
{
    // 图片列表
    public function list(){
        $inputs = $this->request->post();
        $inputs['page'] = isset($inputs['page']) ? intval($inputs['page']) : 1;
        $inputs['type'] = isset($inputs['type']) ? $inputs['type'] : 'none';

        // 获取总数
        $count = ImageSubject::where('status' , 3)->count();
        $page = Page::deal($inputs['page'] , $count);

        $where = [
            ['status' , '=' , 3]
        ];

        if ($inputs['type'] === 'newest') {
            $where[] = ['id' , '>' , $inputs['id']];
        }

        if ($inputs['type'] === 'more') {
            $where[] = ['id' , '<' , $inputs['id']];
        }

        $data = ImageSubject::where($where)
            ->offset($page['offset'])
            ->limit($page['limit'])
            ->orderBy('create_time' , 'desc')
            ->get();
        ImageSubject::multiple($data);
        $res = [
            'page' => $page ,
            'data' => $data
        ];
        return success($res);
    }

    // 图片详情
    public function detail(){
        $id = $this->request->post('id');
        if (empty($id)) {
            return error(trans('image.id.required'));
        }
        $data = ImageSubject::find($id);
        ImageSubject::single($data);
        return success($data);
    }

    // 评论数据
    public function comments(){
        $inputs = [];
        $inputs['id']     = isset($_POST['id']) ? $_POST['id'] : null;
        $inputs['page']   = isset($_POST['page']) ? intval($_POST['page']) : 1;
        if (empty($inputs['id'])) {
            return error(trans('image.id.required'));
        }
        $total = $count = ImageSubjectComment::where('image_subject_id' , $inputs['id'])->count();
        $count = ImageSubjectComment::where('image_subject_id' , $inputs['id'])->whereNull('pid')->count();
        $page = Page::deal($inputs['page'] , $count);

        $data = ImageSubjectComment::where('image_subject_id' , $inputs['id'])
            ->whereNull('pid')
            ->offset($page['offset'])
            ->limit($page['limit'])
//            ->orderBy('hot' , 'desc')
            ->orderBy('id' , 'desc')
            ->get();
        ImageSubjectComment::multiple($data);
        $res = [
            'page' => $page ,
            'data' => [
                'count' => $total ,
                'comment' => $data
            ]
        ];
        return success($res);
    }

    // 查看全部回复
    public function reply(){
        $inputs = [];
        $inputs['id']     = isset($_POST['id']) ? $_POST['id'] : null;
        $inputs['page']   = isset($_POST['page']) ? intval($_POST['page']) : 1;
        if (empty($inputs['id'])) {
            return error(trans('imageSubjectComment.id.required'));
        }
        $comment = ImageSubjectComment::find($inputs['id']);
        $reply = ImageSubjectComment::reply($comment->id);
        $count = count($reply);
        $page = Page::deal($inputs['page'] , $count);
        $res = array_slice($reply , $page['offset'] , $page['limit']);
        $res = [
            'page' => $page ,
            'data' => $res
        ];
        return success($res);
    }

    // 发布评论
    public function addComment(){
        // 检查用户是否登陆
        if (empty($this->user)) {
            return error(trans('user.not_login'));
        }
        $inputs = [];
        $inputs['image_subject_id'] = isset($_POST['image_subject_id']) ? $_POST['image_subject_id'] : null;
        $inputs['content']          = isset($_POST['content']) ? $_POST['content'] : '';
        $inputs['pid']              = isset($_POST['pid']) && !empty($_POST['pid']) ? $_POST['pid'] : null;
        $inputs['user_id']          = $this->user->id;
        $inputs['create_time']      = date('Y-m-d H:i:s' , time());
        if (empty($inputs['image_subject_id'])) {
            return error(trans('imageSubject.id.required'));
        }
        if (empty($inputs['content'])) {
            return error(trans('imageSubjectComment.content.required'));
        }
        $comment = ImageSubjectComment::create($inputs);
        ImageSubjectComment::single($comment);
        return success($comment);
    }

}