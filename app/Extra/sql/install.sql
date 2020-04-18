-- 系统用户表
drop table if exists `xq_module`;
create table if not exists `xq_module` (
  id int primary key auto_increment not null ,
  name char(255) comment '模块名称' ,
  `desc` varchar(255) comment '描述' ,
  sort smallint comment '权重' ,
  create_time datetime default current_timestamp comment '创建时间'
) engine=innodb default charset=utf8 comment='系统模块表';


drop table if exists `xq_tag`;
create table if not exists `xq_tag` (
  id int auto_increment not null ,
  name char(255) comment '标签名称' ,
  sort smallint comment '权重' ,
  `count` int default 0 comment '使用次数' ,
  create_time datetime default current_timestamp comment '创建时间' ,
  primary key (id) ,
  unique key (name)
) engine=innodb default charset=utf8 comment='标签表';

drop table if exists `xq_category`;
create table if not exists `xq_category` (
  id int auto_increment not null ,
  name char(255) comment '分类名称' ,
  `desc` varchar(255) comment '分类描述' ,
  pid int comment '上级id' ,
  sort smallint default 50 comment '权重' ,
  disabled enum('y' , 'n') default 'n' comment '是否被禁用' ,
  `system` enum('y' , 'n') default 'n' comment '系统内置' ,
  create_time datetime default current_timestamp comment '创建时间' ,
  primary key(id) ,
  unique key(name , pid)
) engine=innodb default charset=utf8 comment='分类表';

drop table if exists `xq_subject`;
create table if not exists `xq_subject` (
  id int auto_increment not null ,
  name varchar(255) comment '名称' ,
  `desc` varchar(500) comment '描述' ,
  thumb varchar(255) comment '封面' ,
  attr text comment 'json:其他属性' ,
  sort smallint default 50 comment '权重' ,
  create_time datetime default current_timestamp ,
  primary key (id)
) engine=innodb default charset=utf8 comment='专题表';


-- 授权表
drop table if exists `xq_client`;
create table if not exists `xq_client` (
	id int auto_increment not null ,
	`user_id` int comment 'xq_user.id' ,
	`name` varchar(500) comment '应用名称' ,
	`desc` varchar(500) comment '应用描述' ,
	url varchar(500) comment '应用链接' ,
	redirect varchar(500) comment '应用认证通过后，携带授权码跳转的 url' ,
	secret varchar(500) comment '客户端密钥' ,
	scope int comment '' ,
	is_system enum('y' , 'n') default 'n' comment '是否平台自有客户端' ,
	status enum('wait', 'ing' , 'fail' , 'pass') default 'wait' comment '审核状态：wait-待审核 ing-审核中 fail-审核不通过 pass-审核通过' ,
	create_time datetime default current_timestamp ,
	primary key (id)
) engine=innodb default charset=utf8 comment='授权客户端表';

drop table if exists `xq_client_privilege`;
create table if not exists `xq_client_privilege` (
  id int auto_increment not null ,
  client_id int comment 'xq_client.id' ,
  privilege_id int comment 'xq_privilege.id' ,
  primary key (id) ,
  unique key (client_id , privilege_id)
) engine=innodb default charset=utf8 comment='客户端申请的权限表';

drop table if exists `xq_auth_code`;
create table if not exists `xq_auth_code` (
	id int auto_increment not null ,
	client_id int comment 'xq_client.id' ,
	code varchar(500) comment '授权码' ,
	expire datetime comment '过期时间' ,
	used enum('y' , 'n') default 'n' comment '是否被使用过: 0-否，1-是' ,
	create_time datetime default current_timestamp ,
	primary key (id)
) engine=innodb default charset=utf8 comment='授权码';

drop table if exists `xq_auth_token`;
create table if not exists `xq_auth_token` (
	id int auto_increment not null ,
	client_id int comment 'xq_client.id' ,
	access_token varchar(500) comment 'access token' ,
	refresh_token varchar(500) comment 'refresh token' ,
	access_token_expire datetime comment '过期时间' ,
	scope int default null comment '权限范围，对应 xq_group.id' ,
	permanent enum('y' , 'n') default 'n' comment 'token 是否永久有效（仅用于平台系统开发）' ,
	create_time datetime default current_timestamp ,
	primary key (id) ,
	unique key (client_id)
) engine=innodb default charset=utf8 comment='auth token';

-- 图片 表设计
drop table if exists `xq_image_subject`;
create table if not exists `xq_image_subject` (
  id int auto_increment not null ,
  name char(255) comment '专题名称' ,
  user_type enum('admin' , 'user') default 'user' comment '用户类型' ,
  user_id int comment '用户id，xq_admin_user.id or xq_user.id' ,
  module_id int comment 'xq_module.id 模块id' ,
  category_id int comment 'xq_category.id，分类 id' ,
  type enum('pro' , 'misc') comment '类别：专题、 杂类' ,
  subject_id int comment 'xq_image_subject.id' ,
  tag varchar(255) comment '标签，json字段' ,
  thumb varchar(255) comment '封面' ,
  `desc` varchar(500) comment '描述' ,
  sort smallint default 50 comment '权重' ,
  `count` int default 0 comment '浏览次数' ,
  praises_count int default 0 comment '获赞次数' ,
  status tinyint default 1 comment '审核状态：1-待审核 2-审核中 3-通过' ,
  create_time datetime default current_timestamp comment '创建时间' ,
  primary key (id) ,
  key (module_id) ,
  key (category_id) ,
  key (type)
) engine=innodb default charset=utf8 comment='图片专题表';

drop table if exists `xq_image`;
create table if not exists `xq_image` (
  id int auto_increment not null ,
  image_subject_id int comment 'xq_image_subject.id' ,
  name varchar(255) comment '图片名称' ,
  `desc` varchar(255) comment '图片描述' ,
  alt varchar(255) comment '替换内容' ,
  filename varchar(255) comment '文件名称' ,
  mime char(255) comment '文件 mime 类型' ,
  `size` int comment '文件大小：字节' ,
  path varchar(255) comment '相对路径' ,
  test enum('y' , 'n') default 'n' comment '是否测试图片，部署时可删除' ,
  create_time datetime default current_timestamp comment '创建时间' ,
  primary key (id)
) engine=innodb default charset=utf8 comment='专题内子图片表';

drop table if exists `xq_image_subject_comment` ;
create table if not exists `xq_image_subject_comment` (
  id int auto_increment not null ,
  content varchar(500) comment '内容' ,
  image_subject_id int comment 'xq_image_subject.id' ,
  user_id int comment 'xq_user.id 评论者' ,
  pid int comment 'xq_image_subject_comment.id 评论哪一条内容' ,
  hot int default 0 comment '热度' ,
  create_time datetime default current_timestamp ,
  primary key (id)
) engine = innodb character set = utf8mb4 collate = utf8mb4_bin comment='图片专题评论表';

drop table if exists `xq_image_subject_comment_image`;
create table if not exists `xq_image_subject_comment_image` (
  id int auto_increment not null ,
  image_subject_comment_id int comment 'xq_image_subject_comment.id' ,
  alt varchar(255) comment '替换内容' ,
  filename varchar(255) comment '文件名称' ,
  mime char(255) comment '文件 mime 类型' ,
  `size` int comment '文件大小：字节' ,
  path varchar(255) comment '相对路径' ,
  create_time datetime default current_timestamp ,
  primary key (id)
) engine=innodb default charset=utf8 comment '图片专题评论图片表';

-- 系统用户表
drop table if exists `xq_module`;
create table if not exists `xq_module` (
  id int primary key auto_increment not null ,
  name char(255) comment '模块名称' ,
  `desc` varchar(255) comment '描述' ,
  create_time datetime default current_timestamp comment '创建时间'
) engine=innodb default charset=utf8 comment='系统模块表';


drop table if exists `xq_tag`;
create table if not exists `xq_tag` (
  id int primary key auto_increment not null ,
  name char(255) comment '标签名称' ,
  `count` int default 0 comment '使用次数' ,
  create_time datetime default current_timestamp comment '创建时间'
) engine=innodb default charset=utf8 comment='标签表';

drop table if exists `xq_category`;
create table if not exists `xq_category` (
  id int primary key auto_increment not null ,
  name char(255) comment '分类名称' ,
  pid int comment '上级id' ,
  can_modify enum('y' , 'n') default 'y' comment '是否能够修改' ,
  create_time datetime default current_timestamp comment '创建时间'
) engine=innodb default charset=utf8 comment='分类表';

