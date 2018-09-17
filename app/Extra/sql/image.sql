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