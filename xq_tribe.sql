/*
 Navicat Premium Data Transfer

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 80017
 Source Host           : localhost:3306
 Source Schema         : xq_tribe

 Target Server Type    : MySQL
 Target Server Version : 80017
 File Encoding         : 65001

 Date: 18/04/2020 15:12:35
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for xq_admin_land_log
-- ----------------------------
DROP TABLE IF EXISTS `xq_admin_land_log`;
CREATE TABLE `xq_admin_land_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户id',
  `ip` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登录ip',
  `duration` smallint(6) NULL DEFAULT NULL COMMENT '登录时长，单位 s',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '登录时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '管理员登录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xq_admin_land_log
-- ----------------------------
INSERT INTO `xq_admin_land_log` VALUES (1, 1, '127.0.0.1', NULL, '2020-04-18 14:27:34');

-- ----------------------------
-- Table structure for xq_admin_user
-- ----------------------------
DROP TABLE IF EXISTS `xq_admin_user`;
CREATE TABLE `xq_admin_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `sex` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别',
  `birthday` date NULL DEFAULT NULL COMMENT '生日',
  `avatar` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `token` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户登录后 token',
  `token_expire` datetime(0) NULL DEFAULT NULL COMMENT 'token 过期时间',
  `is_delete` enum('y','n') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'n' COMMENT '是否被删除',
  `last_time` datetime(0) NULL DEFAULT NULL COMMENT '最近登录时间',
  `last_ip` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最近登录ip',
  `province_id` int(11) NULL DEFAULT NULL COMMENT '省份',
  `city_id` int(11) NULL DEFAULT NULL COMMENT '城市',
  `area_id` int(11) NULL DEFAULT NULL COMMENT '区域',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '具体地址',
  `is_lock` enum('y','n') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'n' COMMENT '是否锁定',
  `lock_time` datetime(0) NULL DEFAULT NULL COMMENT '锁定时间',
  `lock_expire` datetime(0) NULL DEFAULT NULL COMMENT '锁定过期时间',
  `phone` int(11) NULL DEFAULT NULL COMMENT '手机',
  `email` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电子邮件',
  `group_id` int(11) NULL DEFAULT NULL COMMENT 'xq_group.id',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '注册时间',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '管理员-用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xq_admin_user
-- ----------------------------
INSERT INTO `xq_admin_user` VALUES (1, 'yueshu', '$2y$10$Ty.439Js99zJIwsm41uctONZVV6LW88mCSvI1p3IXp71E3BnPKtWu', NULL, NULL, NULL, NULL, NULL, 'n', '2020-04-18 14:27:34', '127.0.0.1', NULL, NULL, NULL, NULL, 'n', NULL, NULL, NULL, NULL, NULL, '2020-04-18 14:27:01', '2020-04-18 14:27:34');

-- ----------------------------
-- Table structure for xq_auth_code
-- ----------------------------
DROP TABLE IF EXISTS `xq_auth_code`;
CREATE TABLE `xq_auth_code`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NULL DEFAULT NULL COMMENT 'xq_client.id',
  `code` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '授权码',
  `expire` datetime(0) NULL DEFAULT NULL COMMENT '过期时间',
  `used` enum('y','n') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'n' COMMENT '是否被使用过: 0-否，1-是',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '授权码' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xq_auth_code
-- ----------------------------
INSERT INTO `xq_auth_code` VALUES (1, 1, 'k7uEzFlGz42PXxaTnp62B126BT80w9SYvgrBUcj3ZoISekTFAcRQ8rPq9DHhTERDyYxR7bvJN3izorwHzwnAu68ZIIQjhClYbqIDPWTjBVDtd0wUUN3euqbvVQdTK7d4FYtn0Kzjojot7JfmXsHIdX6L3R4tqnk498jqMUVTuf4pfcqrsEmibu8CQ6jRGJFaSM2gdfJiT7orwjCaKO1LAsEEBC13EcWoRObcUgA2rZm749s1zNtk5C3NTpQXSgONNb8KAGApqbt9ZhKBtKffGBglWSuMyi9MbzVERo5UsazxRoQabFpSYQgFOxlf2ztfC2Q9jjhnCw', '2020-04-18 14:32:24', 'y', '2020-04-18 14:22:24');

-- ----------------------------
-- Table structure for xq_auth_token
-- ----------------------------
DROP TABLE IF EXISTS `xq_auth_token`;
CREATE TABLE `xq_auth_token`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NULL DEFAULT NULL COMMENT 'xq_client.id',
  `access_token` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'access token',
  `refresh_token` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'refresh token',
  `access_token_expire` datetime(0) NULL DEFAULT NULL COMMENT '过期时间',
  `scope` int(11) NULL DEFAULT NULL COMMENT '权限范围，对应 xq_group.id',
  `permanent` enum('y','n') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'n' COMMENT 'token 是否永久有效（仅用于平台系统开发）',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `client_id`(`client_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'auth token' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xq_auth_token
-- ----------------------------
INSERT INTO `xq_auth_token` VALUES (1, 1, 'D91VDxLb8andxZNsudtjS9XtAMoZXnwWNeiDHYLmmAvRjdh9zEOSrwNV3vkSvs6JeuDbUlsyOdCxt6Z5I4LsxcGRL9vMoEaN4DcHZBb9NcOPGFMqLJVSG6WxTMONrBr2F1g7XI9wG0N2y3bICLbW8xkS1oEuJwx50A9IDS0mZpgRPeb32imLBaxNDq9rKm6ZT2i066XIvawEPOXCDahe7zYOQgKVXIKJ6rd0ysDYqsU11XTPSoVeFoEOB5bWliAjYC4nbLrForTmKyWCljUKmT6VtGiDJiy5MBKCneeW7t6Pr2kgjIndH6bIQsknyMulDpYZ514NWCxXA', 'V5KPab5jrNzkxc2gleXbdynA2RZ42Sryz2khLW6JS4uuta9WUGstwCONbZ5SNNzF9tUsb7JgFnJsixlvI8DNVuyFRRhgNGNDwZBmNxU61bBQQknBPJGeLb7hdNvS8tMNYLEjrwDP3I7OpT88W1b7wS92AZ7O3myA6rrvIpQNK5O8rxO5eLCfo0pyLVkCeJNewwPrrO7Fmppfn3JUDwYnMT8CAcZgFZKtK1NKlaIjODigPuQUc2Hln3uGfhAFfnT5sxPkxnkSx6x1QxNtAbabeLGRNgOp08UItjAezAfOKEogLeN5yaAJoVtp6t0TeK0aVVBQrijg', '2020-05-18 14:22:43', NULL, 'y', '2020-04-18 14:22:43');

-- ----------------------------
-- Table structure for xq_category
-- ----------------------------
DROP TABLE IF EXISTS `xq_category`;
CREATE TABLE `xq_category`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类名称',
  `desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类描述',
  `pid` int(11) NULL DEFAULT NULL COMMENT '上级id',
  `sort` smallint(6) NULL DEFAULT 50 COMMENT '权重',
  `disabled` enum('y','n') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'n' COMMENT '是否被禁用',
  `system` enum('y','n') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'n' COMMENT '系统内置',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`, `pid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xq_category
-- ----------------------------
INSERT INTO `xq_category` VALUES (1, '图片-兴趣部落', NULL, 0, 50, 'n', 'n', '2020-04-18 14:34:00');
INSERT INTO `xq_category` VALUES (2, '游戏图片', NULL, 1, 50, 'n', 'n', '2020-04-18 14:34:25');
INSERT INTO `xq_category` VALUES (3, '美女图片', NULL, 1, 50, 'n', 'n', '2020-04-18 14:34:49');

-- ----------------------------
-- Table structure for xq_client
-- ----------------------------
DROP TABLE IF EXISTS `xq_client`;
CREATE TABLE `xq_client`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL COMMENT 'xq_user.id',
  `name` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '应用名称',
  `desc` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '应用描述',
  `url` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '应用链接',
  `redirect` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '应用认证通过后，携带授权码跳转的 url',
  `secret` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '客户端密钥',
  `scope` int(11) NULL DEFAULT NULL,
  `is_system` enum('y','n') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'n' COMMENT '是否平台自有客户端',
  `status` enum('wait','ing','fail','pass') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'wait' COMMENT '审核状态：wait-待审核 ing-审核中 fail-审核不通过 pass-审核通过',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '授权客户端表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xq_client
-- ----------------------------
INSERT INTO `xq_client` VALUES (1, NULL, 'xq_tribe', 'xq_tribe', 'http://xq_tribe.com/', 'http://xq_tribe.com/', 'g3kuA55YsohwkBL6bSKPeqpil70Q8AD90J1vFodp5RvwJYXseORNFdH0EhCdxJNf6AQqhwwDCGVPp9FbI7E76sFeOdkuB4bnTZTMiJqJUFz3GZnPYvaIjwd9bqPViT9qW5ONl70UpgC10Bvzd7ojwE8sr5ZHP1HO4OnBn3LjEZ4mylEoYM11bzfLm0xWBBS5PQUyqXM2kUZSu9BirnW9ui7JTggyBeS2ShBuRIbrNOuxOW0pTxW08XdwCIfHRghiejCyosZn7SYKtdcFBFurjjaSHtwZLXDwq88HV1SLGsD3ehG7Pbqd9m30ZrOuDkE4pmZfR3cTuxvK0FQ', NULL, 'y', 'pass', '2020-04-18 14:21:40');

-- ----------------------------
-- Table structure for xq_client_privilege
-- ----------------------------
DROP TABLE IF EXISTS `xq_client_privilege`;
CREATE TABLE `xq_client_privilege`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NULL DEFAULT NULL COMMENT 'xq_client.id',
  `privilege_id` int(11) NULL DEFAULT NULL COMMENT 'xq_privilege.id',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `client_id`(`client_id`, `privilege_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '客户端申请的权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for xq_group
-- ----------------------------
DROP TABLE IF EXISTS `xq_group`;
CREATE TABLE `xq_group`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组名',
  `type` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类型：admin-后台用户组 front-前端用户组，其他待扩展',
  `pid` int(11) NULL DEFAULT NULL COMMENT '父级id',
  `can_modify` enum('y','n') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'y' COMMENT '是否能够修改',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户组' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for xq_group_privilege
-- ----------------------------
DROP TABLE IF EXISTS `xq_group_privilege`;
CREATE TABLE `xq_group_privilege`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NULL DEFAULT NULL COMMENT 'xq_group.id',
  `privilege_id` int(11) NULL DEFAULT NULL COMMENT 'xq_privilege.id',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `group_id`(`group_id`, `privilege_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户组权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for xq_image
-- ----------------------------
DROP TABLE IF EXISTS `xq_image`;
CREATE TABLE `xq_image`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image_subject_id` int(11) NULL DEFAULT NULL COMMENT 'xq_image_subject.id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片名称',
  `desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片描述',
  `alt` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '替换内容',
  `filename` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件名称',
  `mime` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件 mime 类型',
  `size` int(11) NULL DEFAULT NULL COMMENT '文件大小：字节',
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '相对路径',
  `test` enum('y','n') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'n' COMMENT '是否测试图片，部署时可删除',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '专题内子图片表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xq_image
-- ----------------------------
INSERT INTO `xq_image` VALUES (1, 2, NULL, NULL, NULL, 'upload-2020-04-18 14-48-29-392e6bcdc9bac7f664e01ace94b6aa31.jpg', 'image/jpeg', 2029317, '/static/share/image/2020-04-18/upload-2020-04-18 14-48-29-392e6bcdc9bac7f664e01ace94b6aa31.jpg', 'n', '2020-04-18 14:48:29');
INSERT INTO `xq_image` VALUES (3, 2, NULL, NULL, NULL, 'upload-2020-04-18 14-49-07-f8871ecfb1a77d96f26bbdebfda61d84.jpg', 'image/jpeg', 1157247, '/static/share/image/2020-04-18/upload-2020-04-18 14-49-07-f8871ecfb1a77d96f26bbdebfda61d84.jpg', 'n', '2020-04-18 14:49:07');
INSERT INTO `xq_image` VALUES (4, 4, NULL, NULL, NULL, 'upload-2020-04-18 14-59-56-afb1aa99e7aeae75aeacd22e810e1d3c.png', 'image/png', 691204, '/static/share/image/2020-04-18/upload-2020-04-18 14-59-56-afb1aa99e7aeae75aeacd22e810e1d3c.png', 'n', '2020-04-18 14:59:56');
INSERT INTO `xq_image` VALUES (5, 4, NULL, NULL, NULL, 'upload-2020-04-18 14-59-56-03d3777ce1fbb1901df0629e1608a6f1.png', 'image/png', 762792, '/static/share/image/2020-04-18/upload-2020-04-18 14-59-56-03d3777ce1fbb1901df0629e1608a6f1.png', 'n', '2020-04-18 14:59:56');
INSERT INTO `xq_image` VALUES (6, 4, NULL, NULL, NULL, 'upload-2020-04-18 14-59-56-88a2f670e6241eacb5714c05b426fbce.jpg', 'image/jpeg', 1142921, '/static/share/image/2020-04-18/upload-2020-04-18 14-59-56-88a2f670e6241eacb5714c05b426fbce.jpg', 'n', '2020-04-18 14:59:56');

-- ----------------------------
-- Table structure for xq_image_assoc_subject
-- ----------------------------
DROP TABLE IF EXISTS `xq_image_assoc_subject`;
CREATE TABLE `xq_image_assoc_subject`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `image_subject_id` int(11) NULL DEFAULT NULL COMMENT 'xq_image_subject.id',
  `desc` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `attr` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'json:其他属性',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '图片专题关联主体表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for xq_image_subject
-- ----------------------------
DROP TABLE IF EXISTS `xq_image_subject`;
CREATE TABLE `xq_image_subject`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '专题名称',
  `user_type` enum('admin','user') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'user' COMMENT '用户类型',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户id，xq_admin_user.id or xq_user.id',
  `module_id` int(11) NULL DEFAULT NULL COMMENT 'xq_module.id 模块id',
  `category_id` int(11) NULL DEFAULT NULL COMMENT 'xq_category.id，分类 id',
  `type` enum('pro','misc') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类别：专题、 杂类',
  `subject_id` int(11) NULL DEFAULT NULL COMMENT 'xq_image_subject.id',
  `tag` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标签，json字段',
  `thumb` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '封面',
  `desc` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `sort` smallint(6) NULL DEFAULT 50 COMMENT '权重',
  `count` int(11) NULL DEFAULT 0 COMMENT '浏览次数',
  `praises_count` int(11) NULL DEFAULT 0 COMMENT '获赞次数',
  `status` tinyint(4) NULL DEFAULT 1 COMMENT '审核状态：1-待审核 2-审核中 3-通过',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `module_id`(`module_id`) USING BTREE,
  INDEX `category_id`(`category_id`) USING BTREE,
  INDEX `type`(`type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '图片专题表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xq_image_subject
-- ----------------------------
INSERT INTO `xq_image_subject` VALUES (2, '徐cake', 'admin', 1, 1, 3, 'pro', 1, '[\"游戏\",\"美女\",\"萝莉\",\"正太\",\"爆乳\",\"雪肌白嫩\"]', '/static/share/image/2020-04-18/upload-2020-04-18 14-48-29-369a53d57a23a3e52ff5e9bc243a2ba7.jpg', 'null', 50, 0, 0, 3, '2020-04-18 14:48:28');
INSERT INTO `xq_image_subject` VALUES (4, '测试', 'admin', 1, 1, 3, 'pro', 1, '[\"美女\",\"萝莉\",\"正太\",\"爆乳\",\"雪肌白嫩\",\"游戏\"]', '/static/share/image/2020-04-18/upload-2020-04-18 14-59-55-459738ceae685cf9272770d89b296cd5.jpg', NULL, 50, 0, 0, 3, '2020-04-18 14:59:55');

-- ----------------------------
-- Table structure for xq_image_subject_comment
-- ----------------------------
DROP TABLE IF EXISTS `xq_image_subject_comment`;
CREATE TABLE `xq_image_subject_comment`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '内容',
  `image_subject_id` int(11) NULL DEFAULT NULL COMMENT 'xq_image_subject.id',
  `user_id` int(11) NULL DEFAULT NULL COMMENT 'xq_user.id 评论者',
  `pid` int(11) NULL DEFAULT NULL COMMENT 'xq_image_subject_comment.id 评论哪一条内容',
  `hot` int(11) NULL DEFAULT 0 COMMENT '热度',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '图片专题评论表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xq_image_subject_comment
-- ----------------------------
INSERT INTO `xq_image_subject_comment` VALUES (1, 'hahah\n', 4, 1, NULL, 0, '2020-04-18 15:01:03');
INSERT INTO `xq_image_subject_comment` VALUES (2, 'aoao', 4, 1, NULL, 0, '2020-04-18 15:01:07');
INSERT INTO `xq_image_subject_comment` VALUES (3, 'oneone', 4, 1, 1, 0, '2020-04-18 15:01:25');
INSERT INTO `xq_image_subject_comment` VALUES (4, 'twotwo', 4, 1, 1, 0, '2020-04-18 15:01:32');

-- ----------------------------
-- Table structure for xq_image_subject_comment_image
-- ----------------------------
DROP TABLE IF EXISTS `xq_image_subject_comment_image`;
CREATE TABLE `xq_image_subject_comment_image`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image_subject_comment_id` int(11) NULL DEFAULT NULL COMMENT 'xq_image_subject_comment.id',
  `alt` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '替换内容',
  `filename` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件名称',
  `mime` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件 mime 类型',
  `size` int(11) NULL DEFAULT NULL COMMENT '文件大小：字节',
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '相对路径',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '图片专题评论图片表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for xq_module
-- ----------------------------
DROP TABLE IF EXISTS `xq_module`;
CREATE TABLE `xq_module`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '模块名称',
  `desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `sort` smallint(6) NULL DEFAULT NULL COMMENT '权重',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统模块表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xq_module
-- ----------------------------
INSERT INTO `xq_module` VALUES (1, '图片', NULL, 50, '2020-04-18 14:31:20');
INSERT INTO `xq_module` VALUES (2, '视频', NULL, 50, '2020-04-18 14:31:26');
INSERT INTO `xq_module` VALUES (3, '文章', NULL, 50, '2020-04-18 14:31:39');

-- ----------------------------
-- Table structure for xq_privilege
-- ----------------------------
DROP TABLE IF EXISTS `xq_privilege`;
CREATE TABLE `xq_privilege`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NULL DEFAULT NULL COMMENT 'xq_group.id',
  `privilege_id` int(11) NULL DEFAULT NULL COMMENT 'xq_privilege.id',
  `enumerable` enum('y','n') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'y' COMMENT '是否可枚举权限',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `group_id`(`group_id`, `privilege_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for xq_subject
-- ----------------------------
DROP TABLE IF EXISTS `xq_subject`;
CREATE TABLE `xq_subject`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `desc` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `thumb` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '封面',
  `attr` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'json:其他属性',
  `sort` smallint(6) NULL DEFAULT 50 COMMENT '权重',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '专题表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xq_subject
-- ----------------------------
INSERT INTO `xq_subject` VALUES (1, 'running', 'null', '/static/share/image/2020-04-18/upload-2020-04-18 14-45-25-369a53d57a23a3e52ff5e9bc243a2ba7.jpg', '{\"罩杯\":\"H\",\"颜值\":\"萝莉\",\"身材\":\"S\"}', 50, '2020-04-18 14:35:26');

-- ----------------------------
-- Table structure for xq_tag
-- ----------------------------
DROP TABLE IF EXISTS `xq_tag`;
CREATE TABLE `xq_tag`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标签名称',
  `sort` smallint(6) NULL DEFAULT NULL COMMENT '权重',
  `count` int(11) NULL DEFAULT 0 COMMENT '使用次数',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '标签表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xq_tag
-- ----------------------------
INSERT INTO `xq_tag` VALUES (1, '游戏', 50, 6, '2020-04-18 14:32:33');
INSERT INTO `xq_tag` VALUES (2, '美女', 50, 6, '2020-04-18 14:32:38');
INSERT INTO `xq_tag` VALUES (3, '萝莉', 50, 6, '2020-04-18 14:32:52');
INSERT INTO `xq_tag` VALUES (4, '正太', 50, 6, '2020-04-18 14:32:56');
INSERT INTO `xq_tag` VALUES (5, '爆乳', 50, 6, '2020-04-18 14:46:30');
INSERT INTO `xq_tag` VALUES (6, '雪肌白嫩', 50, 6, '2020-04-18 14:46:44');

-- ----------------------------
-- Table structure for xq_token
-- ----------------------------
DROP TABLE IF EXISTS `xq_token`;
CREATE TABLE `xq_token`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_type` enum('admin','user') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'user' COMMENT '用户类型：admin-后台用户 user-普通用户',
  `user_id` int(11) NULL DEFAULT NULL COMMENT 'xq_admin_user.id or xq_user.id',
  `token` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'token',
  `expire` datetime(0) NOT NULL COMMENT '过期时间',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_type`(`user_type`, `token`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户登陆状态表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xq_token
-- ----------------------------
INSERT INTO `xq_token` VALUES (1, 'admin', 1, '1W08lZ6LS0h0u8Z2D95GYAVt8xg31yriyAoCiVLhUhtRNpkvcp0YB764is4g9G9Qavxy75aLSGbyxUGErtxoiiYPD48Zy8i3AbrEUlAFkTVqvK64fFda8SNxop3DvRRcg5jKuQTHpxQ2wpJRdwzx0zLbuPxEtyUOoJksqUiPiUoje6L1VM9GO5gexc3RZiuylpdwu1czYehGFx7EVq0iQzimWwVY1Sng3AO2ijByapkl5t6nfjg4uOuQDG9NxKfHL7uVSw9f49VtMQCNcVGVNE5mbL1pPs9W6IC2YjBOGm0g0Aqsc3sAKaa9ZfZdNza708nrxPjB8kronyg', '2020-05-18 14:27:34', '2020-04-18 14:27:34');
INSERT INTO `xq_token` VALUES (2, 'user', 1, 'B897Rsh1EJLi8nPNT2ugZZwhWYsEet2pzNplGbRwPmqMpuvO0Rss7ZvaDMKtf8knyklbneIhDze5yGsC8N2h4IpiBF2WTTUqThRoCXMzLTm54ZiIQJkYrBqdvRp5voJ3d7lwrXqDaAEFnKO3dZ5WVpH2tcoH7TAB3cWw7X1KuO0axcjEFO4jKdlInbRKh7CNZbOju48ZbR2yE8o2XaCqAbKM8vAR8YxgPpCDBDee7BAsQ2r3Nli9VD6h4Z5FebcKO7mKCEH11f6LVqqS1t848z32AH3o39K6K1usI8eE0yqdmyMJuAd20ymdGYd5tp5J9hYvexN0E7g', '2020-05-18 14:56:21', '2020-04-18 14:56:21');

-- ----------------------------
-- Table structure for xq_user
-- ----------------------------
DROP TABLE IF EXISTS `xq_user`;
CREATE TABLE `xq_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '用户名',
  `password` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '密码',
  `sex` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '性别',
  `birthday` date NULL DEFAULT NULL COMMENT '生日',
  `avatar` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '头像',
  `token` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '用户登录后 token',
  `token_expire` datetime(0) NULL DEFAULT NULL COMMENT 'token 过期时间',
  `is_delete` enum('y','n') CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT 'n' COMMENT '是否被删除',
  `last_time` datetime(0) NULL DEFAULT NULL COMMENT '最近登录时间',
  `last_ip` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '最近登录ip',
  `province_id` int(11) NULL DEFAULT NULL COMMENT '省份',
  `city_id` int(11) NULL DEFAULT NULL COMMENT '城市',
  `area_id` int(11) NULL DEFAULT NULL COMMENT '区域',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '具体地址',
  `is_lock` enum('y','n') CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT 'n' COMMENT '是否锁定',
  `lock_time` datetime(0) NULL DEFAULT NULL COMMENT '锁定时间',
  `lock_expire` datetime(0) NULL DEFAULT NULL COMMENT '锁定过期时间',
  `phone` int(11) NULL DEFAULT NULL COMMENT '手机',
  `email` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '电子邮件',
  `group_id` int(11) NULL DEFAULT NULL COMMENT 'xq_group.id',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '注册时间',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '普通-用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xq_user
-- ----------------------------
INSERT INTO `xq_user` VALUES (1, 'yueshu', '$2y$10$AScYA/i5EzNXIVhwY8DxE.Bvs3y0B4TfFhVlJRcq5nD5A5HkHmbg2', 'female', '2020-04-18', '/static/share/image/2020-04-18/upload-2020-04-18 14-50-25-369a53d57a23a3e52ff5e9bc243a2ba7.jpg', NULL, NULL, 'n', '2020-04-18 14:56:21', '127.0.0.1', NULL, NULL, NULL, NULL, 'n', NULL, NULL, NULL, NULL, NULL, '2020-04-18 14:50:25', '2020-04-18 14:56:21');

SET FOREIGN_KEY_CHECKS = 1;