-- 授权表
drop table if exists `xq_client`;
create table if not exists `xq_client` (
	id int auto_increment not null ,
	`user_id` int comment 'xq_user.id' ,
	`name` varchar(500) comment '应用名称' ,
	`desc` varchar(500) comment '应用描述' ,
	url varchar(500) comment '应用链接' ,
	redirect varchar(500) comment '应用认证通过后，携带授权码跳转的 url' ,
	secret varchar(500) comment '客户端密钥' ,
	scope int comment '' ,
	is_system enum('y' , 'n') default 'n' comment '是否平台自有客户端' ,
	status enum('wait', 'ing' , 'fail' , 'pass') default 'wait' comment '审核状态：wait-待审核 ing-审核中 fail-审核不通过 pass-审核通过' ,
	create_time datetime default current_timestamp ,
	primary key (id)
) engine=innodb default charset=utf8 comment='授权客户端表';

drop table if exists `xq_client_privilege`;
create table if not exists `xq_client_privilege` (
  id int auto_increment not null ,
  client_id int comment 'xq_client.id' ,
  privilege_id int comment 'xq_privilege.id' ,
  primary key (id) ,
  unique key (client_id , privilege_id)
) engine=innodb default charset=utf8 comment='客户端申请的权限表';

drop table if exists `xq_auth_code`;
create table if not exists `xq_auth_code` (
	id int auto_increment not null ,
	client_id int comment 'xq_client.id' ,
	code varchar(500) comment '授权码' ,
	expire datetime comment '过期时间' ,
	used enum('y' , 'n') default 'n' comment '是否被使用过: 0-否，1-是' ,
	create_time datetime default current_timestamp ,
	primary key (id)
) engine=innodb default charset=utf8 comment='授权码';

drop table if exists `xq_auth_token`;
create table if not exists `xq_auth_token` (
	id int auto_increment not null ,
	client_id int comment 'xq_client.id' ,
	access_token varchar(500) comment 'access token' ,
	refresh_token varchar(500) comment 'refresh token' ,
	access_token_expire datetime comment '过期时间' ,
	scope int default null comment '权限范围，对应 xq_group.id' ,
	permanent enum('y' , 'n') default 'n' comment 'token 是否永久有效（仅用于平台系统开发）' ,
	create_time datetime default current_timestamp ,
	primary key (id) ,
	unique key (client_id)
) engine=innodb default charset=utf8 comment='auth token';

-- 图片 表设计
drop table if exists `xq_image_subject`;
create table if not exists `xq_image_subject` (
  id int auto_increment not null ,
  name char(255) comment '专题名称' ,
  module_id int comment 'xq_module.id 模块id' ,
  category_id int comment 'xq_category.id，分类 id' ,
  type enum('pro' , 'misc') comment '类别：专题、杂类' ,
  tag varchar(255) comment '标签，json字段' ,
  thumb varchar(255) comment '封面' ,
  `desc` varchar(500) comment '描述' ,
  create_time datetime default current_timestamp comment '创建时间' ,
  primary key (id) ,
  key (module_id) ,
  key (category_id) ,
  key (type)
) engine=innodb default charset=utf8 comment='图片专题表';

drop table if exists `xq_image_assoc_subject`;
create table if not exists `xq_image_assoc_subject` (
  id int auto_increment not null ,
  name varchar(255) comment '名称' ,
  image_subject_id int comment 'xq_image_subject.id' ,
  `desc` varchar(500) comment '描述' ,
  avatar varchar(255) comment '头像' ,
  attr text comment 'json:其他属性' ,
  create_time datetime default current_timestamp ,
  primary key (id)
) engine=innodb default charset=utf8 comment='图片专题关联主体表';

drop table if exists `xq_image`;
create table if not exists `xq_image` (
  id int auto_increment not null ,
  image_subject_id int comment 'xq_image_subject.id' ,
  name varchar(255) comment '图片名称' ,
  `desc` varchar(255) comment '图片描述' ,
  alt varchar(255) comment '替换内容' ,
  filename varchar(255) comment '文件名称' ,
  mime char(255) comment '文件 mime 类型' ,
  `size` int comment '文件大小：字节' ,
  path varchar(255) comment '相对路径' ,
  test enum('y' , 'n') default 'n' comment '是否测试图片，部署时可删除' ,
  create_time datetime default current_timestamp comment '创建时间' ,
  primary key (id)
) engine=innodb default charset=utf8 comment='专题内子图片表';

drop table if exists `xq_image_subject_comment` ;
create table if not exists `xq_image_subject_comment` (
  id int auto_increment not null ,
  content varchar(500) comment '内容' ,
  image_subject_id int comment 'xq_image_subject.id' ,
  user_id int comment 'xq_user.id' ,
  create_time datetime default current_timestamp ,
  primary key (id)
) comment='专题评论表';

drop table if exists `xq_image_subject_comment_image`;
create table if not exists `xq_image_subject_comment_image` (
  id int auto_increment not null ,
  image_subject_comment_id int comment 'xq_image_subject_comment.id' ,
  alt varchar(255) comment '替换内容' ,
  filename varchar(255) comment '文件名称' ,
  mime char(255) comment '文件 mime 类型' ,
  `size` int comment '文件大小：字节' ,
  path varchar(255) comment '相对路径' ,
  create_time datetime default current_timestamp ,
  primary key (id)
) engine=innodb default charset=utf8 comment '图片专区评论图片表';

-- 系统用户表
drop table if exists `xq_module`;
create table if not exists `xq_module` (
  id int primary key auto_increment not null ,
  name char(255) comment '模块名称' ,
  `desc` varchar(255) comment '描述' ,
  create_time datetime default current_timestamp comment '创建时间'
) engine=innodb default charset=utf8 comment='系统模块表';


drop table if exists `xq_tag`;
create table if not exists `xq_tag` (
  id int primary key auto_increment not null ,
  name char(255) comment '标签名称' ,
  `count` int default 0 comment '使用次数' ,
  create_time datetime default current_timestamp comment '创建时间'
) engine=innodb default charset=utf8 comment='标签表';

drop table if exists `xq_category`;
create table if not exists `xq_category` (
  id int primary key auto_increment not null ,
  name char(255) comment '分类名称' ,
  pid int comment '上级id' ,
  can_modify enum('y' , 'n') default 'y' comment '是否能够修改' ,
  create_time datetime default current_timestamp comment '创建时间'
) engine=innodb default charset=utf8 comment='分类表';

-- 华丽的分割线 --

-- 授权表
drop table if exists `xq_client`;
create table if not exists `xq_client` (
	id int auto_increment not null ,
	`user_id` int comment 'xq_user.id' ,
	`name` varchar(500) comment '应用名称' ,
	`desc` varchar(500) comment '应用描述' ,
	url varchar(500) comment '应用链接' ,
	redirect varchar(500) comment '应用认证通过后，携带授权码跳转的 url' ,
	secret varchar(500) comment '客户端密钥' ,
	scope int comment '' ,
	is_system enum('y' , 'n') default 'n' comment '是否平台自有客户端' ,
	status enum('wait', 'ing' , 'fail' , 'pass') default 'wait' comment '审核状态：wait-待审核 ing-审核中 fail-审核不通过 pass-审核通过' ,
	create_time datetime default current_timestamp ,
	primary key (id)
) engine=innodb default charset=utf8 comment='授权客户端表';

drop table if exists `xq_client_privilege`;
create table if not exists `xq_client_privilege` (
  id int auto_increment not null ,
  client_id int comment 'xq_client.id' ,
  privilege_id int comment 'xq_privilege.id' ,
  primary key (id) ,
  unique key (client_id , privilege_id)
) engine=innodb default charset=utf8 comment='客户端申请的权限表';

drop table if exists `xq_auth_code`;
create table if not exists `xq_auth_code` (
	id int auto_increment not null ,
	client_id int comment 'xq_client.id' ,
	code varchar(500) comment '授权码' ,
	expire datetime comment '过期时间' ,
	used enum('y' , 'n') default 'n' comment '是否被使用过: 0-否，1-是' ,
	create_time datetime default current_timestamp ,
	primary key (id)
) engine=innodb default charset=utf8 comment='授权码';

drop table if exists `xq_auth_token`;
create table if not exists `xq_auth_token` (
	id int auto_increment not null ,
	client_id int comment 'xq_client.id' ,
	access_token varchar(500) comment 'access token' ,
	refresh_token varchar(500) comment 'refresh token' ,
	access_token_expire datetime comment '过期时间' ,
	scope int default null comment '权限范围，对应 xq_group.id' ,
	permanent enum('y' , 'n') default 'n' comment 'token 是否永久有效（仅用于平台系统开发）' ,
	create_time datetime default current_timestamp ,
	primary key (id) ,
	unique key (client_id)
) engine=innodb default charset=utf8 comment='auth token';

-- 华丽的分割线 --

