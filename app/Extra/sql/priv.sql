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