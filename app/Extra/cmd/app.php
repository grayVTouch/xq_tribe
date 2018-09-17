<?php
/**
 * Created by PhpStorm.
 * User: grayVTouch
 * Date: 2018/7/22
 * Time: 8:59
 *
 * 应用注册
 * 系统本身采取纯前后端分离的情况下，系统前端要访问 api ，那么请走命令性流程！
 */

require __DIR__ . '/initialize.php';

$login = function() use(&$login , $conn){
    echo "请输入token类型（system-系统 user-第三方平台）";
    $type = trim(fgets(STDIN));

    if ($type == 'user') {
        echo "请输入用户名：";
        $username = trim(fgets(STDIN));
        echo "请输入密码：";
        $password = trim(fgets(STDIN));

        // 检查用户名密码
        $sql = [
            'sql' => 'select id , password from xq_user where username = :username' ,
            'params' => [
                'username' => $username
            ]
        ];

        $user = $conn->get($sql['sql'] , $sql['params']);

        if (empty($user)) {
            echo "用户名错误！请重新输入\n";
            return $login();
        }

        if (!password_verify($password , $user['password'])) {
            echo "密码错误！请重新输入\n";
            return $login();
        }

        return $user['id'];
    }

    return null;
};

echo "请先登录！\n";

// 填写相应信息
$info = [];
// 用户登录
$info['user_id'] = $login();
echo "登录成功！\n";
echo "请输入应用名称：";
$info['name'] = trim(fgets(STDIN));
echo "请输入应用描述：";
$info['desc'] = trim(fgets(STDIN));
echo "请输入应用URL：";
$info['url'] = trim(fgets(STDIN));
echo "请输入授权码回调地址：";
$info['redirect'] = trim(fgets(STDIN));
// 是否系统平台
$info['is_system'] = empty($info['user_id']) ? 'y' : 'n';
// 审核状态
$info['status'] = 'pass';
echo "确认生成？？（y/n）";
$next = trim(fgets(STDIN));
if ($next === 'n') {
    exit("你取消了操作\n");
}

$info['secret'] = ssl_random(256);

try {
    $sql = [
        'sql'    => 'insert into xq_client (user_id , name , `desc` , url , redirect , secret , is_system , status) values (:user_id , :name , :desc , :url , :redirect , :secret , :is_system , :status)' ,
        'params' => $info
    ];

    $conn->query($sql['sql'] , $sql['params']);
    $info['client_id'] = $conn->lastInsertId();

    echo "应用注册成功！！\n\n";
    echo "请查看完整注册信息：\n";

    foreach ($info as $k => $v)
    {
        echo $k . ":" . $v . "\n";
    }
} catch(Exception $e) {
    // echo $e->getFile();
    echo "发生错误!\n";
    echo "错误文件：" . $e->getFile() . "\n";
    echo "错误行数：" . $e->getLine() . "\n";
    echo "错误信息：" . $e->getMessage() . "\n";
}

echo "\n是否继续申请授权码？？（y/n）\n";
$next = trim(fgets(STDIN));
if ($next === 'n') {
    exit;
}

echo "正在启动授权码申请流程...\n";
sleep(1);
require_once __DIR__ . '/code.php';