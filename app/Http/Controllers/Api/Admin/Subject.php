<?php
/**
 * Created by PhpStorm.
 * User: grayVTouch
 * Date: 2018/8/30
 * Time: 12:28
 */

namespace App\Http\Controllers\Api\Admin;

use Validator;
use App\Model\Subject as _Subject;
use App\Extra\System\Admin\Page;

class Subject extends Controller
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

        $count  = _Subject::where($where)->count();
        $page   = Page::deal($inputs['page'] , $count , $inputs['limit']);
        $sort   = empty($inputs['sort']) ? ['id' , 'desc'] : explode('|' , $inputs['sort']);

        $data = _Subject::where($where)
            ->offset($page['offset'])
            ->limit($page['limit'])
            ->orderBy($sort[0] , $sort[1])
            ->get();
        // 数据处理
        _Subject::multiple($data);

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
        ] , [
            'name.required' => trans('subject.name.required') ,
        ]);
        if ($validator->fails()) {
            return form_error($validator);
        }
        $inputs['sort'] = empty($inputs['sort']) ? 50 : intval($inputs['sort']);
        // 添加的时候不允许存在
        unset($inputs['id']);
        $id = _Subject::insertGetId($inputs);
        return success($id);
    }

    // 编辑模块
    public function edit(){
        $inputs = $this->request->post();
        $validator = Validator::make($inputs , [
            'id' => 'required' ,
            'name' => 'required' ,
        ] , [
            'id.required' => trans('subject.id.required') ,
            'name.required' => trans('subject.name.required') ,
        ]);
        if ($validator->fails()) {
            return form_error($validator);
        }
        $inputs['sort'] = empty($inputs['sort']) ? 50 : intval($inputs['sort']);
        $id = $inputs['id'];
        unset($inputs['id']);
        _Subject::where('id' , $id)->update($inputs);
        return success($id);
    }

    // 删除
    public function del(){
        $inputs = $this->request->post();
        $inputs['id_list'] = empty($inputs['id_list']) ? [] : json_decode($inputs['id_list'] , true);
        if (empty($inputs['id_list'])) {
            return error(trans('subject.id.required'));
        }
        _Subject::whereIn('id' , $inputs['id_list'])->delete();
        return success(trans('subject.del.success'));
    }

    // 更新封面
    public function updateThumb(){
        $inputs = $this->request->post();
        if (!$this->request->filled('id')) {
            return error(trans('subject.id.required'));
        }
        if (!$this->request->filled('thumb')) {
            return error('subject.thumb.required');
        }
        $id = $inputs['id'];
        unset($inputs['id']);
        _Subject::where('id' , $id)->update($inputs);
        return success($id);
    }

    // 模块
    public function cur(){
        if (!$this->request->filled('id')) {
            return error(trans('subject.id.required'));
        }
        $inputs = $this->request->post();
        $data = _Subject::where('id' , $inputs['id'])->first();
        _Subject::single($data);
        return success($data);
    }

    // 主体分类
    public function all(){
        $inputs = $this->request->post();
        if (!$this->request->filled('query')) {
            return success([]);
        }
        if (check_num($inputs['query'] , 0)) {
            $res = _Subject::where('id' , $inputs['query'])->get();
        } else {
            $res = _Subject::where('name' , 'like' , "%{$inputs['query']}%")->get();
        }
        return success($res);
    }
}