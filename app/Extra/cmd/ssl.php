<?php
/**
 * Created by PhpStorm.
 * User: grayVTouch
 * Date: 2018/7/22
 * Time: 15:17
 */
require_once __DIR__ . '/../public/core/Function/base.php';
require_once __DIR__ . '/../public/core/Lib/Database.php';
require_once __DIR__ . '/../public/core/Lib/File.php';

use Core\Lib\File;
use Core\Lib\Database;

// 创建客户端

// 应用在平台上注册
// 应用在平台上登录
// 申请客户端id + 密钥
// 申请授权码
// 使用授权码申请 access_token 和 refresh_token
// 所有的使用 api 用户都是第三方客户端
$pub_file   = __DIR__ . '/pub.key';
$priv_file  = __DIR__ . '/priv.key';

if (!File::isFile($pub_file) || !File::isFile($priv_file)) {
    $pub    = file_get_contents($pub_file);
    $priv   = file_get_contents($priv_file);

    if (empty($pub) || empty($priv)) {
        $config = [
            'private_key_bits' => 2046 ,
            'private_key_type' => OPENSSL_KEYTYPE_RSA
        ];

        $res = openssl_pkey_new($config);
        openssl_pkey_export($res , $priv);
        $pub = openssl_pkey_get_details($res)['key'];

        file_put_contents($pub_file , $pub , LOCK_EX);
        file_put_contents($priv_file , $priv , LOCK_EX);
    }
}

$pub    = file_get_contents($pub_file);
$priv   = file_get_contents($priv_file);