-- 图片 表设计
drop table if exists `xq_image_subject`;
create table if not exists `xq_image_subject` (
  id int auto_increment not null ,
  name char(255) comment '专题名称' ,
  module_id int comment 'xq_module.id 模块id' ,
  category_id int comment 'xq_category.id，分类 id' ,
  type enum('pro' , 'misc') comment '类别：专题、杂类' ,
  tag varchar(255) comment '标签，json字段' ,
  thumb varchar(255) comment '封面' ,
  `desc` varchar(500) comment '描述' ,
  create_time datetime default current_timestamp comment '创建时间' ,
  primary key (id) ,
  key (module_id) ,
  key (category_id) ,
  key (type)
) engine=innodb default charset=utf8 comment='图片专题表';

drop table if exists `xq_image_assoc_subject`;
create table if not exists `xq_image_assoc_subject` (
  id int auto_increment not null ,
  name varchar(255) comment '名称' ,
  image_subject_id int comment 'xq_image_subject.id' ,
  `desc` varchar(500) comment '描述' ,
  avatar varchar(255) comment '头像' ,
  attr text comment 'json:其他属性' ,
  create_time datetime default current_timestamp ,
  primary key (id)
) engine=innodb default charset=utf8 comment='图片专题关联主体表';

drop table if exists `xq_image`;
create table if not exists `xq_image` (
  id int auto_increment not null ,
  image_subject_id int comment 'xq_image_subject.id' ,
  name varchar(255) comment '图片名称' ,
  `desc` varchar(255) comment '图片描述' ,
  alt varchar(255) comment '替换内容' ,
  filename varchar(255) comment '文件名称' ,
  mime char(255) comment '文件 mime 类型' ,
  `size` int comment '文件大小：字节' ,
  path varchar(255) comment '相对路径' ,
  test enum('y' , 'n') default 'n' comment '是否测试图片，部署时可删除' ,
  create_time datetime default current_timestamp comment '创建时间' ,
  primary key (id)
) engine=innodb default charset=utf8 comment='专题内子图片表';

drop table if exists `xq_image_subject_comment` ;
create table if not exists `xq_image_subject_comment` (
  id int auto_increment not null ,
  content varchar(500) comment '内容' ,
  image_subject_id int comment 'xq_image_subject.id' ,
  user_id int comment 'xq_user.id' ,
  create_time datetime default current_timestamp ,
  primary key (id)
) comment='专题评论表';

drop table if exists `xq_image_subject_comment_image`;
create table if not exists `xq_image_subject_comment_image` (
  id int auto_increment not null ,
  image_subject_comment_id int comment 'xq_image_subject_comment.id' ,
  alt varchar(255) comment '替换内容' ,
  filename varchar(255) comment '文件名称' ,
  mime char(255) comment '文件 mime 类型' ,
  `size` int comment '文件大小：字节' ,
  path varchar(255) comment '相对路径' ,
  create_time datetime default current_timestamp ,
  primary key (id)
) engine=innodb default charset=utf8 comment '图片专区评论图片表';

-- 华丽的分割线 --

-- 系统用户表
drop table if exists `xq_module`;
create table if not exists `xq_module` (
  id int primary key auto_increment not null ,
  name char(255) comment '模块名称' ,
  `desc` varchar(255) comment '描述' ,
  create_time datetime default current_timestamp comment '创建时间'
) engine=innodb default charset=utf8 comment='系统模块表';


drop table if exists `xq_tag`;
create table if not exists `xq_tag` (
  id int primary key auto_increment not null ,
  name char(255) comment '标签名称' ,
  `count` int default 0 comment '使用次数' ,
  create_time datetime default current_timestamp comment '创建时间'
) engine=innodb default charset=utf8 comment='标签表';

drop table if exists `xq_category`;
create table if not exists `xq_category` (
  id int primary key auto_increment not null ,
  name char(255) comment '分类名称' ,
  pid int comment '上级id' ,
  can_modify enum('y' , 'n') default 'y' comment '是否能够修改' ,
  create_time datetime default current_timestamp comment '创建时间'
) engine=innodb default charset=utf8 comment='分类表';
-- 华丽的分割线 --
-- 授权表
drop table if exists `xq_client`;
create table if not exists `xq_client` (
	id int auto_increment not null ,
	`user_id` int comment 'xq_user.id' ,
	`name` varchar(500) comment '应用名称' ,
	`desc` varchar(500) comment '应用描述' ,
	url varchar(500) comment '应用链接' ,
	redirect varchar(500) comment '应用认证通过后，携带授权码跳转的 url' ,
	secret varchar(500) comment '客户端密钥' ,
	scope int comment '' ,
	is_system enum('y' , 'n') default 'n' comment '是否平台自有客户端' ,
	status enum('wait', 'ing' , 'fail' , 'pass') default 'wait' comment '审核状态：wait-待审核 ing-审核中 fail-审核不通过 pass-审核通过' ,
	create_time datetime default current_timestamp ,
	primary key (id)
) engine=innodb default charset=utf8 comment='授权客户端表';

drop table if exists `xq_client_privilege`;
create table if not exists `xq_client_privilege` (
  id int auto_increment not null ,
  client_id int comment 'xq_client.id' ,
  privilege_id int comment 'xq_privilege.id' ,
  primary key (id) ,
  unique key (client_id , privilege_id)
) engine=innodb default charset=utf8 comment='客户端申请的权限表';

drop table if exists `xq_auth_code`;
create table if not exists `xq_auth_code` (
	id int auto_increment not null ,
	client_id int comment 'xq_client.id' ,
	code varchar(500) comment '授权码' ,
	expire datetime comment '过期时间' ,
	used enum('y' , 'n') default 'n' comment '是否被使用过: 0-否，1-是' ,
	create_time datetime default current_timestamp ,
	primary key (id)
) engine=innodb default charset=utf8 comment='授权码';

drop table if exists `xq_auth_token`;
create table if not exists `xq_auth_token` (
	id int auto_increment not null ,
	client_id int comment 'xq_client.id' ,
	access_token varchar(500) comment 'access token' ,
	refresh_token varchar(500) comment 'refresh token' ,
	access_token_expire datetime comment '过期时间' ,
	scope int default null comment '权限范围，对应 xq_group.id' ,
	permanent enum('y' , 'n') default 'n' comment 'token 是否永久有效（仅用于平台系统开发）' ,
	create_time datetime default current_timestamp ,
	primary key (id) ,
	unique key (client_id)
) engine=innodb default charset=utf8 comment='auth token';
-- 华丽的分割线 --
-- 图片 表设计
drop table if exists `xq_image_subject`;
create table if not exists `xq_image_subject` (
  id int auto_increment not null ,
  name char(255) comment '专题名称' ,
  module_id int comment 'xq_module.id 模块id' ,
  category_id int comment 'xq_category.id，分类 id' ,
  type enum('pro' , 'misc') comment '类别：专题、杂类' ,
  tag varchar(255) comment '标签，json字段' ,
  thumb varchar(255) comment '封面' ,
  `desc` varchar(500) comment '描述' ,
  create_time datetime default current_timestamp comment '创建时间' ,
  primary key (id) ,
  key (module_id) ,
  key (category_id) ,
  key (type)
) engine=innodb default charset=utf8 comment='图片专题表';

drop table if exists `xq_image_assoc_subject`;
create table if not exists `xq_image_assoc_subject` (
  id int auto_increment not null ,
  name varchar(255) comment '名称' ,
  image_subject_id int comment 'xq_image_subject.id' ,
  `desc` varchar(500) comment '描述' ,
  avatar varchar(255) comment '头像' ,
  attr text comment 'json:其他属性' ,
  create_time datetime default current_timestamp ,
  primary key (id)
) engine=innodb default charset=utf8 comment='图片专题关联主体表';

drop table if exists `xq_image`;
create table if not exists `xq_image` (
  id int auto_increment not null ,
  image_subject_id int comment 'xq_image_subject.id' ,
  name varchar(255) comment '图片名称' ,
  `desc` varchar(255) comment '图片描述' ,
  alt varchar(255) comment '替换内容' ,
  filename varchar(255) comment '文件名称' ,
  mime char(255) comment '文件 mime 类型' ,
  `size` int comment '文件大小：字节' ,
  path varchar(255) comment '相对路径' ,
  test enum('y' , 'n') default 'n' comment '是否测试图片，部署时可删除' ,
  create_time datetime default current_timestamp comment '创建时间' ,
  primary key (id)
) engine=innodb default charset=utf8 comment='专题内子图片表';

drop table if exists `xq_image_subject_comment` ;
create table if not exists `xq_image_subject_comment` (
  id int auto_increment not null ,
  content varchar(500) comment '内容' ,
  image_subject_id int comment 'xq_image_subject.id' ,
  user_id int comment 'xq_user.id' ,
  create_time datetime default current_timestamp ,
  primary key (id)
) comment='专题评论表';

