<?php
/**
 * Created by PhpStorm.
 * User: grayVTouch
 * Date: 2018/7/22
 * Time: 11:34
 */

session_start();

if (!isset($_SESSION['encrypt'])) {
    // 创建一个密钥对
    $res = openssl_pkey_new([
        'private_key_bits' => 512 ,
        'private_key_type' => OPENSSL_KEYTYPE_RSA
    ]);

    openssl_pkey_export($res , $priv_key);
    $pub_key = openssl_pkey_get_details($res)['key'];

    $_SESSION['pub_key']    = $pub_key;
    $_SESSION['priv_key']   = $priv_key;

    var_dump('生成密钥对');
    print_r("\n\n");
}

$pub_key    = $_SESSION['pub_key'];
$priv_key   = $_SESSION['priv_key'];

$origin = '364793';

print_r("源数据：{$origin}\n");

$de_res = openssl_public_encrypt($origin , $en , $pub_key);

print_r("加密后数据：{$en}\n");

openssl_private_decrypt($en , $de , $priv_key);

print_r("解密后数据：{$de}\n");

print_r('结束！');

$_SESSION['encrypt'] = true;