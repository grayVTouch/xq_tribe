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