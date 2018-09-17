<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

// api 路由（共享路由）
Route::namespace('Api')->group(function(){
    Route::get('Code/captcha' , 'Code@captcha');
    Route::post('File/image' , 'File@image');
    Route::post('File/images' , 'File@images');
    Route::post('File/file' , 'File@file');
    Route::post('File/files' , 'File@files');
});

// 后台路由
Route::prefix('Admin')->namespace('Api\Admin')->group(function(){
    // 用户管理
    Route::post('User/add' , 'User@add');
    Route::post('User/edit' , 'User@edit');
    Route::post('User/updateAvatar' , 'User@updateAvatar');
    Route::post('User/list' , 'User@list');
    Route::post('User/del' , 'User@del');
    Route::post('User/cur' , 'User@cur');

    // 后台用户管理
    Route::post('AdminUser/login' , 'AdminUser@login');
    Route::post('AdminUser/loginOut' , 'AdminUser@loginOut');
    Route::post('AdminUser/addAdmin' , 'AdminUser@addAdmin');
    Route::post('AdminUser/admins' , 'AdminUser@admins');

    // 模块管理
    Route::post('Module/list' , 'Module@list');
    Route::post('Module/add' , 'Module@add');
    Route::post('Module/edit' , 'Module@edit');
    Route::post('Module/del' , 'Module@del');
    Route::post('Module/cur' , 'Module@cur');
    Route::post('Module/all' , 'Module@all');

    // 标签管理
    Route::post('Tag/list' , 'Tag@list');
    Route::post('Tag/add' , 'Tag@add');
    Route::post('Tag/edit' , 'Tag@edit');
    Route::post('Tag/del' , 'Tag@del');
    Route::post('Tag/cur' , 'Tag@cur');
    Route::post('Tag/hot' , 'Tag@hot');

    // 图库管理
    Route::post('Image/add' , 'Image@add');
    Route::post('Image/edit' , 'Image@edit');
    Route::post('Image/updateThumb' , 'Image@updateThumb');
    Route::post('Image/list' , 'Image@list');
    Route::post('Image/del' , 'Image@del');
    Route::post('Image/cur' , 'Image@cur');
    Route::post('Image/addImage' , 'Image@addImage');
    Route::post('Image/delImage' , 'Image@delImage');

    // 分类管理
    Route::post('Category/list' , 'Category@list');
    Route::post('Category/add' , 'Category@add');
    Route::post('Category/edit' , 'Category@edit');
    Route::post('Category/del' , 'Category@del');
    Route::post('Category/cur' , 'Category@cur');

    // 关联主体
    Route::post('Subject/add' , 'Subject@add');
    Route::post('Subject/edit' , 'Subject@edit');
    Route::post('Subject/updateThumb' , 'Subject@updateThumb');
    Route::post('Subject/list' , 'Subject@list');
    Route::post('Subject/del' , 'Subject@del');
    Route::post('Subject/cur' , 'Subject@cur');
    Route::post('Subject/all' , 'Subject@all');

    // 仅开发使用
    Route::get('AdminUser/add' , 'AdminUser@addAdmin');
});

// 移动端路由
Route::prefix('Mobile')->namespace('Api\Mobile')->group(function(){
    Route::post('User/login' , 'User@login');
    Route::post('User/cur' , 'User@cur');

    // 图片
    Route::post('Image/list' , 'Image@list');
    Route::post('Image/detail' , 'Image@detail');
    Route::post('Image/comments' , 'Image@comments');
    Route::post('Image/comment' , 'Image@comment');
    Route::post('Image/reply' , 'Image@reply');
    Route::post('Image/addComment' , 'Image@addComment');
});