<?php
/**
 * Created by PhpStorm.
 * User: grayVTouch
 * Date: 2018/6/29
 * Time: 20:22
 */

namespace App\Http\Controllers\Api;

use Core\Lib\UploadFile;
use Core\Lib\UploadImage;
use Core\Lib\File as _File;

class File extends Controller
{
    // 图片目录
    protected $_imageDir    = '';
    // 文件目录
    protected $_fileDir     = '';

    public $file = null;

    public $image = null;

    function __construct(){
        parent::__construct();

        $this->_fileDir = pub_config('file.file_dir');
        $this->_imageDir = pub_config('file.image_dir');

        $this->file     = new UploadFile($this->_fileDir);
        $this->image    = new UploadImage($this->_imageDir);
    }

    // 单个：上传文件
    public function file(){
        $file = \Request::file('file');

        if (UploadFile::emptyFile($file)) {
            return error(trans('file.empty'));
        }

        $this->file->save($file);
    }

    // 多个：上传文件
    public function files(){
        $files = isset($_FILES['files']) ? $_FILES['file'] : null;

        if (empty($image)) {
            return error(trans('file.empty'));
        }

        if ($this->file->emptyFile($image)) {
            return error(trans('file.empty'));
        }

        $res = $this->file->saveAll($files);
    }

    // 单个：上传图片
    public function image(){
        $image = isset($_FILES['image']) ? $_FILES['image'] : [];

        if (empty($image)) {
            return error(trans('file.empty'));
        }

        if ($this->image->emptyFile($image)) {
            return error(trans('file.empty'));
        }

        $image = $this->image->images($image);

        if (empty($image)) {
            return error(trans('file.invalid'));
        }

        $res = $this->image->save($image);

        if (!$res) {
            return error('file.error');
        }
        $res['path'] = str_replace(format_path(public_path()) , '' , $res['path']);
        $res['url'] = gen_url($res['path']);
        return success($res);
    }

    // 多个：上传图片
    public function images(){
        $images = isset($_FILES['images']) ? $_FILES['images'] : [];

        if (empty($image)) {
            return error(trans('file.empty'));
        }

        if ($this->image->emptyFile($images)) {
            return error(trans('file.empty'));
        }

        $images = $this->image->images($images);

        if (empty($images)) {
            return error(trans('file.invalid'));
        }

        $res = $this->image->saveAll($images);

        if (!$res) {
            return error('file.error');
        }

        $res['url'] = str_replace(public_path('/') , '' , $res['path']);
        unset($res['path']);
        return success($res);
    }

    // 删除文件
    public function del(){
        $inputs = \Request::post();
        // 文件类型
        $files = empty($inputs['files']) ? [] : json_decode($inputs['files'] , true);

        if (empty($files)) {
            return error('file.del.empty');
        }

        // 删除磁盘上的文件
        foreach ($files as $v)
        {
            $file = gen_path($v);
            if (!_File::isFile($file)) {
                continue ;
            }

            _File::dFile($file);
        }

        return success($files);
    }
}