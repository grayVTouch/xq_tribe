<?php
/**
 * Created by PhpStorm.
 * User: grayVTouch
 * Date: 2018/8/28
 * Time: 14:44
 */

namespace App\Http\Controllers\Api\Admin;

use Validator;
use App\Model\Category as _Category;
use Core\Lib\Category as TCategory;

class Category extends Controller
{
    // 分类列表
    public function list (){
        $data = _Category::get();
        _Category::multiple($data);
        $data = $data->toArray();
        $res = TCategory::childrens(0 , $data);
        return success($res);
    }

    // 编辑分类
    public function edit(){
        $inputs = $this->request->post();

        $validator = Validator::make($inputs , [
            'id'    => 'bail|required' ,
            'name' => 'bail|required' ,
            'pid' => 'bail|required'
        ] , [
            'id.required' => trans('category.id.required') ,
            'name.required' => trans('category.name.required') ,
            'pid.required' => trans('category.pid.required') ,
        ]);
        if ($validator->fails()) {
            return form_error($validator);
        }
        // 检查是否能够修改
        $system = _Category::where('id' , $inputs['id'])->value('system');
        if ($system === 'y') {
            return error(trans('category.system.error'));
        }
        // 检查分类名称是否重复
        $exists = (bool) _Category::where([
            ['id' , '!=' , $inputs['id']] ,
            ['pid' , '=' , $inputs['pid']] ,
            ['name' , '=' , $inputs['name']] ,
        ])->count();
        if ($exists) {
            $validator->errors()->add('name' , trans('category.name.repeat'));
            return form_error($validator);
        }
        $inputs['sort'] =  check_num($inputs['sort'] , 0) ? $inputs['sort'] : pub_config('app.sort');
        unset($inputs['id']);
        _Category::where('id' , $this->request->post('id'))->update($inputs);
        return success($this->request->post('id'));
    }

    // 添加分类
    public function add(){
        $inputs = $this->request->post();

        $validator = Validator::make($inputs , [
            'name' => 'bail|required' ,
            'pid' => 'bail|required'
        ] , [
            'name.required' => trans('category.name.required') ,
            'pid.required' => trans('category.pid.required') ,
        ]);
        if ($validator->fails()) {
            return form_error($validator);
        }
        // 检查分类名称是否重复
        $exists = (bool) _Category::where([
            ['pid' , '=' , $inputs['pid']] ,
            ['name' , '=' , $inputs['name']] ,
        ])->count();
        if ($exists) {
            $validator->errors()->add('name' , trans('category.name.repeat'));
            return form_error($validator);
        }
        $inputs['sort'] =  check_num($inputs['sort'] , 0) ? $inputs['sort'] : pub_config('app.sort');
        unset($inputs['id']);
        $id = _Category::insertGetId($inputs);
        return success($id);
    }

    // 删除
    public function del(){
        $inputs = $this->request->post();
        $inputs['id_list'] = isset($inputs['id_list']) ? json_decode($inputs['id_list'] , true) : [];
        if (empty($inputs['id_list'])) {
            return error(trans('category.id.required'));
        }
        $data = _Category::get()->toArray();
        $id_list = [];
        foreach ($inputs['id_list'] as $v)
        {
            // 获取所有子集
            $children = TCategory::childrens($v , $data , null , true , false);
            array_walk($children , function($v) use(&$id_list){
                $id_list[] = $v['id'];
            });
        }
        // 检查是否包含系统内置分类
        $exists = (bool) _Category::whereIn('id' , $id_list)->where('system' , 'y')->count();
        if ($exists) {
            return error(trans('category.del.system.error'));
        }
        _Category::whereIn('id' , $id_list)->delete();
        return success(trans('category.del.success'));
    }

    // 模块
    public function cur(){
        if (!$this->request->filled('id')) {
            return error(trans('category.id.required'));
        }
        $inputs = $this->request->post();
        $data = _Category::where('id' , $inputs['id'])->first();
        return success($data);
    }
}