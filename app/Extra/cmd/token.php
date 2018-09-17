<?php
/**
 * Created by PhpStorm.
 * User: grayVTouch
 * Date: 2018/7/22
 * Time: 20:38
 *
 * 申请 token 流程
 */

require __DIR__ . '/initialize.php';

echo "请输入授权码：";
$code = trim(fgets(STDIN));

$sql = [
    'sql'    => 'select * from xq_auth_code where code = :code and expire >= :cur_time' ,
    'params' => [
        'code' => $code ,
        'cur_time' => date('Y-m-d H:i:s')
    ]
];

$codes = $conn->get($sql['sql'] , $sql['params']);

if (empty($codes) || $codes['used'] === 'y') {
    exit("未找到授权码对应记录 或 授权码已被使用 或 授权码已过期！");
}

// 更新授权码使用记录
$sql = [
    'sql'    => 'update xq_auth_code set used = 1 where id = :id' ,
    'params' => [
        'id' => $codes['id']
    ]
];

$conn->query($sql['sql'] , $sql['params']);

// 获取客户端类型
$sql = [
    'sql'    => 'select * from xq_client where id = :id' ,
    'params' => [
        'id' => $codes['client_id']
    ]
];

$client = $conn->get($sql['sql'] , $sql['params']);

$token = [];

$token['client_id'] = $codes['client_id'];
$token['access_token'] = ssl_random(256);
$token['refresh_token'] = ssl_random(256);
$token['access_token_expire'] = date('Y-m-d H:i:s' , time() + 30 * 24 * 3600);
$token['permanent'] = $client['is_system'];

try {
    $sql = [
        'sql'    => 'insert into xq_auth_token (client_id , access_token , refresh_token , access_token_expire , permanent) values (:client_id , :access_token , :refresh_token , :access_token_expire , :permanent)' ,
        'params' => $token
    ];

    $conn->query($sql['sql'] , $sql['params']);

    echo "申请token成功：\n\n";
    echo "token信息：\n";

    foreach ($token as $k => $v)
    {
        echo $k . ":" . $v . "\n";
    }
} catch(Exception $e) {
    echo "发生错误!\n";
    echo "错误文件：" . $e->getFile() . "\n";
    echo "错误行数：" . $e->getLine() . "\n";
    echo "错误信息：" . $e->getMessage() . "\n";
}