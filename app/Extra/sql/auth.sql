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