/*
Navicat MySQL Data Transfer

Source Server         : 170
Source Server Version : 50077
Source Host           : 10.13.49.170:3306
Source Database       : ipss

Target Server Type    : MYSQL
Target Server Version : 50077
File Encoding         : 65001

Date: 2014-11-25 17:21:07
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `f_forum`
-- ----------------------------
DROP TABLE IF EXISTS `f_forum`;
CREATE TABLE `f_forum` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(40) NOT NULL default '' COMMENT '版块名',
  `pro_name` varchar(100) NOT NULL default '' COMMENT '该版块关联的产品名称',
  `pro_id` int(10) unsigned NOT NULL default '0' COMMENT '该版块关联的产品id',
  `create_time` timestamp NOT NULL default '0000-00-00 00:00:00' COMMENT '创建时间',
  `create_ip` int(10) unsigned NOT NULL COMMENT '创建IP',
  `create_uid` int(11) unsigned NOT NULL COMMENT '创建者UID',
  `update_time` timestamp NOT NULL default '0000-00-00 00:00:00' COMMENT '更新时间',
  `update_ip` int(10) unsigned NOT NULL COMMENT '更新IP',
  `update_uid` int(11) unsigned NOT NULL COMMENT '更新者UID',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='版块表';

-- ----------------------------
-- Records of f_forum
-- ----------------------------

-- ----------------------------
-- Table structure for `f_post`
-- ----------------------------
DROP TABLE IF EXISTS `f_post`;
CREATE TABLE `f_post` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `sub_id` int(10) unsigned NOT NULL default '0' COMMENT '主题id',
  `is_sub` tinyint(4) NOT NULL default '0' COMMENT '是否为主题，1：主题，0：帖子',
  `title` varchar(100) NOT NULL default '' COMMENT '帖子标题',
  `content` mediumtext NOT NULL COMMENT '帖子内容',
  `invisible` tinyint(4) NOT NULL default '1' COMMENT '是否可见，0：不可见，1：可见',
  `attachment` tinyint(4) NOT NULL default '0' COMMENT '是否有附件，1：有，0：无',
  `stat` tinyint(4) NOT NULL default '0' COMMENT '状态，1：正常，0：删除',
  `create_time` timestamp NOT NULL default '0000-00-00 00:00:00' COMMENT '创建时间',
  `create_ip` int(10) unsigned NOT NULL COMMENT '创建IP',
  `create_uid` int(11) unsigned NOT NULL COMMENT '创建者UID',
  `update_time` timestamp NOT NULL default '0000-00-00 00:00:00' COMMENT '更新时间',
  `update_ip` int(10) unsigned NOT NULL COMMENT '更新IP',
  `update_uid` int(11) unsigned NOT NULL COMMENT '更新者UID',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='主题和回帖表';

-- ----------------------------
-- Records of f_post
-- ----------------------------

-- ----------------------------
-- Table structure for `f_subject`
-- ----------------------------
DROP TABLE IF EXISTS `f_subject`;
CREATE TABLE `f_subject` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `for_id` int(10) unsigned NOT NULL default '0' COMMENT '版块id',
  `title` varchar(100) NOT NULL default '' COMMENT '主题',
  `is_top` tinyint(4) NOT NULL default '0' COMMENT '是否置顶，0：否，1：是',
  `is_digest` tinyint(4) NOT NULL default '0' COMMENT '是否精华，0：否，1：是',
  `is_locked` tinyint(4) NOT NULL default '0' COMMENT '是否被锁定，0：否，1：是',
  `prop` tinyint(4) NOT NULL default '0' COMMENT '帖子性质，1：bug，2：需求',
  `lastpost` timestamp NOT NULL default '0000-00-00 00:00:00' COMMENT '最后的回复时间',
  `lastposter` varchar(20) NOT NULL default '' COMMENT '最后的回复者',
  `votes` int(10) unsigned NOT NULL default '0' COMMENT '投票数',
  `views` int(10) unsigned NOT NULL default '0' COMMENT '点击数',
  `replies` mediumint(8) unsigned NOT NULL default '0' COMMENT '回复数',
  `stat` tinyint(4) NOT NULL default '1' COMMENT '状态，1：正常，0：删除',
  `create_time` timestamp NOT NULL default '0000-00-00 00:00:00' COMMENT '创建时间',
  `create_ip` int(10) unsigned NOT NULL COMMENT '创建IP',
  `create_uid` int(11) unsigned NOT NULL COMMENT '创建者UID',
  `update_time` timestamp NOT NULL default '0000-00-00 00:00:00' COMMENT '更新时间',
  `update_ip` int(10) unsigned NOT NULL COMMENT '更新IP',
  `update_uid` int(11) unsigned NOT NULL COMMENT '更新者UID',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='主题表';

-- ----------------------------
-- Records of f_subject
-- ----------------------------

-- ----------------------------
-- Table structure for `f_subject_vote`
-- ----------------------------
DROP TABLE IF EXISTS `f_subject_vote`;
CREATE TABLE `f_subject_vote` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `sub_id` int(10) unsigned NOT NULL default '0' COMMENT '主题id',
  `hash` varchar(60) NOT NULL default '' COMMENT 'uid/ip+时间段的hash值',
  `create_time` timestamp NOT NULL default '0000-00-00 00:00:00' COMMENT '创建时间',
  `create_ip` int(10) unsigned NOT NULL COMMENT '创建IP',
  `create_uid` int(11) unsigned NOT NULL COMMENT '创建者UID',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `idx_hash` (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='主题投票表';

-- ----------------------------
-- Records of f_subject_vote
-- ----------------------------

-- ----------------------------
-- Table structure for `m_bug`
-- ----------------------------
DROP TABLE IF EXISTS `m_bug`;
CREATE TABLE `m_bug` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `sub_id` int(10) unsigned NOT NULL default '0' COMMENT '帖子id',
  `pro_id` int(10) unsigned NOT NULL default '0' COMMENT '所属的产品id',
  `ver_id` int(10) unsigned NOT NULL default '0' COMMENT '所属的版本id',
  `title` varchar(100) NOT NULL default '' COMMENT '标题',
  `desc` varchar(1000) NOT NULL default '' COMMENT 'bug描述',
  `cur_uid` int(10) unsigned NOT NULL default '0' COMMENT '当前被分配到的uid',
  `process_stat` tinyint(3) unsigned NOT NULL default '1' COMMENT 'bug状态，1：被创建，2：处理中，3：处理完毕，4：测试完成',
  `stat` tinyint(4) NOT NULL default '1' COMMENT '状态，1：正常，0：删除',
  `create_time` timestamp NOT NULL default '0000-00-00 00:00:00' COMMENT '创建时间',
  `create_ip` int(10) unsigned NOT NULL COMMENT '创建IP',
  `create_uid` int(11) unsigned NOT NULL COMMENT '创建者UID',
  `update_time` timestamp NOT NULL default '0000-00-00 00:00:00' COMMENT '更新时间',
  `update_ip` int(10) unsigned NOT NULL COMMENT '更新IP',
  `update_uid` int(11) unsigned NOT NULL COMMENT '更新者UID',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='bug列表';

-- ----------------------------
-- Records of m_bug
-- ----------------------------

-- ----------------------------
-- Table structure for `m_rqmt`
-- ----------------------------
DROP TABLE IF EXISTS `m_rqmt`;
CREATE TABLE `m_rqmt` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `sub_id` int(10) unsigned NOT NULL default '0' COMMENT '帖子id',
  `pro_id` int(10) unsigned NOT NULL default '0' COMMENT '所属的产品id',
  `ver_id` int(10) unsigned NOT NULL default '0' COMMENT '所属的版本id',
  `title` varchar(100) NOT NULL default '' COMMENT '标题',
  `desc` varchar(1000) NOT NULL default '' COMMENT '需求描述',
  `cur_uid` int(10) unsigned NOT NULL default '0' COMMENT '当前被分配到的uid',
  `process_stat` tinyint(3) unsigned NOT NULL default '1' COMMENT '需求状态，1：被创建，2：处理中，3：处理完毕，4：测试完成',
  `stat` tinyint(4) NOT NULL default '1' COMMENT '状态，1：正常，0：删除',
  `create_time` timestamp NOT NULL default '0000-00-00 00:00:00' COMMENT '创建时间',
  `create_ip` int(10) unsigned NOT NULL COMMENT '创建IP',
  `create_uid` int(11) unsigned NOT NULL COMMENT '创建者UID',
  `update_time` timestamp NOT NULL default '0000-00-00 00:00:00' COMMENT '更新时间',
  `update_ip` int(10) unsigned NOT NULL COMMENT '更新IP',
  `update_uid` int(11) unsigned NOT NULL COMMENT '更新者UID',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='需求列表';

-- ----------------------------
-- Records of m_rqmt
-- ----------------------------

-- ----------------------------
-- Table structure for `pmsg`
-- ----------------------------
DROP TABLE IF EXISTS `pmsg`;
CREATE TABLE `pmsg` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `to_uid` int(10) unsigned NOT NULL default '0' COMMENT '接收人uid',
  `message` varchar(500) NOT NULL default '' COMMENT '私信内容',
  `from` tinyint(4) NOT NULL default '0' COMMENT '私信来源，1：管理员发送，2：BUG，3：需求',
  `from_id` int(11) NOT NULL default '0' COMMENT 'bug表或rqment表的id，由from的值决定',
  `stat` tinyint(4) NOT NULL default '1' COMMENT '状态，1：正常，0：删除',
  `create_time` timestamp NOT NULL default '0000-00-00 00:00:00' COMMENT '创建时间',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='私信';

-- ----------------------------
-- Records of pmsg
-- ----------------------------

-- ----------------------------
-- Table structure for `prd`
-- ----------------------------
DROP TABLE IF EXISTS `prd`;
CREATE TABLE `prd` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(100) NOT NULL default '' COMMENT '产品名称',
  `latest_version` varchar(10) NOT NULL default '' COMMENT '最新版本号',
  `stat` tinyint(4) NOT NULL default '1' COMMENT '状态，1：正常，0：删除',
  `create_time` timestamp NOT NULL default '0000-00-00 00:00:00' COMMENT '创建时间',
  `create_ip` int(10) unsigned NOT NULL COMMENT '创建IP',
  `create_uid` int(11) unsigned NOT NULL COMMENT '创建者UID',
  `update_time` timestamp NOT NULL default '0000-00-00 00:00:00' COMMENT '更新时间',
  `update_ip` int(10) unsigned NOT NULL COMMENT '更新IP',
  `update_uid` int(11) unsigned NOT NULL COMMENT '更新者UID',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='产品表';

-- ----------------------------
-- Records of prd
-- ----------------------------

-- ----------------------------
-- Table structure for `prd_ver`
-- ----------------------------
DROP TABLE IF EXISTS `prd_ver`;
CREATE TABLE `prd_ver` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `pro_id` int(10) unsigned NOT NULL default '0' COMMENT '产品id',
  `version` varchar(10) NOT NULL default '' COMMENT '版本',
  `bugs` mediumint(8) unsigned NOT NULL default '0' COMMENT '本版本出现的bug数',
  `reqs` mediumint(8) unsigned NOT NULL default '0' COMMENT '本版本的需求数',
  `subs` mediumint(8) unsigned NOT NULL default '0' COMMENT '与本版本相关的主题数',
  `stat` tinyint(4) NOT NULL default '1' COMMENT '状态，1：正常，0：删除',
  `create_time` timestamp NOT NULL default '0000-00-00 00:00:00' COMMENT '创建时间',
  `create_ip` int(10) unsigned NOT NULL COMMENT '创建IP',
  `create_uid` int(11) unsigned NOT NULL COMMENT '创建者UID',
  `update_time` timestamp NOT NULL default '0000-00-00 00:00:00' COMMENT '更新时间',
  `update_ip` int(10) unsigned NOT NULL COMMENT '更新IP',
  `update_uid` int(11) unsigned NOT NULL COMMENT '更新者UID',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='产品的版本号';

-- ----------------------------
-- Records of prd_ver
-- ----------------------------

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(100) NOT NULL default '' COMMENT '用户名',
  `email` varchar(100) NOT NULL default '' COMMENT '邮箱',
  `type` tinyint(4) NOT NULL default '0' COMMENT '用户类型，1：普通用户，2：高级用户，3：内部用户',
  `bind_wechat` tinyint(4) NOT NULL default '0' COMMENT '是否绑定了微信，0：否，1：是',
  `bind_weibo` tinyint(4) NOT NULL default '0' COMMENT '是否绑定了微博，0：否，1：是',
  `last_time` timestamp NOT NULL default '0000-00-00 00:00:00' COMMENT '最后一次登录时间',
  `last_ip` int(10) unsigned NOT NULL default '0' COMMENT '最后一次登录的ip',
  `create_time` timestamp NOT NULL default '0000-00-00 00:00:00' COMMENT '创建时间',
  `create_ip` int(10) unsigned NOT NULL COMMENT '创建IP',
  `create_uid` int(11) unsigned NOT NULL COMMENT '创建者UID',
  `update_time` timestamp NOT NULL default '0000-00-00 00:00:00' COMMENT '更新时间',
  `update_ip` int(10) unsigned NOT NULL COMMENT '更新IP',
  `update_uid` int(11) unsigned NOT NULL COMMENT '更新者UID',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of user
-- ----------------------------

-- ----------------------------
-- Table structure for `user_log`
-- ----------------------------
DROP TABLE IF EXISTS `user_log`;
CREATE TABLE `user_log` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `uid` int(10) unsigned NOT NULL default '0' COMMENT '用户id',
  `sessionid` varchar(64) NOT NULL default '',
  `login_time` timestamp NOT NULL default '0000-00-00 00:00:00' COMMENT '登录时间',
  `logout_time` timestamp NOT NULL default '0000-00-00 00:00:00' COMMENT '登出时间',
  `duration` int(10) unsigned NOT NULL default '0' COMMENT '时长，logout_time - login_time，单位为秒',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户登录日志';

-- ----------------------------
-- Records of user_log
-- ----------------------------

-- ----------------------------
-- Table structure for `user_session`
-- ----------------------------
DROP TABLE IF EXISTS `user_session`;
CREATE TABLE `user_session` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `uid` int(10) unsigned NOT NULL default '0' COMMENT '用户id（user表id）',
  `platform` tinyint(4) NOT NULL default '0' COMMENT '对应平台，1：微博，2：微信',
  `user_id` varchar(11) NOT NULL default '' COMMENT '绑定平台的用户id',
  `user_name` varchar(30) NOT NULL default '' COMMENT '绑定平台的用户昵称',
  `access_token` varchar(64) NOT NULL default '',
  `deadline` timestamp NOT NULL default '0000-00-00 00:00:00' on update CURRENT_TIMESTAMP,
  `sessionid` varchar(64) NOT NULL default '',
  `create_time` timestamp NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `uid` USING BTREE (`user_id`),
  UNIQUE KEY `access_token` USING BTREE (`access_token`),
  KEY `sessionid` USING BTREE (`sessionid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户在其他平台的access_token表';

-- ----------------------------
-- Records of user_session
-- ----------------------------
