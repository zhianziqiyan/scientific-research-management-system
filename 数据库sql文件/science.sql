/*
Navicat MySQL Data Transfer

Source Server         : ZZQ
Source Server Version : 50737
Source Host           : localhost:3306
Source Database       : science

Target Server Type    : MYSQL
Target Server Version : 50737
File Encoding         : 65001

Date: 2022-07-05 19:55:33
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for achievement_type
-- ----------------------------
DROP TABLE IF EXISTS `achievement_type`;
CREATE TABLE `achievement_type` (
  `id` int(11) NOT NULL,
  `name` varchar(45) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of achievement_type
-- ----------------------------
INSERT INTO `achievement_type` VALUES ('1', '发明型专利');
INSERT INTO `achievement_type` VALUES ('2', '实用新型专利');
INSERT INTO `achievement_type` VALUES ('3', '外观型专利');
INSERT INTO `achievement_type` VALUES ('4', '论文');
INSERT INTO `achievement_type` VALUES ('5', '软件著作权');

-- ----------------------------
-- Table structure for client
-- ----------------------------
DROP TABLE IF EXISTS `client`;
CREATE TABLE `client` (
  `name` varchar(45) NOT NULL,
  `address` varchar(45) NOT NULL,
  `project_name` varchar(45) NOT NULL,
  PRIMARY KEY (`name`),
  KEY `project_name_idx` (`project_name`),
  CONSTRAINT `client_ibfk_1` FOREIGN KEY (`project_name`) REFERENCES `project` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of client
-- ----------------------------

-- ----------------------------
-- Table structure for director
-- ----------------------------
DROP TABLE IF EXISTS `director`;
CREATE TABLE `director` (
  `id` int(11) NOT NULL,
  `name` varchar(45) CHARACTER SET utf8 NOT NULL,
  `date_take_office` date NOT NULL COMMENT '上任时间',
  `tenture` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `name_idx` (`name`),
  KEY `director_ibfk_1` (`id`,`name`),
  CONSTRAINT `director_ibfk_1` FOREIGN KEY (`id`, `name`) REFERENCES `researcher` (`id`, `name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of director
-- ----------------------------
INSERT INTO `director` VALUES ('1', '小天', '2022-07-03', '200');
INSERT INTO `director` VALUES ('3', '小云', '2022-07-03', '300');

-- ----------------------------
-- Table structure for lab
-- ----------------------------
DROP TABLE IF EXISTS `lab`;
CREATE TABLE `lab` (
  `name` varchar(45) NOT NULL,
  `direction` varchar(45) NOT NULL,
  `sectary_id` int(11) NOT NULL,
  PRIMARY KEY (`name`),
  UNIQUE KEY `direction_UNIQUE` (`direction`),
  KEY `sectary_id_idx` (`sectary_id`),
  CONSTRAINT `lab_ibfk_1` FOREIGN KEY (`sectary_id`) REFERENCES `secretary` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lab
-- ----------------------------
INSERT INTO `lab` VALUES ('数据库实验室', '数据库开发', '1');
INSERT INTO `lab` VALUES ('网络实验室', '网络配置', '1');
INSERT INTO `lab` VALUES ('软件开发实验室', '软件开发', '2');

-- ----------------------------
-- Table structure for lab_location
-- ----------------------------
DROP TABLE IF EXISTS `lab_location`;
CREATE TABLE `lab_location` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lab_name` varchar(45) NOT NULL,
  `adddress` varchar(45) NOT NULL,
  `area` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `lab_name_idx` (`lab_name`),
  CONSTRAINT `lab_location_ibfk_1` FOREIGN KEY (`lab_name`) REFERENCES `lab` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lab_location
-- ----------------------------
INSERT INTO `lab_location` VALUES ('1', '数据库实验室', 'B7楼', '100');
INSERT INTO `lab_location` VALUES ('2', '软件开发实验室', 'B8楼', '150');

-- ----------------------------
-- Table structure for linkman
-- ----------------------------
DROP TABLE IF EXISTS `linkman`;
CREATE TABLE `linkman` (
  `name` varchar(45) NOT NULL,
  `TEL` int(11) NOT NULL,
  `MP` int(11) NOT NULL COMMENT '移动电话',
  `apartment` varchar(45) NOT NULL,
  PRIMARY KEY (`name`),
  KEY `apartment_idx` (`apartment`),
  CONSTRAINT `linkman_ibfk_1` FOREIGN KEY (`apartment`) REFERENCES `client` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `linkman_ibfk_2` FOREIGN KEY (`apartment`) REFERENCES `partner` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `linkman_ibfk_3` FOREIGN KEY (`apartment`) REFERENCES `monitor` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of linkman
-- ----------------------------

-- ----------------------------
-- Table structure for monitor
-- ----------------------------
DROP TABLE IF EXISTS `monitor`;
CREATE TABLE `monitor` (
  `name` varchar(45) NOT NULL,
  `address` varchar(45) NOT NULL,
  `project_name` varchar(45) NOT NULL,
  PRIMARY KEY (`name`),
  KEY `project_name` (`project_name`),
  CONSTRAINT `monitor_ibfk_1` FOREIGN KEY (`project_name`) REFERENCES `project` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of monitor
-- ----------------------------

-- ----------------------------
-- Table structure for partner
-- ----------------------------
DROP TABLE IF EXISTS `partner`;
CREATE TABLE `partner` (
  `name` varchar(45) NOT NULL,
  `address` varchar(45) NOT NULL,
  `project_name` varchar(45) NOT NULL,
  PRIMARY KEY (`name`),
  KEY `project_name` (`project_name`),
  CONSTRAINT `partner_ibfk_1` FOREIGN KEY (`project_name`) REFERENCES `project` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of partner
-- ----------------------------

-- ----------------------------
-- Table structure for principal
-- ----------------------------
DROP TABLE IF EXISTS `principal`;
CREATE TABLE `principal` (
  `name` varchar(45) CHARACTER SET utf8 NOT NULL,
  `TEL` int(11) NOT NULL,
  `MP` int(11) NOT NULL,
  `apartment` varchar(45) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`name`),
  KEY `apartment` (`apartment`),
  CONSTRAINT `principal_ibfk_1` FOREIGN KEY (`apartment`) REFERENCES `client` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `principal_ibfk_2` FOREIGN KEY (`apartment`) REFERENCES `partner` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `principal_ibfk_3` FOREIGN KEY (`apartment`) REFERENCES `monitor` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of principal
-- ----------------------------

-- ----------------------------
-- Table structure for project
-- ----------------------------
DROP TABLE IF EXISTS `project`;
CREATE TABLE `project` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `principle` varchar(45) NOT NULL,
  `research_contents` varchar(45) NOT NULL,
  `expenditure` int(11) NOT NULL COMMENT '经费',
  `start_date` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of project
-- ----------------------------
INSERT INTO `project` VALUES ('1', '数据库实训', '小刚', '数据库代码剖析', '10000', '2022-07-02 00:00:00', '2022-07-07 00:00:00');
INSERT INTO `project` VALUES ('3', '软件开发实训', '小卢', '软件开发原理', '50000', '2002-02-02 15:33:00', '2002-02-02 15:33:00');

-- ----------------------------
-- Table structure for researcher
-- ----------------------------
DROP TABLE IF EXISTS `researcher`;
CREATE TABLE `researcher` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `gender` varchar(45) NOT NULL,
  `title` varchar(45) NOT NULL,
  `age` int(11) NOT NULL,
  `direction` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `direction_idx` (`direction`),
  KEY `name` (`name`),
  KEY `id` (`id`,`name`),
  CONSTRAINT `direction` FOREIGN KEY (`direction`) REFERENCES `lab` (`direction`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of researcher
-- ----------------------------
INSERT INTO `researcher` VALUES ('1', '小天', '男', '博士', '40', '数据库开发');
INSERT INTO `researcher` VALUES ('2', '小丽', '女', '硕士', '35', '数据库开发');
INSERT INTO `researcher` VALUES ('3', '小云', '男', '博士', '45', '软件开发');
INSERT INTO `researcher` VALUES ('4', '小月', '女', '硕士', '30', '软件开发');

-- ----------------------------
-- Table structure for research_achievement
-- ----------------------------
DROP TABLE IF EXISTS `research_achievement`;
CREATE TABLE `research_achievement` (
  `id` int(11) NOT NULL,
  `name` varchar(45) CHARACTER SET utf8 NOT NULL,
  `contributer` varchar(45) CHARACTER SET utf8 NOT NULL,
  `get_date` date NOT NULL,
  `project_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `rank` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `type_id` (`type_id`),
  KEY `project_id` (`project_id`),
  KEY `contributer` (`contributer`),
  CONSTRAINT `research_achievement_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `research_achievement_ibfk_2` FOREIGN KEY (`type_id`) REFERENCES `achievement_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `research_achievement_ibfk_3` FOREIGN KEY (`contributer`) REFERENCES `researcher` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of research_achievement
-- ----------------------------
INSERT INTO `research_achievement` VALUES ('1', '数据库一键迁移', '小天', '2022-07-03', '1', '5', '2');
INSERT INTO `research_achievement` VALUES ('2', '《多平台应用的开发方法》', '小月', '2022-07-03', '3', '4', '1');

-- ----------------------------
-- Table structure for research_sub_project
-- ----------------------------
DROP TABLE IF EXISTS `research_sub_project`;
CREATE TABLE `research_sub_project` (
  `research_id` int(11) NOT NULL,
  `sub_project_id` int(11) NOT NULL,
  `join_date` date NOT NULL,
  `workload` int(11) NOT NULL,
  `expenditure` int(11) NOT NULL,
  `rank` int(11) NOT NULL,
  PRIMARY KEY (`research_id`,`sub_project_id`),
  KEY `sub_project_id` (`sub_project_id`),
  CONSTRAINT `research_sub_project_ibfk_1` FOREIGN KEY (`research_id`) REFERENCES `researcher` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `research_sub_project_ibfk_2` FOREIGN KEY (`sub_project_id`) REFERENCES `sub_project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of research_sub_project
-- ----------------------------

-- ----------------------------
-- Table structure for secretary
-- ----------------------------
DROP TABLE IF EXISTS `secretary`;
CREATE TABLE `secretary` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `gender` varchar(45) NOT NULL,
  `age` int(45) NOT NULL,
  `date_take_office` date NOT NULL,
  `duty` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of secretary
-- ----------------------------
INSERT INTO `secretary` VALUES ('1', '小红', '女', '30', '2022-07-02', '整理资料');
INSERT INTO `secretary` VALUES ('2', '小亮', '男', '30', '2022-07-03', '前台接待');

-- ----------------------------
-- Table structure for sub_project
-- ----------------------------
DROP TABLE IF EXISTS `sub_project`;
CREATE TABLE `sub_project` (
  `id` int(11) NOT NULL,
  `principle` varchar(45) NOT NULL,
  `end_date` date NOT NULL,
  `expenditure` int(11) NOT NULL,
  `technical_index` varchar(45) NOT NULL,
  `project_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `sub_project_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of sub_project
-- ----------------------------