drop table if exists `xq_image_subject_comment_image`;
create table if not exists `xq_image_subject_comment_image` (
  id int auto_increment not null ,
  image_subject_comment_id int comment 'xq_image_subject_comment.id' ,
  alt varchar(255) comment '替换内容' ,
  filename varchar(255) comment '文件名称' ,
  mime char(255) comment '文件 mime 类型' ,
  `size` int comment '文件大小：字节' ,
  path varchar(255) comment '相对路径' ,
  create_time datetime default current_timestamp ,
  primary key (id)
) engine=innodb default charset=utf8 comment '图片专区评论图片表';
-- 华丽的分割线 --
-- 系统用户表
drop table if exists `xq_module`;
create table if not exists `xq_module` (
  id int primary key auto_increment not null ,
  name char(255) comment '模块名称' ,
  `desc` varchar(255) comment '描述' ,
  create_time datetime default current_timestamp comment '创建时间'
) engine=innodb default charset=utf8 comment='系统模块表';


drop table if exists `xq_tag`;
create table if not exists `xq_tag` (
  id int primary key auto_increment not null ,
  name char(255) comment '标签名称' ,
  `count` int default 0 comment '使用次数' ,
  create_time datetime default current_timestamp comment '创建时间'
) engine=innodb default charset=utf8 comment='标签表';

drop table if exists `xq_category`;
create table if not exists `xq_category` (
  id int primary key auto_increment not null ,
  name char(255) comment '分类名称' ,
  pid int comment '上级id' ,
  can_modify enum('y' , 'n') default 'y' comment '是否能够修改' ,
  create_time datetime default current_timestamp comment '创建时间'
) engine=innodb default charset=utf8 comment='分类表';
-- 华丽的分割线 --
-- 授权表
drop table if exists `xq_client`;
create table if not exists `xq_client` (
	id int auto_increment not null ,
	`user_id` int comment 'xq_user.id' ,
	`name` varchar(500) comment '应用名称' ,
	`desc` varchar(500) comment '应用描述' ,
	url varchar(500) comment '应用链接' ,
	redirect varchar(500) comment '应用认证通过后，携带授权码跳转的 url' ,
	secret varchar(500) comment '客户端密钥' ,
	scope int comment '' ,
	is_system enum('y' , 'n') default 'n' comment '是否平台自有客户端' ,
	status enum('wait', 'ing' , 'fail' , 'pass') default 'wait' comment '审核状态：wait-待审核 ing-审核中 fail-审核不通过 pass-审核通过' ,
	create_time datetime default current_timestamp ,
	primary key (id)
) engine=innodb default charset=utf8 comment='授权客户端表';

drop table if exists `xq_client_privilege`;
create table if not exists `xq_client_privilege` (
  id int auto_increment not null ,
  client_id int comment 'xq_client.id' ,
  privilege_id int comment 'xq_privilege.id' ,
  primary key (id) ,
  unique key (client_id , privilege_id)
) engine=innodb default charset=utf8 comment='客户端申请的权限表';

drop table if exists `xq_auth_code`;
create table if not exists `xq_auth_code` (
	id int auto_increment not null ,
	client_id int comment 'xq_client.id' ,
	code varchar(500) comment '授权码' ,
	expire datetime comment '过期时间' ,
	used enum('y' , 'n') default 'n' comment '是否被使用过: 0-否，1-是' ,
	create_time datetime default current_timestamp ,
	primary key (id)
) engine=innodb default charset=utf8 comment='授权码';

drop table if exists `xq_auth_token`;
create table if not exists `xq_auth_token` (
	id int auto_increment not null ,
	client_id int comment 'xq_client.id' ,
	access_token varchar(500) comment 'access token' ,
	refresh_token varchar(500) comment 'refresh token' ,
	access_token_expire datetime comment '过期时间' ,
	scope int default null comment '权限范围，对应 xq_group.id' ,
	permanent enum('y' , 'n') default 'n' comment 'token 是否永久有效（仅用于平台系统开发）' ,
	create_time datetime default current_timestamp ,
	primary key (id) ,
	unique key (client_id)
) engine=innodb default charset=utf8 comment='auth token';
-- 华丽的分割线 --
-- 图片 表设计
drop table if exists `xq_image_subject`;
create table if not exists `xq_image_subject` (
  id int auto_increment not null ,
  name char(255) comment '专题名称' ,
  module_id int comment 'xq_module.id 模块id' ,
  category_id int comment 'xq_category.id，分类 id' ,
  type enum('pro' , 'misc') comment '类别：专题、杂类' ,
  tag varchar(255) comment '标签，json字段' ,
  thumb varchar(255) comment '封面' ,
  `desc` varchar(500) comment '描述' ,
  create_time datetime default current_timestamp comment '创建时间' ,
  primary key (id) ,
  key (module_id) ,
  key (category_id) ,
  key (type)
) engine=innodb default charset=utf8 comment='图片专题表';

drop table if exists `xq_image_assoc_subject`;
create table if not exists `xq_image_assoc_subject` (
  id int auto_increment not null ,
  name varchar(255) comment '名称' ,
  image_subject_id int comment 'xq_image_subject.id' ,
  `desc` varchar(500) comment '描述' ,
  avatar varchar(255) comment '头像' ,
  attr text comment 'json:其他属性' ,
  create_time datetime default current_timestamp ,
  primary key (id)
) engine=innodb default charset=utf8 comment='图片专题关联主体表';

drop table if exists `xq_image`;
create table if not exists `xq_image` (
  id int auto_increment not null ,
  image_subject_id int comment 'xq_image_subject.id' ,
  name varchar(255) comment '图片名称' ,
  `desc` varchar(255) comment '图片描述' ,
  alt varchar(255) comment '替换内容' ,
  filename varchar(255) comment '文件名称' ,
  mime char(255) comment '文件 mime 类型' ,
  `size` int comment '文件大小：字节' ,
  path varchar(255) comment '相对路径' ,
  test enum('y' , 'n') default 'n' comment '是否测试图片，部署时可删除' ,
  create_time datetime default current_timestamp comment '创建时间' ,
  primary key (id)
) engine=innodb default charset=utf8 comment='专题内子图片表';

drop table if exists `xq_image_subject_comment` ;
create table if not exists `xq_image_subject_comment` (
  id int auto_increment not null ,
  content varchar(500) comment '内容' ,
  image_subject_id int comment 'xq_image_subject.id' ,
  user_id int comment 'xq_user.id' ,
  create_time datetime default current_timestamp ,
  primary key (id)
) comment='专题评论表';

drop table if exists `xq_image_subject_comment_image`;
create table if not exists `xq_image_subject_comment_image` (
  id int auto_increment not null ,
  image_subject_comment_id int comment 'xq_image_subject_comment.id' ,
  alt varchar(255) comment '替换内容' ,
  filename varchar(255) comment '文件名称' ,
  mime char(255) comment '文件 mime 类型' ,
  `size` int comment '文件大小：字节' ,
  path varchar(255) comment '相对路径' ,
  create_time datetime default current_timestamp ,
  primary key (id)
) engine=innodb default charset=utf8 comment '图片专区评论图片表';
-- 华丽的分割线 --
-- 系统用户表
drop table if exists `xq_module`;
create table if not exists `xq_module` (
  id int primary key auto_increment not null ,
  name char(255) comment '模块名称' ,
  `desc` varchar(255) comment '描述' ,
  create_time datetime default current_timestamp comment '创建时间'
) engine=innodb default charset=utf8 comment='系统模块表';


drop table if exists `xq_tag`;
create table if not exists `xq_tag` (
  id int primary key auto_increment not null ,
  name char(255) comment '标签名称' ,
  `count` int default 0 comment '使用次数' ,
  create_time datetime default current_timestamp comment '创建时间'
) engine=innodb default charset=utf8 comment='标签表';

drop table if exists `xq_category`;
create table if not exists `xq_category` (
  id int primary key auto_increment not null ,
  name char(255) comment '分类名称' ,
  pid int comment '上级id' ,
  can_modify enum('y' , 'n') default 'y' comment '是否能够修改' ,
  create_time datetime default current_timestamp comment '创建时间'
) engine=innodb default charset=utf8 comment='分类表';
-- 华丽的分割线 --
-- 授权表
drop table if exists `xq_client`;
create table if not exists `xq_client` (
	id int auto_increment not null ,
	`user_id` int comment 'xq_user.id' ,
	`name` varchar(500) comment '应用名称' ,
	`desc` varchar(500) comment '应用描述' ,
	url varchar(500) comment '应用链接' ,
	redirect varchar(500) comment '应用认证通过后，携带授权码跳转的 url' ,
	secret varchar(500) comment '客户端密钥' ,
	scope int comment '' ,
	is_system enum('y' , 'n') default 'n' comment '是否平台自有客户端' ,
	status enum('wait', 'ing' , 'fail' , 'pass') default 'wait' comment '审核状态：wait-待审核 ing-审核中 fail-审核不通过 pass-审核通过' ,
	create_time datetime default current_timestamp ,
	primary key (id)
) engine=innodb default charset=utf8 comment='授权客户端表';

