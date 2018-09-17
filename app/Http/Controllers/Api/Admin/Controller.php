<?php
/**
 * Created by PhpStorm.
 * User: grayVTouch
 * Date: 2018/6/30
 * Time: 0:45
 */

namespace App\Http\Controllers\Api\Admin;

use App\Http\Controllers\Api\Controller as BaseController;
use Illuminate\Http\Request;

class Controller extends BaseController
{
    public function __construct(Request $req){
        parent::__construct();
        $this->request = $req;
        $this->middleware('admin_user_auth');
    }
}