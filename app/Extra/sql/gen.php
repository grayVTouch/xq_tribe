<?php
/**
 * Created by PhpStorm.
 * User: grayVTouch
 * Date: 2018/8/16
 * Time: 15:45
 */

require __DIR__ . '/../core/Function/base.php';
require __DIR__ . '/../core/Function/file.php';
require __DIR__ . '/../core/Lib/File.php';

use Core\Lib\File;

$files = File::getFiles(__DIR__ ,false);
$current = format_path(__FILE__);

$install_file = __DIR__ . '/install.sql';

if (!File::isFile($install_file)) {
    File::cFile($install_file);
}

$sql = '';
foreach ($files as $v)
{
    if ($v == $current) {
        continue ;
    }

    $v = gbk($v);
    $con = file_get_contents($v);
    $con .= "\n";
    $con .= "\n";
    $sql .= $con;
}
// 写入文件
File::write($install_file , $sql , 'w');
$install_file = format_path($install_file);
echo "generate success: {$install_file}\n";