drop table if exists `xq_client_privilege`;
create table if not exists `xq_client_privilege` (
  id int auto_increment not null ,
  client_id int comment 'xq_client.id' ,
  privilege_id int comment 'xq_privilege.id' ,
  primary key (id) ,
  unique key (client_id , privilege_id)
) engine=innodb default charset=utf8 comment='客户端申请的权限表';

drop table if exists `xq_auth_code`;
create table if not exists `xq_auth_code` (
	id int auto_increment not null ,
	client_id int comment 'xq_client.id' ,
	code varchar(500) comment '授权码' ,
	expire datetime comment '过期时间' ,
	used enum('y' , 'n') default 'n' comment '是否被使用过: 0-否，1-是' ,
	create_time datetime default current_timestamp ,
	primary key (id)
) engine=innodb default charset=utf8 comment='授权码';

drop table if exists `xq_auth_token`;
create table if not exists `xq_auth_token` (
	id int auto_increment not null ,
	client_id int comment 'xq_client.id' ,
	access_token varchar(500) comment 'access token' ,
	refresh_token varchar(500) comment 'refresh token' ,
	access_token_expire datetime comment '过期时间' ,
	scope int default null comment '权限范围，对应 xq_group.id' ,
	permanent enum('y' , 'n') default 'n' comment 'token 是否永久有效（仅用于平台系统开发）' ,
	create_time datetime default current_timestamp ,
	primary key (id) ,
	unique key (client_id)
) engine=innodb default charset=utf8 comment='auth token';
-- 华丽的分割线 --
-- 图片 表设计
drop table if exists `xq_image_subject`;
create table if not exists `xq_image_subject` (
  id int auto_increment not null ,
  name char(255) comment '专题名称' ,
  module_id int comment 'xq_module.id 模块id' ,
  category_id int comment 'xq_category.id，分类 id' ,
  type enum('pro' , 'misc') comment '类别：专题、杂类' ,
  tag varchar(255) comment '标签，json字段' ,
  thumb varchar(255) comment '封面' ,
  `desc` varchar(500) comment '描述' ,
  create_time datetime default current_timestamp comment '创建时间' ,
  primary key (id) ,
  key (module_id) ,
  key (category_id) ,
  key (type)
) engine=innodb default charset=utf8 comment='图片专题表';

drop table if exists `xq_image_assoc_subject`;
create table if not exists `xq_image_assoc_subject` (
  id int auto_increment not null ,
  name varchar(255) comment '名称' ,
  image_subject_id int comment 'xq_image_subject.id' ,
  `desc` varchar(500) comment '描述' ,
  avatar varchar(255) comment '头像' ,
  attr text comment 'json:其他属性' ,
  create_time datetime default current_timestamp ,
  primary key (id)
) engine=innodb default charset=utf8 comment='图片专题关联主体表';

drop table if exists `xq_image`;
create table if not exists `xq_image` (
  id int auto_increment not null ,
  image_subject_id int comment 'xq_image_subject.id' ,
  name varchar(255) comment '图片名称' ,
  `desc` varchar(255) comment '图片描述' ,
  alt varchar(255) comment '替换内容' ,
  filename varchar(255) comment '文件名称' ,
  mime char(255) comment '文件 mime 类型' ,
  `size` int comment '文件大小：字节' ,
  path varchar(255) comment '相对路径' ,
  test enum('y' , 'n') default 'n' comment '是否测试图片，部署时可删除' ,
  create_time datetime default current_timestamp comment '创建时间' ,
  primary key (id)
) engine=innodb default charset=utf8 comment='专题内子图片表';

drop table if exists `xq_image_subject_comment` ;
create table if not exists `xq_image_subject_comment` (
  id int auto_increment not null ,
  content varchar(500) comment '内容' ,
  image_subject_id int comment 'xq_image_subject.id' ,
  user_id int comment 'xq_user.id' ,
  create_time datetime default current_timestamp ,
  primary key (id)
) comment='专题评论表';

drop table if exists `xq_image_subject_comment_image`;
create table if not exists `xq_image_subject_comment_image` (
  id int auto_increment not null ,
  image_subject_comment_id int comment 'xq_image_subject_comment.id' ,
  alt varchar(255) comment '替换内容' ,
  filename varchar(255) comment '文件名称' ,
  mime char(255) comment '文件 mime 类型' ,
  `size` int comment '文件大小：字节' ,
  path varchar(255) comment '相对路径' ,
  create_time datetime default current_timestamp ,
  primary key (id)
) engine=innodb default charset=utf8 comment '图片专区评论图片表';
-- 华丽的分割线 --

-- 华丽的分割线 --
-- 权限表

drop table if exists `xq_privilege`;
create table if not exists `xq_privilege` (
  id int auto_increment not null ,
  module char(255) comment '模块' ,
  controller char(255) comment '控制器' ,
  action char(255) comment '动作' ,
  cn char(255) comment '中文名' ,
  en char(255) comment '英文名' ,
  is_link enum('y' , 'n') default 'y' comment '是否链接' ,
  is_completed enum('y' , 'n') default 'y' comment '是否开发完成' ,
  is_disabled enum('y' , 'n') default 'n' comment '是否禁用' ,
  pid int comment '父级id' ,
  create_time datetime default current_timestamp ,
  primary key (id)
) comment '权限表';
-- 华丽的分割线 --
-- 用户区表

drop table if exists `xq_user`;
create table if not exists `xq_user` (
		id int primary key auto_increment not null ,
		username char(255) comment '用户名' ,
		password char(255) comment '密码' ,
		sex char(255) comment '性别' ,
		birthday date comment '生日' ,
		avatar varchar(500) comment '头像' ,
		token varchar(1000) comment '用户登录后 token' ,
		token_expire datetime default null comment 'token 过期时间' ,
		is_delete enum('y' , 'n') default 'n' comment '是否被删除' ,
		last_time datetime default null comment '最近登录时间' ,
		last_ip datetime default null comment '最近登录ip' ,
		province_id int comment '省份' ,
		city_id int comment '城市' ,
		area_id int comment '区域' ,
		address varchar(255) comment '具体地址' ,
		is_lock enum('y' , 'n') default 'n' comment '是否锁定' ,
		lock_time datetime comment '锁定时间' ,
		lock_expire datetime comment '锁定过期时间' ,
		phone int comment '手机' ,
		email char(255) comment '电子邮件' ,
		group_id int comment 'xq_group.id' ,
		create_time datetime default current_timestamp comment '注册时间' ,
		update_time datetime default current_timestamp on update current_timestamp comment '更新时间'
) engine=innodb default charset=utf8 comment='普通-用户表';

drop table if exists `xq_admin_user`;
create table if not exists `xq_admin_user` (
		id int primary key auto_increment not null ,
		username char(255) comment '用户名' ,
		password char(255) comment '密码' ,
		sex char(255) comment '性别' ,
		birthday date comment '生日' ,
		avatar varchar(500) comment '头像' ,
		token varchar(1000) comment '用户登录后 token' ,
		token_expire datetime default null comment 'token 过期时间' ,
		is_delete enum('y' , 'n') default 'n' comment '是否被删除' ,
		last_time datetime default null comment '最近登录时间' ,
		last_ip datetime default null comment '最近登录ip' ,
		province_id int comment '省份' ,
		city_id int comment '城市' ,
		area_id int comment '区域' ,
		address varchar(255) comment '具体地址' ,
		is_lock enum('y' , 'n') default 'n' comment '是否锁定' ,
		lock_time datetime comment '锁定时间' ,
		lock_expire datetime comment '锁定过期时间' ,
		phone int comment '手机' ,
		email char(255) comment '电子邮件' ,
		group_id int comment 'xq_group.id' ,
		create_time datetime default current_timestamp comment '注册时间' ,
		update_time datetime default current_timestamp on update current_timestamp comment '更新时间'
) engine=innodb default charset=utf8 comment='管理员-用户表';

drop table if exists `xq_admin_land_log`;
create table if not exists `xq_admin_land_log` (
  id int auto_increment not null ,
  user_id int comment '用户id' ,
  ip char(255) comment '登录ip' ,
  duration smallint comment '登录时长，单位 s' ,
  create_time datetime default current_timestamp comment '登录时间' ,
  primary key (id)
) engine=innodb default charset=utf8 comment '管理员登录表';

drop table if exists `xq_group`;
create table if not exists `xq_group` (
	id int auto_increment not null ,
	name varchar(500) comment '组名' ,
	type char(255) comment '类型：admin-后台用户组 front-前端用户组，其他待扩展' ,
	pid int comment '父级id' ,
	can_modify enum('y' , 'n') default 'y' comment '是否能够修改' ,
	create_time datetime default current_timestamp ,
	primary key (id)
) engine=innodb default charset=utf8 comment '用户组';

