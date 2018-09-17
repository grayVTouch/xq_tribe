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
