<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

use Illuminate\Http\Request;

Route::get('/', function (Request $reqeust) {
    return view('welcome');
});

Route::get('/test/fuck' , function(Request $q){
    var_dump($q->path());
});

Route::get('Test/index' , 'Test@index');
Route::post('Test/check' , 'Test@check');
Route::get('Test/t' , 'Test@t');
Auth::routes();

Route::get('/home', 'HomeController@index')->name('home');