drop table if exists `xq_group_privilege`;
create table if not exists `xq_group_privilege` (
	id int auto_increment not null ,
	group_id int comment 'xq_group.id' ,
	privilege_id int comment 'xq_privilege.id' ,
	primary key (id) ,
	unique key (group_id , privilege_id) 
) engine=innodb default charset=utf8 comment '用户组权限表';

drop table if exists `xq_privilege`;
create table if not exists `xq_privilege` (
	id int auto_increment not null ,
	group_id int comment 'xq_group.id' ,
	privilege_id int comment 'xq_privilege.id' ,
	enumerable enum('y' , 'n') default 'y' comment '是否可枚举权限' ,
	create_time datetime default current_timestamp ,
	primary key (id) ,
	unique key (group_id , privilege_id)
) engine=innodb default charset=utf8 comment '权限表';
-- 华丽的分割线 --

-- 华丽的分割线 --
-- 权限表

drop table if exists `xq_privilege`;
create table if not exists `xq_privilege` (
  id int auto_increment not null ,
  module char(255) comment '模块' ,
  controller char(255) comment '控制器' ,
  action char(255) comment '动作' ,
  cn char(255) comment '中文名' ,
  en char(255) comment '英文名' ,
  is_link enum('y' , 'n') default 'y' comment '是否链接' ,
  is_completed enum('y' , 'n') default 'y' comment '是否开发完成' ,
  is_disabled enum('y' , 'n') default 'n' comment '是否禁用' ,
  pid int comment '父级id' ,
  create_time datetime default current_timestamp ,
  primary key (id)
) comment '权限表';
-- 华丽的分割线 --
-- 用户区表

drop table if exists `xq_user`;
create table if not exists `xq_user` (
		id int primary key auto_increment not null ,
		username char(255) comment '用户名' ,
		password char(255) comment '密码' ,
		sex char(255) comment '性别' ,
		birthday date comment '生日' ,
		avatar varchar(500) comment '头像' ,
		token varchar(1000) comment '用户登录后 token' ,
		token_expire datetime default null comment 'token 过期时间' ,
		is_delete enum('y' , 'n') default 'n' comment '是否被删除' ,
		last_time datetime default null comment '最近登录时间' ,
		last_ip datetime default null comment '最近登录ip' ,
		province_id int comment '省份' ,
		city_id int comment '城市' ,
		area_id int comment '区域' ,
		address varchar(255) comment '具体地址' ,
		is_lock enum('y' , 'n') default 'n' comment '是否锁定' ,
		lock_time datetime comment '锁定时间' ,
		lock_expire datetime comment '锁定过期时间' ,
		phone int comment '手机' ,
		email char(255) comment '电子邮件' ,
		group_id int comment 'xq_group.id' ,
		create_time datetime default current_timestamp comment '注册时间' ,
		update_time datetime default current_timestamp on update current_timestamp comment '更新时间'
) engine=innodb default charset=utf8 comment='普通-用户表';

drop table if exists `xq_admin_user`;
create table if not exists `xq_admin_user` (
		id int primary key auto_increment not null ,
		username char(255) comment '用户名' ,
		password char(255) comment '密码' ,
		sex char(255) comment '性别' ,
		birthday date comment '生日' ,
		avatar varchar(500) comment '头像' ,
		token varchar(1000) comment '用户登录后 token' ,
		token_expire datetime default null comment 'token 过期时间' ,
		is_delete enum('y' , 'n') default 'n' comment '是否被删除' ,
		last_time datetime default null comment '最近登录时间' ,
		last_ip datetime default null comment '最近登录ip' ,
		province_id int comment '省份' ,
		city_id int comment '城市' ,
		area_id int comment '区域' ,
		address varchar(255) comment '具体地址' ,
		is_lock enum('y' , 'n') default 'n' comment '是否锁定' ,
		lock_time datetime comment '锁定时间' ,
		lock_expire datetime comment '锁定过期时间' ,
		phone int comment '手机' ,
		email char(255) comment '电子邮件' ,
		group_id int comment 'xq_group.id' ,
		create_time datetime default current_timestamp comment '注册时间' ,
		update_time datetime default current_timestamp on update current_timestamp comment '更新时间'
) engine=innodb default charset=utf8 comment='管理员-用户表';

drop table if exists `xq_admin_land_log`;
create table if not exists `xq_admin_land_log` (
  id int auto_increment not null ,
  user_id int comment '用户id' ,
  ip char(255) comment '登录ip' ,
  duration smallint comment '登录时长，单位 s' ,
  create_time datetime default current_timestamp comment '登录时间' ,
  primary key (id)
) engine=innodb default charset=utf8 comment '管理员登录表';

drop table if exists `xq_group`;
create table if not exists `xq_group` (
	id int auto_increment not null ,
	name varchar(500) comment '组名' ,
	type char(255) comment '类型：admin-后台用户组 front-前端用户组，其他待扩展' ,
	pid int comment '父级id' ,
	can_modify enum('y' , 'n') default 'y' comment '是否能够修改' ,
	create_time datetime default current_timestamp ,
	primary key (id)
) engine=innodb default charset=utf8 comment '用户组';

drop table if exists `xq_group_privilege`;
create table if not exists `xq_group_privilege` (
	id int auto_increment not null ,
	group_id int comment 'xq_group.id' ,
	privilege_id int comment 'xq_privilege.id' ,
	primary key (id) ,
	unique key (group_id , privilege_id) 
) engine=innodb default charset=utf8 comment '用户组权限表';

drop table if exists `xq_privilege`;
create table if not exists `xq_privilege` (
	id int auto_increment not null ,
	group_id int comment 'xq_group.id' ,
	privilege_id int comment 'xq_privilege.id' ,
	enumerable enum('y' , 'n') default 'y' comment '是否可枚举权限' ,
	create_time datetime default current_timestamp ,
	primary key (id) ,
	unique key (group_id , privilege_id)
) engine=innodb default charset=utf8 comment '权限表';
-- 华丽的分割线 --

-- 华丽的分割线 --
-- 权限表

drop table if exists `xq_privilege`;
create table if not exists `xq_privilege` (
  id int auto_increment not null ,
  module char(255) comment '模块' ,
  controller char(255) comment '控制器' ,
  action char(255) comment '动作' ,
  cn char(255) comment '中文名' ,
  en char(255) comment '英文名' ,
  is_link enum('y' , 'n') default 'y' comment '是否链接' ,
  is_completed enum('y' , 'n') default 'y' comment '是否开发完成' ,
  is_disabled enum('y' , 'n') default 'n' comment '是否禁用' ,
  pid int comment '父级id' ,
  create_time datetime default current_timestamp ,
  primary key (id)
) comment '权限表';
-- 华丽的分割线 --
-- 用户区表

drop table if exists `xq_user`;
create table if not exists `xq_user` (
		id int primary key auto_increment not null ,
		username char(255) comment '用户名' ,
		password char(255) comment '密码' ,
		sex char(255) comment '性别' ,
		birthday date comment '生日' ,
		avatar varchar(500) comment '头像' ,
		token varchar(1000) comment '用户登录后 token' ,
		token_expire datetime default null comment 'token 过期时间' ,
		is_delete enum('y' , 'n') default 'n' comment '是否被删除' ,
		last_time datetime default null comment '最近登录时间' ,
		last_ip datetime default null comment '最近登录ip' ,
		province_id int comment '省份' ,
		city_id int comment '城市' ,
		area_id int comment '区域' ,
		address varchar(255) comment '具体地址' ,
		is_lock enum('y' , 'n') default 'n' comment '是否锁定' ,
		lock_time datetime comment '锁定时间' ,
		lock_expire datetime comment '锁定过期时间' ,
		phone int comment '手机' ,
		email char(255) comment '电子邮件' ,
		group_id int comment 'xq_group.id' ,
		create_time datetime default current_timestamp comment '注册时间' ,
		update_time datetime default current_timestamp on update current_timestamp comment '更新时间'
) engine=innodb default charset=utf8 comment='普通-用户表';

drop table if exists `xq_admin_user`;
create table if not exists `xq_admin_user` (
		id int primary key auto_increment not null ,
		username char(255) comment '用户名' ,
		password char(255) comment '密码' ,
		sex char(255) comment '性别' ,
		birthday date comment '生日' ,
		avatar varchar(500) comment '头像' ,
		token varchar(1000) comment '用户登录后 token' ,
		token_expire datetime default null comment 'token 过期时间' ,
		is_delete enum('y' , 'n') default 'n' comment '是否被删除' ,
		last_time datetime default null comment '最近登录时间' ,
		last_ip datetime default null comment '最近登录ip' ,
		province_id int comment '省份' ,
		city_id int comment '城市' ,
		area_id int comment '区域' ,
		address varchar(255) comment '具体地址' ,
		is_lock enum('y' , 'n') default 'n' comment '是否锁定' ,
		lock_time datetime comment '锁定时间' ,
		lock_expire datetime comment '锁定过期时间' ,
		phone int comment '手机' ,
		email char(255) comment '电子邮件' ,
		group_id int comment 'xq_group.id' ,
		create_time datetime default current_timestamp comment '注册时间' ,
		update_time datetime default current_timestamp on update current_timestamp comment '更新时间'
) engine=innodb default charset=utf8 comment='管理员-用户表';

