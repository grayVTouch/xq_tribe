<?php
/**
 * Created by PhpStorm.
 * User: grayVTouch
 * Date: 2018/8/18
 * Time: 17:54
 */

require_once __DIR__ . '/../core/Function/base.php';
require_once __DIR__ . '/../core/Lib/Database.php';

use Core\Lib\Database;

$conn = new Database('mysql' , '127.0.0.1' , 'xq_tribe' , 'root' , '364793' , false , 'utf8');