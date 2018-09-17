<?php
/**
 * Created by PhpStorm.
 * User: grayVTouch
 * Date: 2018/7/22
 * Time: 20:21
 *
 * 生成授权码
 */

require __DIR__ . '/initialize.php';

$info = [];
echo '请输入客户端id：';
$info['client_id'] = trim(fgets(STDIN));
echo "请输入密钥：";
$info['secret'] = trim(fgets(STDIN));
echo "请输入回调地址：";
$info['url'] = trim(fgets(STDIN));

$sql = [
    'sql'    => 'select * from xq_client where id = :id and secret = :secret and redirect = :redirect' ,
    'params' => [
        'id'        => $info['client_id'] ,
        'secret'    => $info['secret'] ,
        'redirect'  => $info['url']
    ]
];

$client = $conn->get($sql['sql'] , $sql['params']);

if (empty($client)) {
    exit("未找到应用注册信息！\n");
}

$codes = [];
$codes['client_id'] = $client['id'];
$codes['code'] = preg_replace('/[^A-z0-9]*/' , '' , base64_encode(openssl_random_pseudo_bytes(256)));
$codes['expire'] = date('Y-m-d H:i:s' , time() + 10 * 60);

try {
    $sql = [
        'sql'    => 'insert into xq_auth_code (client_id , code , expire) values (:client_id , :code , :expire)' ,
        'params' => $codes
    ];

    $conn->query($sql['sql'] , $sql['params']);

    echo "申请授权码成功：\n\n";
    echo "授权码信息：\n";

    foreach ($codes as $k => $v)
    {
        echo $k . ":" . $v . "\n";
    }
} catch(Exception $e) {
    // echo $e->getFile();
    echo "发生错误!\n";
    echo "错误文件：" . $e->getFile() . "\n";
    echo "错误行数：" . $e->getLine() . "\n";
    echo "错误信息：" . $e->getMessage() . "\n";
    exit;
}

echo "是否继续申请token？？（y/n）\n";
$next = trim(fgets(STDIN));
if ($next === 'n') {
    exit;
}

echo "正在启动token申请流程...\n";
sleep(1);
require_once __DIR__ . '/token.php';