drop table if exists `xq_admin_land_log`;
create table if not exists `xq_admin_land_log` (
  id int auto_increment not null ,
  user_id int comment '用户id' ,
  ip char(255) comment '登录ip' ,
  duration smallint comment '登录时长，单位 s' ,
  create_time datetime default current_timestamp comment '登录时间' ,
  primary key (id)
) engine=innodb default charset=utf8 comment '管理员登录表';

drop table if exists `xq_group`;
create table if not exists `xq_group` (
	id int auto_increment not null ,
	name varchar(500) comment '组名' ,
	type char(255) comment '类型：admin-后台用户组 front-前端用户组，其他待扩展' ,
	pid int comment '父级id' ,
	can_modify enum('y' , 'n') default 'y' comment '是否能够修改' ,
	create_time datetime default current_timestamp ,
	primary key (id)
) engine=innodb default charset=utf8 comment '用户组';

drop table if exists `xq_group_privilege`;
create table if not exists `xq_group_privilege` (
	id int auto_increment not null ,
	group_id int comment 'xq_group.id' ,
	privilege_id int comment 'xq_privilege.id' ,
	primary key (id) ,
	unique key (group_id , privilege_id) 
) engine=innodb default charset=utf8 comment '用户组权限表';

drop table if exists `xq_privilege`;
create table if not exists `xq_privilege` (
	id int auto_increment not null ,
	group_id int comment 'xq_group.id' ,
	privilege_id int comment 'xq_privilege.id' ,
	enumerable enum('y' , 'n') default 'y' comment '是否可枚举权限' ,
	create_time datetime default current_timestamp ,
	primary key (id) ,
	unique key (group_id , privilege_id)
) engine=innodb default charset=utf8 comment '权限表';
-- 华丽的分割线 --


-- 华丽的分割线 --

-- 权限表

drop table if exists `xq_privilege`;
create table if not exists `xq_privilege` (
  id int auto_increment not null ,
  module char(255) comment '模块' ,
  controller char(255) comment '控制器' ,
  action char(255) comment '动作' ,
  cn char(255) comment '中文名' ,
  en char(255) comment '英文名' ,
  is_link enum('y' , 'n') default 'y' comment '是否链接' ,
  is_completed enum('y' , 'n') default 'y' comment '是否开发完成' ,
  is_disabled enum('y' , 'n') default 'n' comment '是否禁用' ,
  pid int comment '父级id' ,
  create_time datetime default current_timestamp ,
  primary key (id)
) comment '权限表';

-- 华丽的分割线 --

-- 用户区表

drop table if exists `xq_user`;
create table if not exists `xq_user` (
		id int primary key auto_increment not null ,
		username char(255) comment '用户名' ,
		password char(255) comment '密码' ,
		sex char(255) comment '性别' ,
		birthday date comment '生日' ,
		avatar varchar(500) comment '头像' ,
		token varchar(1000) comment '用户登录后 token' ,
		token_expire datetime default null comment 'token 过期时间' ,
		is_delete enum('y' , 'n') default 'n' comment '是否被删除' ,
		last_time datetime default null comment '最近登录时间' ,
		last_ip datetime default null comment '最近登录ip' ,
		province_id int comment '省份' ,
		city_id int comment '城市' ,
		area_id int comment '区域' ,
		address varchar(255) comment '具体地址' ,
		is_lock enum('y' , 'n') default 'n' comment '是否锁定' ,
		lock_time datetime comment '锁定时间' ,
		lock_expire datetime comment '锁定过期时间' ,
		phone int comment '手机' ,
		email char(255) comment '电子邮件' ,
		group_id int comment 'xq_group.id' ,
		create_time datetime default current_timestamp comment '注册时间' ,
		update_time datetime default current_timestamp on update current_timestamp comment '更新时间'
) engine=innodb default charset=utf8 comment='普通-用户表';

drop table if exists `xq_admin_user`;
create table if not exists `xq_admin_user` (
		id int primary key auto_increment not null ,
		username char(255) comment '用户名' ,
		password char(255) comment '密码' ,
		sex char(255) comment '性别' ,
		birthday date comment '生日' ,
		avatar varchar(500) comment '头像' ,
		token varchar(1000) comment '用户登录后 token' ,
		token_expire datetime default null comment 'token 过期时间' ,
		is_delete enum('y' , 'n') default 'n' comment '是否被删除' ,
		last_time datetime default null comment '最近登录时间' ,
		last_ip datetime default null comment '最近登录ip' ,
		province_id int comment '省份' ,
		city_id int comment '城市' ,
		area_id int comment '区域' ,
		address varchar(255) comment '具体地址' ,
		is_lock enum('y' , 'n') default 'n' comment '是否锁定' ,
		lock_time datetime comment '锁定时间' ,
		lock_expire datetime comment '锁定过期时间' ,
		phone int comment '手机' ,
		email char(255) comment '电子邮件' ,
		group_id int comment 'xq_group.id' ,
		create_time datetime default current_timestamp comment '注册时间' ,
		update_time datetime default current_timestamp on update current_timestamp comment '更新时间'
) engine=innodb default charset=utf8 comment='管理员-用户表';

drop table if exists `xq_admin_land_log`;
create table if not exists `xq_admin_land_log` (
  id int auto_increment not null ,
  user_id int comment '用户id' ,
  ip char(255) comment '登录ip' ,
  duration smallint comment '登录时长，单位 s' ,
  create_time datetime default current_timestamp comment '登录时间' ,
  primary key (id)
) engine=innodb default charset=utf8 comment '管理员登录表';

drop table if exists `xq_group`;
create table if not exists `xq_group` (
	id int auto_increment not null ,
	name varchar(500) comment '组名' ,
	type char(255) comment '类型：admin-后台用户组 front-前端用户组，其他待扩展' ,
	pid int comment '父级id' ,
	can_modify enum('y' , 'n') default 'y' comment '是否能够修改' ,
	create_time datetime default current_timestamp ,
	primary key (id)
) engine=innodb default charset=utf8 comment '用户组';

drop table if exists `xq_group_privilege`;
create table if not exists `xq_group_privilege` (
	id int auto_increment not null ,
	group_id int comment 'xq_group.id' ,
	privilege_id int comment 'xq_privilege.id' ,
	primary key (id) ,
	unique key (group_id , privilege_id) 
) engine=innodb default charset=utf8 comment '用户组权限表';

drop table if exists `xq_privilege`;
create table if not exists `xq_privilege` (
	id int auto_increment not null ,
	group_id int comment 'xq_group.id' ,
	privilege_id int comment 'xq_privilege.id' ,
	enumerable enum('y' , 'n') default 'y' comment '是否可枚举权限' ,
	create_time datetime default current_timestamp ,
	primary key (id) ,
	unique key (group_id , privilege_id)
) engine=innodb default charset=utf8 comment '权限表';

-- 华丽的分割线 --



-- 权限表

drop table if exists `xq_privilege`;
create table if not exists `xq_privilege` (
  id int auto_increment not null ,
  module char(255) comment '模块' ,
  controller char(255) comment '控制器' ,
  action char(255) comment '动作' ,
  cn char(255) comment '中文名' ,
  en char(255) comment '英文名' ,
  is_link enum('y' , 'n') default 'y' comment '是否链接' ,
  is_completed enum('y' , 'n') default 'y' comment '是否开发完成' ,
  is_disabled enum('y' , 'n') default 'n' comment '是否禁用' ,
  pid int comment '父级id' ,
  create_time datetime default current_timestamp ,
  primary key (id)
) comment '权限表';

-- 用户区表

drop table if exists `xq_user`;
create table if not exists `xq_user` (
		id int primary key auto_increment not null ,
		username char(255) comment '用户名' ,
		password char(255) comment '密码' ,
		sex char(255) comment '性别' ,
		birthday date comment '生日' ,
		avatar varchar(500) comment '头像' ,
		token varchar(1000) comment '用户登录后 token' ,
		token_expire datetime default null comment 'token 过期时间' ,
		is_delete enum('y' , 'n') default 'n' comment '是否被删除' ,
		last_time datetime default null comment '最近登录时间' ,
		last_ip datetime default null comment '最近登录ip' ,
		province_id int comment '省份' ,
		city_id int comment '城市' ,
		area_id int comment '区域' ,
		address varchar(255) comment '具体地址' ,
		is_lock enum('y' , 'n') default 'n' comment '是否锁定' ,
		lock_time datetime comment '锁定时间' ,
		lock_expire datetime comment '锁定过期时间' ,
		phone int comment '手机' ,
		email char(255) comment '电子邮件' ,
		group_id int comment 'xq_group.id' ,
		create_time datetime default current_timestamp comment '注册时间' ,
		update_time datetime default current_timestamp on update current_timestamp comment '更新时间'
) engine=innodb default charset=utf8 comment='普通-用户表';

