<?php
/**
 * Created by PhpStorm.
 * User: grayVTouch
 * Date: 2018/8/30
 * Time: 12:28
 */

namespace App\Http\Controllers\Api\Admin;

use Validator;
use App\Model\Image as _Image;
use App\Model\Tag;
use App\Model\ImageSubject;
use App\Extra\System\Admin\Page;
use App\Extra\System\File;

class Image extends Controller
{
    // 模块列表
    public function list(){
        $inputs = $this->request->post();
        $where = [];

        if ($this->request->filled('id')) {
            $where[] = ['id' , '=' , $inputs['id']];
        }

        if ($this->request->filled('name')) {
            $where[] = ['name' , 'like' , "%{$inputs['name']}%"];
        }

        $count  = ImageSubject::where($where)->count();
        $page   = Page::deal($inputs['page'] , $count , $inputs['limit']);
        $sort   = empty($inputs['sort']) ? ['id' , 'desc'] : explode('|' , $inputs['sort']);

        $data = ImageSubject::where($where)
            ->offset($page['offset'])
            ->limit($page['limit'])
            ->orderBy($sort[0] , $sort[1])
            ->get();
        // 数据处理
        ImageSubject::multiple($data);

        $res = [
            'page'  => $page ,
            'data' => $data
        ];
        return success($res);
    }

    // 添加模块
    public function add(){
        $inputs = $this->request->post();
        $validator = Validator::make($inputs , [
            'name'      => 'required' ,
            'module_id' => 'required' ,
            'category_id' => 'required' ,
            'type'      => 'required' ,
            'status'    => 'required' ,
        ] , [
            'name.required'         => trans('imageSubject.name.required') ,
            'module_id.required'    => trans('imageSubject.module_id.required') ,
            'category_id.required'  => trans('imageSubject.category_id.required') ,
            'type.required'         => trans('imageSubject.type.required') ,
            'status.required'       => trans('imageSubject.status.required') ,
        ]);
        if ($validator->fails()) {
            return form_error($validator);
        }
        $inputs['sort'] = empty($inputs['sort']) ? 50 : intval($inputs['sort']);
        $tags = json_decode($inputs['tag'] , true);
        foreach ($tags as $v)
        {
            Tag::where('name' , $v)->increment('count');
        }
        // 添加的时候不允许存在
        unset($inputs['id']);
        $inputs = array_merge($inputs , [
            'user_type' => 'admin' ,
            'user_id' => $this->request->user->id
        ]);
        $id = ImageSubject::insertGetId($inputs);
        return success($id);
    }

    // 编辑模块
    public function edit(){
        $inputs = $this->request->post();
        $validator = Validator::make($inputs , [
            'id'        => 'required' ,
            'name'      => 'required' ,
            'module_id' => 'required' ,
            'category_id' => 'required' ,
            'type'      => 'required' ,
            'status'    => 'required' ,
        ] , [
            'id.required'           => trans('imageSubject.id.required') ,
            'name.required'         => trans('imageSubject.name.required') ,
            'module_id.required'    => trans('imageSubject.module_id.required') ,
            'category_id.required'  => trans('imageSubject.category_id.required') ,
            'type.required'         => trans('imageSubject.type.required') ,
            'status.required'       => trans('imageSubject.status.required') ,
        ]);
        if ($validator->fails()) {
            return form_error($validator);
        }
        $inputs['sort'] = empty($inputs['sort']) ? 50 : intval($inputs['sort']);
        $id = $inputs['id'];
        unset($inputs['id']);
        ImageSubject::where('id' , $id)->update($inputs);
        return success($id);
    }

    // 删除
    public function del(){
        $inputs = $this->request->post();
        $inputs['id_list'] = empty($inputs['id_list']) ? [] : json_decode($inputs['id_list'] , true);
        if (empty($inputs['id_list'])) {
            return error(trans('imageSubject.id.required'));
        }
        ImageSubject::whereIn('id' , $inputs['id_list'])->delete();
        return success(trans('imageSubject.del.success'));
    }

    // 更新封面
    public function updateThumb(){
        $inputs = $this->request->post();
        if (!$this->request->filled('id')) {
            return error(trans('imageSubject.id.required'));
        }
        if (!$this->request->filled('thumb')) {
            return error('imageSubject.thumb.required');
        }
        $id = $inputs['id'];
        unset($inputs['id']);
        ImageSubject::where('id' , $id)->update($inputs);
        return success($id);
    }

    // 添加图库图片
    public function addImage(){
        $inputs = $this->request->post();
        $id = _Image::insertGetId($inputs);
        return success($id);
    }
    
    // 删除图库图片
    public function delImage(){
        $inputs = $this->request->post();
        $inputs['id_list'] = isset($inputs['id_list']) ? json_decode($inputs['id_list']) : [];
        
        if (empty($inputs['id_list'])) {
            return error(trans('image.id.required'));
        }

        $images = _Image::whereIn('id' , $inputs['id_list'])->get();
        foreach ($images as $v)
        {
            File::del($v->path);
        }
        _Image::whereIn('id' , $inputs['id_list'])->delete();
        return success($inputs['id_list']);
    }

    public function cur(){
        if (!$this->request->filled('id')) {
            return error(trans('imageSubject.id.required'));
        }
        $inputs = $this->request->post();
        $data = ImageSubject::where('id' , $inputs['id'])->first();
        ImageSubject::single($data);
        return success($data);
    }
}