<?php
/**
 * Created by PhpStorm.
 * User: grayVTouch
 * Date: 2018/8/23
 * Time: 14:37
 */

namespace App\Http\Controllers\Api\Admin;

use App\Model\Tag as _Tag;
use App\Extra\System\Page;
use Validator;

class Tag extends Controller
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

        $count  = _Tag::where($where)->count();
        $page   = Page::deal($inputs['page'] , $count , $inputs['limit']);
        $sort   = empty($inputs['sort']) ? ['id' , 'desc'] : explode('|' , $inputs['sort']);

        $data = _Tag::where($where)
            ->offset($page['offset'])
            ->limit($page['limit'])
            ->orderBy($sort[0] , $sort[1])
            ->get();
        // 数据处理
        _Tag::multiple($data);

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
            'name' => 'required' ,
            'sort' => 'integer'
        ] , [
            'name.required' => trans('tag.name.required') ,
            'sort.required' => trans('tag.sort.type')
        ]);
        if ($validator->fails()) {
            return form_error($validator);
        }
        // 检查是否已经存在该标签了
        $exists = (bool) _Tag::where('name' , $inputs['name'])->count();
        if ($exists) {
            return error(trans('tag.name.repeat'));
        }
        $inputs['sort'] = empty($inputs['sort']) ? 50 : intval($inputs['sort']);
        // 添加的时候不允许存在
        unset($inputs['id']);
        $id = _Tag::insertGetId($inputs);
        return success($id);
    }

    // 编辑模块
    public function edit(){
        $inputs = $this->request->post();
        $validator = Validator::make($inputs , [
            'id' => 'required' ,
            'name' => 'required' ,
            'sort' => 'integer'
        ] , [
            'id.required' => trans('tag.id.required') ,
            'sort.integer' => trans('tag.sort.type')
        ]);
        if ($validator->fails()) {
            return form_error($validator);
        }
        $inputs['sort'] = empty($inputs['sort']) ? 50 : intval($inputs['sort']);
        unset($inputs['id']);
        $id = _Tag::where('id' , $this->request->post('id'))->update($inputs);
        return success($id);
    }

    // 删除
    public function del(){
        $inputs = $this->request->post();
        $inputs['id_list'] = empty($inputs['id_list']) ? [] : json_decode($inputs['id_list'] , true);
        if (empty($inputs['id_list'])) {
            return error(trans('tag.id.required'));
        }
        _Tag::whereIn('id' , $inputs['id_list'])->delete();
        return success(trans('tag.del.success'));
    }

    // 模块
    public function cur(){
        if (!$this->request->filled('id')) {
            return error(trans('tag.id.required'));
        }
        $inputs = $this->request->post();
        $data = _Tag::where('id' , $inputs['id'])->first();
        return success($data);
    }

    // 热门标签
    public function hot(){
        $data = _Tag::orderBy('count' , 'desc')->get();
        return success($data);
    }
}