drop table if exists `xq_admin_user`;
create table if not exists `xq_admin_user` (
		id int primary key auto_increment not null ,
		username char(255) comment '用户名' ,
		password char(255) comment '密码' ,
		sex char(255) comment '性别' ,
		birthday date comment '生日' ,
		avatar varchar(500) comment '头像' ,
		token varchar(1000) comment '用户登录后 token' ,
		token_expire datetime default null comment 'token 过期时间' ,
		is_delete enum('y' , 'n') default 'n' comment '是否被删除' ,
		last_time datetime default null comment '最近登录时间' ,
		last_ip datetime default null comment '最近登录ip' ,
		province_id int comment '省份' ,
		city_id int comment '城市' ,
		area_id int comment '区域' ,
		address varchar(255) comment '具体地址' ,
		is_lock enum('y' , 'n') default 'n' comment '是否锁定' ,
		lock_time datetime comment '锁定时间' ,
		lock_expire datetime comment '锁定过期时间' ,
		phone int comment '手机' ,
		email char(255) comment '电子邮件' ,
		group_id int comment 'xq_group.id' ,
		create_time datetime default current_timestamp comment '注册时间' ,
		update_time datetime default current_timestamp on update current_timestamp comment '更新时间'
) engine=innodb default charset=utf8 comment='管理员-用户表';

drop table if exists `xq_admin_land_log`;
create table if not exists `xq_admin_land_log` (
  id int auto_increment not null ,
  user_id int comment '用户id' ,
  ip char(255) comment '登录ip' ,
  duration smallint comment '登录时长，单位 s' ,
  create_time datetime default current_timestamp comment '登录时间' ,
  primary key (id)
) engine=innodb default charset=utf8 comment '管理员登录表';

drop table if exists `xq_group`;
create table if not exists `xq_group` (
	id int auto_increment not null ,
	name varchar(500) comment '组名' ,
	type char(255) comment '类型：admin-后台用户组 front-前端用户组，其他待扩展' ,
	pid int comment '父级id' ,
	can_modify enum('y' , 'n') default 'y' comment '是否能够修改' ,
	create_time datetime default current_timestamp ,
	primary key (id)
) engine=innodb default charset=utf8 comment '用户组';

drop table if exists `xq_group_privilege`;
create table if not exists `xq_group_privilege` (
	id int auto_increment not null ,
	group_id int comment 'xq_group.id' ,
	privilege_id int comment 'xq_privilege.id' ,
	primary key (id) ,
	unique key (group_id , privilege_id) 
) engine=innodb default charset=utf8 comment '用户组权限表';

drop table if exists `xq_privilege`;
create table if not exists `xq_privilege` (
	id int auto_increment not null ,
	group_id int comment 'xq_group.id' ,
	privilege_id int comment 'xq_privilege.id' ,
	enumerable enum('y' , 'n') default 'y' comment '是否可枚举权限' ,
	create_time datetime default current_timestamp ,
	primary key (id) ,
	unique key (group_id , privilege_id)
) engine=innodb default charset=utf8 comment '权限表';



-- 权限表

drop table if exists `xq_privilege`;
create table if not exists `xq_privilege` (
  id int auto_increment not null ,
  module char(255) comment '模块' ,
  controller char(255) comment '控制器' ,
  action char(255) comment '动作' ,
  cn char(255) comment '中文名' ,
  en char(255) comment '英文名' ,
  is_link enum('y' , 'n') default 'y' comment '是否链接' ,
  is_completed enum('y' , 'n') default 'y' comment '是否开发完成' ,
  is_disabled enum('y' , 'n') default 'n' comment '是否禁用' ,
  pid int comment '父级id' ,
  create_time datetime default current_timestamp ,
  primary key (id)
) comment '权限表';

-- 用户区表

drop table if exists `xq_user`;
create table if not exists `xq_user` (
		id int primary key auto_increment not null ,
		username char(255) comment '用户名' ,
		password char(255) comment '密码' ,
		sex char(255) comment '性别' ,
		birthday date comment '生日' ,
		avatar varchar(500) comment '头像' ,
		token varchar(1000) comment '用户登录后 token' ,
		token_expire datetime default null comment 'token 过期时间' ,
		is_delete enum('y' , 'n') default 'n' comment '是否被删除' ,
		last_time datetime default null comment '最近登录时间' ,
		last_ip char(255) default null comment '最近登录ip' ,
		province_id int comment '省份' ,
		city_id int comment '城市' ,
		area_id int comment '区域' ,
		address varchar(255) comment '具体地址' ,
		is_lock enum('y' , 'n') default 'n' comment '是否锁定' ,
		lock_time datetime comment '锁定时间' ,
		lock_expire datetime comment '锁定过期时间' ,
		phone int comment '手机' ,
		email char(255) comment '电子邮件' ,
		group_id int comment 'xq_group.id' ,
		create_time datetime default current_timestamp comment '注册时间' ,
		update_time datetime default current_timestamp on update current_timestamp comment '更新时间'
) engine = innodb character set = utf8mb4 collate = utf8mb4_bin comment = '普通-用户表';

drop table if exists `xq_admin_user`;
create table if not exists `xq_admin_user` (
		id int primary key auto_increment not null ,
		username char(255) comment '用户名' ,
		password char(255) comment '密码' ,
		sex char(255) comment '性别' ,
		birthday date comment '生日' ,
		avatar varchar(500) comment '头像' ,
		token varchar(1000) comment '用户登录后 token' ,
		token_expire datetime default null comment 'token 过期时间' ,
		is_delete enum('y' , 'n') default 'n' comment '是否被删除' ,
		last_time datetime default null comment '最近登录时间' ,
		last_ip char(255) default null comment '最近登录ip' ,
		province_id int comment '省份' ,
		city_id int comment '城市' ,
		area_id int comment '区域' ,
		address varchar(255) comment '具体地址' ,
		is_lock enum('y' , 'n') default 'n' comment '是否锁定' ,
		lock_time datetime comment '锁定时间' ,
		lock_expire datetime comment '锁定过期时间' ,
		phone int comment '手机' ,
		email char(255) comment '电子邮件' ,
		group_id int comment 'xq_group.id' ,
		create_time datetime default current_timestamp comment '注册时间' ,
		update_time datetime default current_timestamp on update current_timestamp comment '更新时间'
) engine=innodb default charset=utf8 comment='管理员-用户表';

drop table if exists `xq_admin_land_log`;
create table if not exists `xq_admin_land_log` (
  id int auto_increment not null ,
  user_id int comment '用户id' ,
  ip char(255) comment '登录ip' ,
  duration smallint comment '登录时长，单位 s' ,
  create_time datetime default current_timestamp comment '登录时间' ,
  primary key (id)
) engine=innodb default charset=utf8 comment '管理员登录表';

drop table if exists `xq_group`;
create table if not exists `xq_group` (
	id int auto_increment not null ,
	name varchar(500) comment '组名' ,
	type char(255) comment '类型：admin-后台用户组 front-前端用户组，其他待扩展' ,
	pid int comment '父级id' ,
	can_modify enum('y' , 'n') default 'y' comment '是否能够修改' ,
	create_time datetime default current_timestamp ,
	primary key (id)
) engine=innodb default charset=utf8 comment '用户组';

drop table if exists `xq_group_privilege`;
create table if not exists `xq_group_privilege` (
	id int auto_increment not null ,
	group_id int comment 'xq_group.id' ,
	privilege_id int comment 'xq_privilege.id' ,
	primary key (id) ,
	unique key (group_id , privilege_id) 
) engine=innodb default charset=utf8 comment '用户组权限表';

drop table if exists `xq_privilege`;
create table if not exists `xq_privilege` (
	id int auto_increment not null ,
	group_id int comment 'xq_group.id' ,
	privilege_id int comment 'xq_privilege.id' ,
	enumerable enum('y' , 'n') default 'y' comment '是否可枚举权限' ,
	create_time datetime default current_timestamp ,
	primary key (id) ,
	unique key (group_id , privilege_id)
) engine=innodb default charset=utf8 comment '权限表';


drop table if exists `xq_token`;
create table if not exists `xq_token` (
	id int auto_increment not null ,
	user_type enum('admin' , 'user') default 'user' comment '用户类型：admin-后台用户 user-普通用户' ,
	user_id int comment 'xq_admin_user.id or xq_user.id' ,
	token varchar(500) comment 'token' ,
	expire datetime not null comment '过期时间' ,
	create_time datetime default current_timestamp ,
	primary key (id) ,
	unique key (user_type , token)
) comment '用户登陆状态表';

