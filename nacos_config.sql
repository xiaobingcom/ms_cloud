/*
 Navicat Premium Data Transfer

 Source Server         : 本机
 Source Server Type    : MySQL
 Source Server Version : 50731
 Source Host           : localhost:3306
 Source Schema         : nacos_config

 Target Server Type    : MySQL
 Target Server Version : 50731
 File Encoding         : 65001

 Date: 18/09/2020 15:12:33
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for config_info
-- ----------------------------
DROP TABLE IF EXISTS `config_info`;
CREATE TABLE `config_info`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'source user',
  `src_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  `c_desc` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `c_use` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `effect` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `type` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `c_schema` text CHARACTER SET utf8 COLLATE utf8_bin NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfo_datagrouptenant`(`data_id`, `group_id`, `tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_info
-- ----------------------------
INSERT INTO `config_info` VALUES (1, 'application-dev.yml', 'DEFAULT_GROUP', 'spring:\n  main:\n    allow-bean-definition-overriding: true\n\n#请求处理的超时时间\nribbon:\n  ReadTimeout: 10000\n  ConnectTimeout: 10000\n\n# feign 配置\nfeign:\n  sentinel:\n    enabled: true\n  okhttp:\n    enabled: true\n  httpclient:\n    enabled: false\n  client:\n    config:\n      default:\n        connectTimeout: 10000\n        readTimeout: 10000\n  compression:\n    request:\n      enabled: true\n    response:\n      enabled: true\n\n# 暴露监控端点\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \'*\'\n', '57470c6d167154919418fa150863b7fb', '2019-11-29 16:31:20', '2020-09-01 09:14:30', NULL, '0:0:0:0:0:0:0:1', '', '', '通用配置', 'null', 'null', 'yaml', 'null');
INSERT INTO `config_info` VALUES (9, 'ms-job-dev.yml', 'DEFAULT_GROUP', '# Spring\r\nspring: \r\n  datasource:\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://localhost:3306/grade_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\r\n    username: root\r\n    password: root\r\n\r\n# Mybatis配置\r\nmybatis:\r\n    # 搜索指定包别名\r\n    typeAliasesPackage: com.ruoyi.job.domain\r\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\r\n    mapperLocations: classpath:mapper/**/*.xml\r\n\r\n# swagger 配置\r\nswagger:\r\n  title: 定时任务接口文档\r\n  license: Powered By xiaobing\r\n  licenseUrl: https://baidu\r\n  authorization:\r\n    name: ms OAuth\r\n    auth-regex: ^.*$\r\n    authorization-scope-list:\r\n      - scope: server\r\n        description: 客户端授权范围\r\n    token-url-list:\r\n      - http://localhost:8080/auth/login\r\n', '47541dc16500cef54b78c264ce1764e8', '2020-09-17 10:42:11', '2020-09-17 16:56:56', NULL, '0:0:0:0:0:0:0:1', '', '', '', '', '', 'yaml', '');
INSERT INTO `config_info` VALUES (11, 'ms-gateway-dev.yml', 'DEFAULT_GROUP', 'spring:\r\n  redis:\r\n    host: localhost\r\n    port: 6379\r\n    password: \r\n  cloud:\r\n    gateway:\r\n      discovery:\r\n        locator:\r\n          lowerCaseServiceId: true\r\n          enabled: true\r\n      routes:\r\n        # 认证中心\r\n        - id: ms-auth\r\n          uri: lb://ms-auth\r\n          predicates:\r\n            - Path=/auth/**\r\n          filters:\r\n            - StripPrefix=1\r\n        # # 代码生成\r\n        # - id: ms-gen\r\n        #   uri: lb://ms-gen\r\n        #   predicates:\r\n        #     - Path=/code/**\r\n        #   filters:\r\n        #     - StripPrefix=1\r\n        # 定时任务\r\n        - id: ms-job\r\n          uri: lb://ms-job\r\n          predicates:\r\n            - Path=/schedule/**\r\n          filters:\r\n            - StripPrefix=1\r\n        - id: ms-notice\r\n          uri: lb://ms-notice\r\n          predicates:\r\n            - Path=/notice/**\r\n          filters:\r\n            - StripPrefix=1\r\n\r\n# 不校验白名单\r\nignore:\r\n  whites:\r\n    - /auth/login\r\n    - /v2/api-docs\r\n    - /csrf\r\n    - /auth/sms/send/code', '5ab7ff5b7edf35b2948b7478a1bbfde3', '2020-09-17 10:43:58', '2020-09-17 20:21:32', NULL, '0:0:0:0:0:0:0:1', '', '', '', '', '', 'yaml', '');
INSERT INTO `config_info` VALUES (13, 'sentinel-ms-gateway', 'DEFAULT_GROUP', '[\r\n    {\r\n        \"resource\": \"ms-auth\",\r\n        \"count\": 500,\r\n        \"grade\": 1,\r\n        \"limitApp\": \"default\",\r\n        \"strategy\": 0,\r\n        \"controlBehavior\": 0\r\n    },\r\n	{\r\n        \"resource\": \"ms-gen\",\r\n        \"count\": 200,\r\n        \"grade\": 1,\r\n        \"limitApp\": \"default\",\r\n        \"strategy\": 0,\r\n        \"controlBehavior\": 0\r\n    },\r\n	{\r\n        \"resource\": \"ms-job\",\r\n        \"count\": 300,\r\n        \"grade\": 1,\r\n        \"limitApp\": \"default\",\r\n        \"strategy\": 0,\r\n        \"controlBehavior\": 0\r\n    }\r\n]', 'cb400d9199d3d8300f32f9588b80e682', '2020-09-17 10:44:54', '2020-09-17 19:54:02', NULL, '0:0:0:0:0:0:0:1', '', '', '', '', '', 'json', '');
INSERT INTO `config_info` VALUES (14, 'ms-gen-dev.yml', 'DEFAULT_GROUP', '# Spring\r\nspring: \r\n  datasource:\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://localhost:3306/ry-cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\r\n    username: root\r\n    password: password\r\n\r\n# Mybatis配置\r\nmybatis:\r\n    # 搜索指定包别名\r\n    typeAliasesPackage: com.ruoyi.gen.domain\r\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\r\n    mapperLocations: classpath:mapper/**/*.xml\r\n\r\n# swagger 配置\r\nswagger:\r\n  title: 代码生成接口文档\r\n  license: Powered By ruoyi\r\n  licenseUrl: https://ruoyi.vip\r\n  authorization:\r\n    name: RuoYi OAuth\r\n    auth-regex: ^.*$\r\n    authorization-scope-list:\r\n      - scope: server\r\n        description: 客户端授权范围\r\n    token-url-list:\r\n      - http://localhost:8080/auth/oauth/token\r\n\r\n# 代码生成\r\ngen: \r\n  # 作者\r\n  author: ruoyi\r\n  # 默认生成包路径 system 需改成自己的模块名称 如 system monitor tool\r\n  packageName: com.ruoyi.system\r\n  # 自动去除表前缀，默认是false\r\n  autoRemovePre: false\r\n  # 表前缀（生成类名不会包含表前缀，多个用逗号分隔）\r\n  tablePrefix: sys_\r\n', 'aa7e94e2abbdeb408bd8981391ab82f8', '2020-09-17 10:45:12', '2020-09-17 10:45:12', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, 'yaml', NULL);
INSERT INTO `config_info` VALUES (15, 'ms-system-dev.yml', 'DEFAULT_GROUP', '# Spring\r\nspring: \r\n  redis:\r\n    host: localhost\r\n    port: 6379\r\n    password: \r\n  datasource:\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://localhost:3306/ry-cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\r\n    username: root\r\n    password: password\r\n\r\n# Mybatis配置\r\nmybatis:\r\n    # 搜索指定包别名\r\n    typeAliasesPackage: com.ruoyi.system\r\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\r\n    mapperLocations: classpath:mapper/**/*.xml\r\n\r\n# swagger 配置\r\nswagger:\r\n  title: 系统模块接口文档\r\n  license: Powered By ruoyi\r\n  licenseUrl: https://ruoyi.vip\r\n  authorization:\r\n    name: RuoYi OAuth\r\n    auth-regex: ^.*$\r\n    authorization-scope-list:\r\n      - scope: server\r\n        description: 客户端授权范围\r\n    token-url-list:\r\n      - http://localhost:8080/auth/oauth/token\r\n', '06f95c879d284ec8031cc44805e62b50', '2020-09-17 10:45:29', '2020-09-17 10:45:29', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, 'yaml', NULL);
INSERT INTO `config_info` VALUES (16, 'ms-auth-dev.yml', 'DEFAULT_GROUP', 'spring: \r\n  datasource:\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://localhost:3306/grade_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\r\n    username: root\r\n    password: root\r\n  redis:\r\n    host: localhost\r\n    port: 6379\r\n    password: \r\n# swagger 配置\r\nswagger:\r\n  title: 授权接口文档\r\n  license: Powered By xiaobing\r\n  licenseUrl: https://baidu\r\n  authorization:\r\n    name: ms OAuth\r\n    auth-regex: ^.*$\r\n    authorization-scope-list:\r\n      - scope: server\r\n        description: 客户端授权范围\r\n    token-url-list:\r\n      - http://localhost:9200/login\r\n', '1c3290b01636a089296cd5363eddf3c8', '2020-09-17 10:45:45', '2020-09-17 20:05:22', NULL, '0:0:0:0:0:0:0:1', '', '', '', '', '', 'yaml', '');
INSERT INTO `config_info` VALUES (17, 'ms-monitor-dev.yml', 'DEFAULT_GROUP', '# Spring\r\nspring: \r\n  security:\r\n    user:\r\n      name: ruoyi\r\n      password: 123456\r\n  boot:\r\n    admin:\r\n      ui:\r\n        title: 若依服务状态监控\r\n', '8e49d78998a7780d780305aeefe4fb1b', '2020-09-17 10:46:02', '2020-09-17 10:46:02', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, 'yaml', NULL);
INSERT INTO `config_info` VALUES (41, 'ms-notice-dev.yml', 'DEFAULT_GROUP', '# Spring\r\nspring: \r\n  datasource:\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://localhost:3306/grade_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\r\n    username: root\r\n    password: root\r\n\r\n# Mybatis配置\r\nmybatis:\r\n    # 搜索指定包别名\r\n    typeAliasesPackage: com.ruoyi.job.domain\r\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\r\n    mapperLocations: classpath:mapper/**/*.xml\r\n\r\n# swagger 配置\r\nswagger:\r\n  title: 通知接口文档\r\n  license: Powered By xiaobing\r\n  licenseUrl: https://baidu\r\n  authorization:\r\n    name: ms OAuth\r\n    auth-regex: ^.*$\r\n    authorization-scope-list:\r\n      - scope: server\r\n        description: 客户端授权范围\r\n    token-url-list:\r\n      - http://localhost:8080/auth/login\r\n', '947d747a5868eae7d749d2d431652ac3', '2020-09-17 20:00:28', '2020-09-17 20:01:53', NULL, '0:0:0:0:0:0:0:1', '', '', '', '', '', 'yaml', '');

-- ----------------------------
-- Table structure for config_info_aggr
-- ----------------------------
DROP TABLE IF EXISTS `config_info_aggr`;
CREATE TABLE `config_info_aggr`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `datum_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'datum_id',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '内容',
  `gmt_modified` datetime(0) NOT NULL COMMENT '修改时间',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfoaggr_datagrouptenantdatum`(`data_id`, `group_id`, `tenant_id`, `datum_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '增加租户字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_info_aggr
-- ----------------------------

-- ----------------------------
-- Table structure for config_info_beta
-- ----------------------------
DROP TABLE IF EXISTS `config_info_beta`;
CREATE TABLE `config_info_beta`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `beta_ips` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'betaIps',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'source user',
  `src_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfobeta_datagrouptenant`(`data_id`, `group_id`, `tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info_beta' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_info_beta
-- ----------------------------

-- ----------------------------
-- Table structure for config_info_tag
-- ----------------------------
DROP TABLE IF EXISTS `config_info_tag`;
CREATE TABLE `config_info_tag`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_id',
  `tag_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'tag_id',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'source user',
  `src_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfotag_datagrouptenanttag`(`data_id`, `group_id`, `tenant_id`, `tag_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info_tag' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_info_tag
-- ----------------------------

-- ----------------------------
-- Table structure for config_tags_relation
-- ----------------------------
DROP TABLE IF EXISTS `config_tags_relation`;
CREATE TABLE `config_tags_relation`  (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `tag_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'tag_name',
  `tag_type` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'tag_type',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_id',
  `nid` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`nid`) USING BTREE,
  UNIQUE INDEX `uk_configtagrelation_configidtag`(`id`, `tag_name`, `tag_type`) USING BTREE,
  INDEX `idx_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_tag_relation' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_tags_relation
-- ----------------------------

-- ----------------------------
-- Table structure for group_capacity
-- ----------------------------
DROP TABLE IF EXISTS `group_capacity`;
CREATE TABLE `group_capacity`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Group ID，空字符表示整个集群',
  `quota` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '配额，0表示使用默认值',
  `usage` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '使用量',
  `max_size` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '聚合子配置最大个数，，0表示使用默认值',
  `max_aggr_size` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大变更历史数量',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_group_id`(`group_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '集群、各Group容量信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of group_capacity
-- ----------------------------

-- ----------------------------
-- Table structure for his_config_info
-- ----------------------------
DROP TABLE IF EXISTS `his_config_info`;
CREATE TABLE `his_config_info`  (
  `id` bigint(64) UNSIGNED NOT NULL,
  `nid` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL,
  `src_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `op_type` char(10) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`nid`) USING BTREE,
  INDEX `idx_gmt_create`(`gmt_create`) USING BTREE,
  INDEX `idx_gmt_modified`(`gmt_modified`) USING BTREE,
  INDEX `idx_did`(`data_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 50 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '多租户改造' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of his_config_info
-- ----------------------------
INSERT INTO `his_config_info` VALUES (0, 1, 'ms-job-dev.yml', 'DEFAULT_GROUP', '', '# Spring\r\nspring: \r\n  datasource:\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://localhost:3306/ry-cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\r\n    username: root\r\n    password: root\r\n\r\n# Mybatis配置\r\nmybatis:\r\n    # 搜索指定包别名\r\n    typeAliasesPackage: com.ruoyi.job.domain\r\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\r\n    mapperLocations: classpath:mapper/**/*.xml\r\n\r\n# swagger 配置\r\nswagger:\r\n  title: 定时任务接口文档\r\n  license: Powered By xiaobing\r\n  licenseUrl: https://baidu\r\n  authorization:\r\n    name: ms OAuth\r\n    auth-regex: ^.*$\r\n    authorization-scope-list:\r\n      - scope: server\r\n        description: 客户端授权范围\r\n    token-url-list:\r\n      - http://localhost:8080/auth/oauth/login\r\n', '4c537ecdb7af19854ab6b5ef3855a4fe', '2020-09-17 10:42:11', '2020-09-17 10:42:11', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (7, 2, 'ruoyi-job-dev.yml', 'DEFAULT_GROUP', '', '# Spring\r\nspring: \r\n  datasource:\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://localhost:3306/ry-cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\r\n    username: root\r\n    password: password\r\n\r\n# Mybatis配置\r\nmybatis:\r\n    # 搜索指定包别名\r\n    typeAliasesPackage: com.ruoyi.job.domain\r\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\r\n    mapperLocations: classpath:mapper/**/*.xml\r\n\r\n# swagger 配置\r\nswagger:\r\n  title: 定时任务接口文档\r\n  license: Powered By ruoyi\r\n  licenseUrl: https://ruoyi.vip\r\n  authorization:\r\n    name: RuoYi OAuth\r\n    auth-regex: ^.*$\r\n    authorization-scope-list:\r\n      - scope: server\r\n        description: 客户端授权范围\r\n    token-url-list:\r\n      - http://localhost:8080/auth/oauth/token\r\n', '2904b375372b13f52baed5be2e497b21', '2020-09-17 10:42:20', '2020-09-17 10:42:21', NULL, '0:0:0:0:0:0:0:1', 'D', '');
INSERT INTO `his_config_info` VALUES (2, 3, 'ruoyi-gateway-dev.yml', 'DEFAULT_GROUP', '', 'spring:\r\n  redis:\r\n    host: localhost\r\n    port: 6379\r\n    password: \r\n  cloud:\r\n    gateway:\r\n      discovery:\r\n        locator:\r\n          lowerCaseServiceId: true\r\n          enabled: true\r\n      routes:\r\n        # 认证中心\r\n        - id: ruoyi-auth\r\n          uri: lb://ruoyi-auth\r\n          predicates:\r\n            - Path=/auth/**\r\n          filters:\r\n            # 验证码处理\r\n            - CacheRequestFilter\r\n            - ValidateCodeFilter\r\n            - StripPrefix=1\r\n        # 代码生成\r\n        - id: ruoyi-gen\r\n          uri: lb://ruoyi-gen\r\n          predicates:\r\n            - Path=/code/**\r\n          filters:\r\n            - StripPrefix=1\r\n        # 定时任务\r\n        - id: ruoyi-job\r\n          uri: lb://ruoyi-job\r\n          predicates:\r\n            - Path=/schedule/**\r\n          filters:\r\n            - StripPrefix=1\r\n        # 系统模块\r\n        - id: ruoyi-system\r\n          uri: lb://ruoyi-system\r\n          predicates:\r\n            - Path=/system/**\r\n          filters:\r\n            - StripPrefix=1\r\n\r\n# 不校验白名单\r\nignore:\r\n  whites:\r\n    - /auth/logout\r\n    - /auth/login\r\n    - /*/v2/api-docs\r\n    - /csrf\r\n', '679b21a74f71cb607944b7d9d03cffde', '2020-09-17 10:43:14', '2020-09-17 10:43:14', NULL, '0:0:0:0:0:0:0:1', 'U', '');
INSERT INTO `his_config_info` VALUES (0, 4, 'ms-gateway-dev.yml', 'DEFAULT_GROUP', '', 'spring:\r\n  redis:\r\n    host: localhost\r\n    port: 6379\r\n    password: \r\n  cloud:\r\n    gateway:\r\n      discovery:\r\n        locator:\r\n          lowerCaseServiceId: true\r\n          enabled: true\r\n      routes:\r\n        # 认证中心\r\n        - id: ms-auth\r\n          uri: lb://ms-auth\r\n          predicates:\r\n            - Path=/auth/**\r\n          filters:\r\n            # 验证码处理\r\n            - CacheRequestFilter\r\n            - ValidateCodeFilter\r\n            - StripPrefix=1\r\n        # # 代码生成\r\n        # - id: ms-gen\r\n        #   uri: lb://ms-gen\r\n        #   predicates:\r\n        #     - Path=/code/**\r\n        #   filters:\r\n        #     - StripPrefix=1\r\n        # 定时任务\r\n        - id: ms-job\r\n          uri: lb://ms-job\r\n          predicates:\r\n            - Path=/schedule/**\r\n          filters:\r\n            - StripPrefix=1\r\n\r\n# 不校验白名单\r\nignore:\r\n  whites:\r\n    - /auth/logout\r\n    - /auth/login\r\n    - /*/v2/api-docs\r\n    - /csrf\r\n', '7fe218696c084d91d537981f6a1c3bf7', '2020-09-17 10:43:58', '2020-09-17 10:43:58', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (2, 5, 'ruoyi-gateway-dev.yml', 'DEFAULT_GROUP', '', 'spring:\r\n  redis:\r\n    host: localhost\r\n    port: 6379\r\n    password: \r\n  cloud:\r\n    gateway:\r\n      discovery:\r\n        locator:\r\n          lowerCaseServiceId: true\r\n          enabled: true\r\n      routes:\r\n        # 认证中心\r\n        - id: ms-auth\r\n          uri: lb://ms-auth\r\n          predicates:\r\n            - Path=/auth/**\r\n          filters:\r\n            # 验证码处理\r\n            - CacheRequestFilter\r\n            - ValidateCodeFilter\r\n            - StripPrefix=1\r\n        # # 代码生成\r\n        # - id: ms-gen\r\n        #   uri: lb://ms-gen\r\n        #   predicates:\r\n        #     - Path=/code/**\r\n        #   filters:\r\n        #     - StripPrefix=1\r\n        # 定时任务\r\n        - id: ms-job\r\n          uri: lb://ms-job\r\n          predicates:\r\n            - Path=/schedule/**\r\n          filters:\r\n            - StripPrefix=1\r\n\r\n# 不校验白名单\r\nignore:\r\n  whites:\r\n    - /auth/logout\r\n    - /auth/login\r\n    - /*/v2/api-docs\r\n    - /csrf\r\n', '7fe218696c084d91d537981f6a1c3bf7', '2020-09-17 10:44:02', '2020-09-17 10:44:03', NULL, '0:0:0:0:0:0:0:1', 'D', '');
INSERT INTO `his_config_info` VALUES (8, 6, 'sentinel-ruoyi-gateway', 'DEFAULT_GROUP', '', '[\r\n    {\r\n        \"resource\": \"ruoyi-auth\",\r\n        \"count\": 500,\r\n        \"grade\": 1,\r\n        \"limitApp\": \"default\",\r\n        \"strategy\": 0,\r\n        \"controlBehavior\": 0\r\n    },\r\n	{\r\n        \"resource\": \"ruoyi-system\",\r\n        \"count\": 1000,\r\n        \"grade\": 1,\r\n        \"limitApp\": \"default\",\r\n        \"strategy\": 0,\r\n        \"controlBehavior\": 0\r\n    },\r\n	{\r\n        \"resource\": \"ruoyi-gen\",\r\n        \"count\": 200,\r\n        \"grade\": 1,\r\n        \"limitApp\": \"default\",\r\n        \"strategy\": 0,\r\n        \"controlBehavior\": 0\r\n    },\r\n	{\r\n        \"resource\": \"ruoyi-job\",\r\n        \"count\": 300,\r\n        \"grade\": 1,\r\n        \"limitApp\": \"default\",\r\n        \"strategy\": 0,\r\n        \"controlBehavior\": 0\r\n    }\r\n]', '9f3a3069261598f74220bc47958ec252', '2020-09-17 10:44:35', '2020-09-17 10:44:36', NULL, '0:0:0:0:0:0:0:1', 'U', '');
INSERT INTO `his_config_info` VALUES (0, 7, 'sentinel-ms-gateway', 'DEFAULT_GROUP', '', '[\r\n    {\r\n        \"resource\": \"ms-auth\",\r\n        \"count\": 500,\r\n        \"grade\": 1,\r\n        \"limitApp\": \"default\",\r\n        \"strategy\": 0,\r\n        \"controlBehavior\": 0\r\n    },\r\n	{\r\n        \"resource\": \"ms-gen\",\r\n        \"count\": 200,\r\n        \"grade\": 1,\r\n        \"limitApp\": \"default\",\r\n        \"strategy\": 0,\r\n        \"controlBehavior\": 0\r\n    },\r\n	{\r\n        \"resource\": \"ms-job\",\r\n        \"count\": 300,\r\n        \"grade\": 1,\r\n        \"limitApp\": \"default\",\r\n        \"strategy\": 0,\r\n        \"controlBehavior\": 0\r\n    }\r\n]', 'cb400d9199d3d8300f32f9588b80e682', '2020-09-17 10:44:53', '2020-09-17 10:44:54', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (8, 8, 'sentinel-ruoyi-gateway', 'DEFAULT_GROUP', '', '[\r\n    {\r\n        \"resource\": \"ms-auth\",\r\n        \"count\": 500,\r\n        \"grade\": 1,\r\n        \"limitApp\": \"default\",\r\n        \"strategy\": 0,\r\n        \"controlBehavior\": 0\r\n    },\r\n	{\r\n        \"resource\": \"ms-gen\",\r\n        \"count\": 200,\r\n        \"grade\": 1,\r\n        \"limitApp\": \"default\",\r\n        \"strategy\": 0,\r\n        \"controlBehavior\": 0\r\n    },\r\n	{\r\n        \"resource\": \"ms-job\",\r\n        \"count\": 300,\r\n        \"grade\": 1,\r\n        \"limitApp\": \"default\",\r\n        \"strategy\": 0,\r\n        \"controlBehavior\": 0\r\n    }\r\n]', 'cb400d9199d3d8300f32f9588b80e682', '2020-09-17 10:44:57', '2020-09-17 10:44:58', NULL, '0:0:0:0:0:0:0:1', 'D', '');
INSERT INTO `his_config_info` VALUES (0, 9, 'ms-gen-dev.yml', 'DEFAULT_GROUP', '', '# Spring\r\nspring: \r\n  datasource:\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://localhost:3306/ry-cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\r\n    username: root\r\n    password: password\r\n\r\n# Mybatis配置\r\nmybatis:\r\n    # 搜索指定包别名\r\n    typeAliasesPackage: com.ruoyi.gen.domain\r\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\r\n    mapperLocations: classpath:mapper/**/*.xml\r\n\r\n# swagger 配置\r\nswagger:\r\n  title: 代码生成接口文档\r\n  license: Powered By ruoyi\r\n  licenseUrl: https://ruoyi.vip\r\n  authorization:\r\n    name: RuoYi OAuth\r\n    auth-regex: ^.*$\r\n    authorization-scope-list:\r\n      - scope: server\r\n        description: 客户端授权范围\r\n    token-url-list:\r\n      - http://localhost:8080/auth/oauth/token\r\n\r\n# 代码生成\r\ngen: \r\n  # 作者\r\n  author: ruoyi\r\n  # 默认生成包路径 system 需改成自己的模块名称 如 system monitor tool\r\n  packageName: com.ruoyi.system\r\n  # 自动去除表前缀，默认是false\r\n  autoRemovePre: false\r\n  # 表前缀（生成类名不会包含表前缀，多个用逗号分隔）\r\n  tablePrefix: sys_\r\n', 'aa7e94e2abbdeb408bd8981391ab82f8', '2020-09-17 10:45:12', '2020-09-17 10:45:12', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (6, 10, 'ruoyi-gen-dev.yml', 'DEFAULT_GROUP', '', '# Spring\r\nspring: \r\n  datasource:\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://localhost:3306/ry-cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\r\n    username: root\r\n    password: password\r\n\r\n# Mybatis配置\r\nmybatis:\r\n    # 搜索指定包别名\r\n    typeAliasesPackage: com.ruoyi.gen.domain\r\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\r\n    mapperLocations: classpath:mapper/**/*.xml\r\n\r\n# swagger 配置\r\nswagger:\r\n  title: 代码生成接口文档\r\n  license: Powered By ruoyi\r\n  licenseUrl: https://ruoyi.vip\r\n  authorization:\r\n    name: RuoYi OAuth\r\n    auth-regex: ^.*$\r\n    authorization-scope-list:\r\n      - scope: server\r\n        description: 客户端授权范围\r\n    token-url-list:\r\n      - http://localhost:8080/auth/oauth/token\r\n\r\n# 代码生成\r\ngen: \r\n  # 作者\r\n  author: ruoyi\r\n  # 默认生成包路径 system 需改成自己的模块名称 如 system monitor tool\r\n  packageName: com.ruoyi.system\r\n  # 自动去除表前缀，默认是false\r\n  autoRemovePre: false\r\n  # 表前缀（生成类名不会包含表前缀，多个用逗号分隔）\r\n  tablePrefix: sys_\r\n', 'aa7e94e2abbdeb408bd8981391ab82f8', '2020-09-17 10:45:15', '2020-09-17 10:45:16', NULL, '0:0:0:0:0:0:0:1', 'D', '');
INSERT INTO `his_config_info` VALUES (0, 11, 'ms-system-dev.yml', 'DEFAULT_GROUP', '', '# Spring\r\nspring: \r\n  redis:\r\n    host: localhost\r\n    port: 6379\r\n    password: \r\n  datasource:\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://localhost:3306/ry-cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\r\n    username: root\r\n    password: password\r\n\r\n# Mybatis配置\r\nmybatis:\r\n    # 搜索指定包别名\r\n    typeAliasesPackage: com.ruoyi.system\r\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\r\n    mapperLocations: classpath:mapper/**/*.xml\r\n\r\n# swagger 配置\r\nswagger:\r\n  title: 系统模块接口文档\r\n  license: Powered By ruoyi\r\n  licenseUrl: https://ruoyi.vip\r\n  authorization:\r\n    name: RuoYi OAuth\r\n    auth-regex: ^.*$\r\n    authorization-scope-list:\r\n      - scope: server\r\n        description: 客户端授权范围\r\n    token-url-list:\r\n      - http://localhost:8080/auth/oauth/token\r\n', '06f95c879d284ec8031cc44805e62b50', '2020-09-17 10:45:29', '2020-09-17 10:45:29', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (5, 12, 'ruoyi-system-dev.yml', 'DEFAULT_GROUP', '', '# Spring\r\nspring: \r\n  redis:\r\n    host: localhost\r\n    port: 6379\r\n    password: \r\n  datasource:\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://localhost:3306/ry-cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\r\n    username: root\r\n    password: password\r\n\r\n# Mybatis配置\r\nmybatis:\r\n    # 搜索指定包别名\r\n    typeAliasesPackage: com.ruoyi.system\r\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\r\n    mapperLocations: classpath:mapper/**/*.xml\r\n\r\n# swagger 配置\r\nswagger:\r\n  title: 系统模块接口文档\r\n  license: Powered By ruoyi\r\n  licenseUrl: https://ruoyi.vip\r\n  authorization:\r\n    name: RuoYi OAuth\r\n    auth-regex: ^.*$\r\n    authorization-scope-list:\r\n      - scope: server\r\n        description: 客户端授权范围\r\n    token-url-list:\r\n      - http://localhost:8080/auth/oauth/token\r\n', '06f95c879d284ec8031cc44805e62b50', '2020-09-17 10:45:33', '2020-09-17 10:45:33', NULL, '0:0:0:0:0:0:0:1', 'D', '');
INSERT INTO `his_config_info` VALUES (0, 13, 'ms-auth-dev.yml', 'DEFAULT_GROUP', '', 'spring: \r\n  datasource:\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://localhost:3306/ry-cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\r\n    username: root\r\n    password: password\r\n  redis:\r\n    host: localhost\r\n    port: 6379\r\n    password: \r\n', '868c15010a7a15c027d4c90a48aabb3e', '2020-09-17 10:45:45', '2020-09-17 10:45:45', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (3, 14, 'ruoyi-auth-dev.yml', 'DEFAULT_GROUP', '', 'spring: \r\n  datasource:\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://localhost:3306/ry-cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\r\n    username: root\r\n    password: password\r\n  redis:\r\n    host: localhost\r\n    port: 6379\r\n    password: \r\n', '868c15010a7a15c027d4c90a48aabb3e', '2020-09-17 10:45:50', '2020-09-17 10:45:50', NULL, '0:0:0:0:0:0:0:1', 'D', '');
INSERT INTO `his_config_info` VALUES (0, 15, 'ms-monitor-dev.yml', 'DEFAULT_GROUP', '', '# Spring\r\nspring: \r\n  security:\r\n    user:\r\n      name: ruoyi\r\n      password: 123456\r\n  boot:\r\n    admin:\r\n      ui:\r\n        title: 若依服务状态监控\r\n', '8e49d78998a7780d780305aeefe4fb1b', '2020-09-17 10:46:01', '2020-09-17 10:46:02', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (4, 16, 'ruoyi-monitor-dev.yml', 'DEFAULT_GROUP', '', '# Spring\r\nspring: \r\n  security:\r\n    user:\r\n      name: ruoyi\r\n      password: 123456\r\n  boot:\r\n    admin:\r\n      ui:\r\n        title: 若依服务状态监控\r\n', '8e49d78998a7780d780305aeefe4fb1b', '2020-09-17 10:46:05', '2020-09-17 10:46:05', NULL, '0:0:0:0:0:0:0:1', 'D', '');
INSERT INTO `his_config_info` VALUES (11, 17, 'ms-gateway-dev.yml', 'DEFAULT_GROUP', '', 'spring:\r\n  redis:\r\n    host: localhost\r\n    port: 6379\r\n    password: \r\n  cloud:\r\n    gateway:\r\n      discovery:\r\n        locator:\r\n          lowerCaseServiceId: true\r\n          enabled: true\r\n      routes:\r\n        # 认证中心\r\n        - id: ms-auth\r\n          uri: lb://ms-auth\r\n          predicates:\r\n            - Path=/auth/**\r\n          filters:\r\n            # 验证码处理\r\n            - CacheRequestFilter\r\n            - ValidateCodeFilter\r\n            - StripPrefix=1\r\n        # # 代码生成\r\n        # - id: ms-gen\r\n        #   uri: lb://ms-gen\r\n        #   predicates:\r\n        #     - Path=/code/**\r\n        #   filters:\r\n        #     - StripPrefix=1\r\n        # 定时任务\r\n        - id: ms-job\r\n          uri: lb://ms-job\r\n          predicates:\r\n            - Path=/schedule/**\r\n          filters:\r\n            - StripPrefix=1\r\n\r\n# 不校验白名单\r\nignore:\r\n  whites:\r\n    - /auth/logout\r\n    - /auth/login\r\n    - /*/v2/api-docs\r\n    - /csrf\r\n', '7fe218696c084d91d537981f6a1c3bf7', '2020-09-17 14:19:39', '2020-09-17 14:19:39', NULL, '0:0:0:0:0:0:0:1', 'U', '');
INSERT INTO `his_config_info` VALUES (11, 18, 'ms-gateway-dev.yml', 'DEFAULT_GROUP', '', 'spring:\r\n  redis:\r\n    host: localhost\r\n    port: 6379\r\n    password: \r\n  cloud:\r\n    gateway:\r\n      discovery:\r\n        locator:\r\n          lowerCaseServiceId: true\r\n          enabled: true\r\n      routes:\r\n        # 认证中心\r\n        - id: ms-auth\r\n          uri: lb://ms-auth\r\n          predicates:\r\n            - Path=/auth/**\r\n        # # 代码生成\r\n        # - id: ms-gen\r\n        #   uri: lb://ms-gen\r\n        #   predicates:\r\n        #     - Path=/code/**\r\n        #   filters:\r\n        #     - StripPrefix=1\r\n        # 定时任务\r\n        - id: ms-job\r\n          uri: lb://ms-job\r\n          predicates:\r\n            - Path=/schedule/**\r\n          filters:\r\n            - StripPrefix=1\r\n\r\n# 不校验白名单\r\nignore:\r\n  whites:\r\n    - /auth/logout\r\n    - /auth/login\r\n    - /*/v2/api-docs\r\n    - /csrf\r\n', '50dfd85a48dc74aded49acef26160d26', '2020-09-17 14:23:47', '2020-09-17 14:23:47', NULL, '0:0:0:0:0:0:0:1', 'U', '');
INSERT INTO `his_config_info` VALUES (11, 19, 'ms-gateway-dev.yml', 'DEFAULT_GROUP', '', 'spring:\r\n  redis:\r\n    host: localhost\r\n    port: 6379\r\n    password: \r\n  cloud:\r\n    gateway:\r\n      discovery:\r\n        locator:\r\n          lowerCaseServiceId: true\r\n          enabled: true\r\n      routes:\r\n        # 认证中心\r\n        - id: ms-auth\r\n          uri: lb://ms-auth\r\n          predicates:\r\n            - Path=/auth/**\r\n        # # 代码生成\r\n        # - id: ms-gen\r\n        #   uri: lb://ms-gen\r\n        #   predicates:\r\n        #     - Path=/code/**\r\n        #   filters:\r\n        #     - StripPrefix=1\r\n        # 定时任务\r\n        - id: ms-job\r\n          uri: lb://ms-job\r\n          predicates:\r\n            - Path=/schedule/**\r\n          filters:\r\n            - StripPrefix=1\r\n\r\n# 不校验白名单\r\nignore:\r\n  whites:\r\n    - /auth/logout\r\n    - /auth/login\r\n    - /*/v2/api-docs\r\n    - /csrf\r\n', '50dfd85a48dc74aded49acef26160d26', '2020-09-17 16:10:56', '2020-09-17 16:10:56', NULL, '0:0:0:0:0:0:0:1', 'U', '');
INSERT INTO `his_config_info` VALUES (11, 20, 'ms-gateway-dev.yml', 'DEFAULT_GROUP', '', 'spring:\r\n  redis:\r\n    host: localhost\r\n    port: 6379\r\n    password: \r\n  cloud:\r\n    gateway:\r\n      discovery:\r\n        locator:\r\n          lowerCaseServiceId: true\r\n          enabled: true\r\n      routes:\r\n        # 认证中心\r\n        - id: ms-auth\r\n          uri: lb://ms-auth\r\n          predicates:\r\n            - Path=/auth/**\r\n        # # 代码生成\r\n        # - id: ms-gen\r\n        #   uri: lb://ms-gen\r\n        #   predicates:\r\n        #     - Path=/code/**\r\n        #   filters:\r\n        #     - StripPrefix=1\r\n        # 定时任务\r\n        - id: ms-job\r\n          uri: lb://ms-job\r\n          predicates:\r\n            - Path=/schedule/**\r\n          filters:\r\n            - StripPrefix=1\r\n\r\n# 不校验白名单\r\nignore:\r\n  whites:\r\n    - /auth/logout\r\n    - /auth/login\r\n    - /*/v2/api-docs\r\n    - /csrf\r\n    - /swagger\r\n', '6a673679c3845f7bca91f13b3ee045be', '2020-09-17 16:11:06', '2020-09-17 16:11:06', NULL, '0:0:0:0:0:0:0:1', 'U', '');
INSERT INTO `his_config_info` VALUES (9, 21, 'ms-job-dev.yml', 'DEFAULT_GROUP', '', '# Spring\r\nspring: \r\n  datasource:\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://localhost:3306/ry-cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\r\n    username: root\r\n    password: root\r\n\r\n# Mybatis配置\r\nmybatis:\r\n    # 搜索指定包别名\r\n    typeAliasesPackage: com.ruoyi.job.domain\r\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\r\n    mapperLocations: classpath:mapper/**/*.xml\r\n\r\n# swagger 配置\r\nswagger:\r\n  title: 定时任务接口文档\r\n  license: Powered By xiaobing\r\n  licenseUrl: https://baidu\r\n  authorization:\r\n    name: ms OAuth\r\n    auth-regex: ^.*$\r\n    authorization-scope-list:\r\n      - scope: server\r\n        description: 客户端授权范围\r\n    token-url-list:\r\n      - http://localhost:8080/auth/oauth/login\r\n', '4c537ecdb7af19854ab6b5ef3855a4fe', '2020-09-17 16:20:22', '2020-09-17 16:20:23', NULL, '0:0:0:0:0:0:0:1', 'U', '');
INSERT INTO `his_config_info` VALUES (16, 22, 'ms-auth-dev.yml', 'DEFAULT_GROUP', '', 'spring: \r\n  datasource:\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://localhost:3306/ry-cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\r\n    username: root\r\n    password: password\r\n  redis:\r\n    host: localhost\r\n    port: 6379\r\n    password: \r\n', '868c15010a7a15c027d4c90a48aabb3e', '2020-09-17 16:20:43', '2020-09-17 16:20:43', NULL, '0:0:0:0:0:0:0:1', 'U', '');
INSERT INTO `his_config_info` VALUES (11, 23, 'ms-gateway-dev.yml', 'DEFAULT_GROUP', '', 'spring:\r\n  redis:\r\n    host: localhost\r\n    port: 6379\r\n    password: \r\n  cloud:\r\n    gateway:\r\n      discovery:\r\n        locator:\r\n          lowerCaseServiceId: true\r\n          enabled: true\r\n      routes:\r\n        # 认证中心\r\n        - id: ms-auth\r\n          uri: lb://ms-auth\r\n          predicates:\r\n            - Path=/auth/**\r\n        # # 代码生成\r\n        # - id: ms-gen\r\n        #   uri: lb://ms-gen\r\n        #   predicates:\r\n        #     - Path=/code/**\r\n        #   filters:\r\n        #     - StripPrefix=1\r\n        # 定时任务\r\n        - id: ms-job\r\n          uri: lb://ms-job\r\n          predicates:\r\n            - Path=/schedule/**\r\n          filters:\r\n            - StripPrefix=1\r\n\r\n# 不校验白名单\r\nignore:\r\n  whites:\r\n    - /auth/logout\r\n    - /auth/login\r\n    - /*/v2/api-docs\r\n    - /csrf\r\n    - /auth/swagger\r\n', 'f880c8859babd47ad9272b245c2be88c', '2020-09-17 16:36:32', '2020-09-17 16:36:33', NULL, '0:0:0:0:0:0:0:1', 'U', '');
INSERT INTO `his_config_info` VALUES (11, 24, 'ms-gateway-dev.yml', 'DEFAULT_GROUP', '', 'spring:\r\n  redis:\r\n    host: localhost\r\n    port: 6379\r\n    password: \r\n  cloud:\r\n    gateway:\r\n      discovery:\r\n        locator:\r\n          lowerCaseServiceId: true\r\n          enabled: true\r\n      routes:\r\n        # 认证中心\r\n        - id: ms-auth\r\n          uri: lb://ms-auth\r\n          predicates:\r\n            - Path=/auth/**\r\n          filters:\r\n            - StripPrefix=1\r\n\r\n        # # 代码生成\r\n        # - id: ms-gen\r\n        #   uri: lb://ms-gen\r\n        #   predicates:\r\n        #     - Path=/code/**\r\n        #   filters:\r\n        #     - StripPrefix=1\r\n        # 定时任务\r\n        - id: ms-job\r\n          uri: lb://ms-job\r\n          predicates:\r\n            - Path=/schedule/**\r\n          filters:\r\n            - StripPrefix=1\r\n\r\n# 不校验白名单\r\nignore:\r\n  whites:\r\n    - /auth/logout\r\n    - /auth/login\r\n    - /*/v2/api-docs\r\n    - /csrf\r\n    - /auth/swagger\r\n', '4104098e8da3028ac907d5672554b7c3', '2020-09-17 16:51:51', '2020-09-17 16:51:51', NULL, '0:0:0:0:0:0:0:1', 'U', '');
INSERT INTO `his_config_info` VALUES (11, 25, 'ms-gateway-dev.yml', 'DEFAULT_GROUP', '', 'spring:\r\n  redis:\r\n    host: localhost\r\n    port: 6379\r\n    password: \r\n  cloud:\r\n    gateway:\r\n      discovery:\r\n        locator:\r\n          lowerCaseServiceId: true\r\n          enabled: true\r\n      routes:\r\n        # 认证中心\r\n        - id: ms-auth\r\n          uri: lb://ms-auth\r\n          predicates:\r\n            - Path=/auth/**\r\n          filters:\r\n            - StripPrefix=1\r\n\r\n        # # 代码生成\r\n        # - id: ms-gen\r\n        #   uri: lb://ms-gen\r\n        #   predicates:\r\n        #     - Path=/code/**\r\n        #   filters:\r\n        #     - StripPrefix=1\r\n        # 定时任务\r\n        - id: ms-job\r\n          uri: lb://ms-job\r\n          predicates:\r\n            - Path=/schedule/**\r\n          filters:\r\n            - StripPrefix=1\r\n\r\n# 不校验白名单\r\nignore:\r\n  whites:\r\n    - /auth/logout\r\n    - /auth/login\r\n    - /*/v2/api-docs\r\n    - /csrf\r\n    - /*/swagger\r\n', '1abec3a20385f63215739b5fa1fccffb', '2020-09-17 16:52:06', '2020-09-17 16:52:07', NULL, '0:0:0:0:0:0:0:1', 'U', '');
INSERT INTO `his_config_info` VALUES (11, 26, 'ms-gateway-dev.yml', 'DEFAULT_GROUP', '', 'spring:\r\n  redis:\r\n    host: localhost\r\n    port: 6379\r\n    password: \r\n  cloud:\r\n    gateway:\r\n      discovery:\r\n        locator:\r\n          lowerCaseServiceId: true\r\n          enabled: true\r\n      routes:\r\n        # 认证中心\r\n        - id: ms-auth\r\n          uri: lb://ms-auth\r\n          predicates:\r\n            - Path=/auth/**\r\n          filters:\r\n            - StripPrefix=1\r\n\r\n        # # 代码生成\r\n        # - id: ms-gen\r\n        #   uri: lb://ms-gen\r\n        #   predicates:\r\n        #     - Path=/code/**\r\n        #   filters:\r\n        #     - StripPrefix=1\r\n        # 定时任务\r\n        - id: ms-job\r\n          uri: lb://ms-job\r\n          predicates:\r\n            - Path=/schedule/**\r\n          filters:\r\n            - StripPrefix=1\r\n\r\n# 不校验白名单\r\nignore:\r\n  whites:\r\n    - /auth/logout\r\n    - /auth/login\r\n    - /*/v2/api-docs\r\n    - /csrf\r\n    - /*/swagger-ui.html\r\n', 'c674db0ba33a82f577be25d01073b3ef', '2020-09-17 16:52:58', '2020-09-17 16:52:58', NULL, '0:0:0:0:0:0:0:1', 'U', '');
INSERT INTO `his_config_info` VALUES (9, 27, 'ms-job-dev.yml', 'DEFAULT_GROUP', '', '# Spring\r\nspring: \r\n  datasource:\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://localhost:3306/grade_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\r\n    username: root\r\n    password: root\r\n\r\n# Mybatis配置\r\nmybatis:\r\n    # 搜索指定包别名\r\n    typeAliasesPackage: com.ruoyi.job.domain\r\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\r\n    mapperLocations: classpath:mapper/**/*.xml\r\n\r\n# swagger 配置\r\nswagger:\r\n  title: 定时任务接口文档\r\n  license: Powered By xiaobing\r\n  licenseUrl: https://baidu\r\n  authorization:\r\n    name: ms OAuth\r\n    auth-regex: ^.*$\r\n    authorization-scope-list:\r\n      - scope: server\r\n        description: 客户端授权范围\r\n    token-url-list:\r\n      - http://localhost:8080/auth/oauth/login\r\n', '6ce6ba5a7f054cae7ec6e8352ac97d01', '2020-09-17 16:56:08', '2020-09-17 16:56:08', NULL, '0:0:0:0:0:0:0:1', 'U', '');
INSERT INTO `his_config_info` VALUES (9, 28, 'ms-job-dev.yml', 'DEFAULT_GROUP', '', '# Spring\r\nspring: \r\n  datasource:\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://localhost:3306/grade_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\r\n    username: root\r\n    password: root\r\n\r\n# Mybatis配置\r\nmybatis:\r\n    # 搜索指定包别名\r\n    typeAliasesPackage: com.ruoyi.job.domain\r\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\r\n    mapperLocations: classpath:mapper/**/*.xml\r\n\r\n# swagger 配置\r\nswagger:\r\n  title: 定时任务接口文档\r\n  license: Powered By xiaobing\r\n  licenseUrl: https://baidu\r\n  authorization:\r\n    name: ms OAuth\r\n    auth-regex: ^.*$\r\n    authorization-scope-list:\r\n      - scope: server\r\n        description: 客户端授权范围\r\n    token-url-list:\r\n      - http://localhost:8080/auth/login\r\n', '47541dc16500cef54b78c264ce1764e8', '2020-09-17 16:56:55', '2020-09-17 16:56:56', NULL, '0:0:0:0:0:0:0:1', 'U', '');
INSERT INTO `his_config_info` VALUES (16, 29, 'ms-auth-dev.yml', 'DEFAULT_GROUP', '', 'spring: \r\n  datasource:\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://localhost:3306/grade_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\r\n    username: root\r\n    password: password\r\n  redis:\r\n    host: localhost\r\n    port: 6379\r\n    password: \r\n', 'cc71a2fe0a17d46c8b6414c97851a70a', '2020-09-17 16:57:10', '2020-09-17 16:57:11', NULL, '0:0:0:0:0:0:0:1', 'U', '');
INSERT INTO `his_config_info` VALUES (11, 30, 'ms-gateway-dev.yml', 'DEFAULT_GROUP', '', 'spring:\r\n  redis:\r\n    host: localhost\r\n    port: 6379\r\n    password: \r\n  cloud:\r\n    gateway:\r\n      discovery:\r\n        locator:\r\n          lowerCaseServiceId: true\r\n          enabled: true\r\n      routes:\r\n        # 认证中心\r\n        - id: ms-auth\r\n          uri: lb://ms-auth\r\n          predicates:\r\n            - Path=/auth/**\r\n          filters:\r\n            - StripPrefix=1\r\n\r\n        # # 代码生成\r\n        # - id: ms-gen\r\n        #   uri: lb://ms-gen\r\n        #   predicates:\r\n        #     - Path=/code/**\r\n        #   filters:\r\n        #     - StripPrefix=1\r\n        # 定时任务\r\n        - id: ms-job\r\n          uri: lb://ms-job\r\n          predicates:\r\n            - Path=/schedule/**\r\n          filters:\r\n            - StripPrefix=1\r\n\r\n# 不校验白名单\r\nignore:\r\n  whites:\r\n    - /auth/logout\r\n    - /auth/**\r\n    - /*/v2/api-docs\r\n    - /csrf\r\n    - /*/swagger-ui.html\r\n', 'd0608273b4fc1c3216a87840e3e120b6', '2020-09-17 16:59:04', '2020-09-17 16:59:04', NULL, '0:0:0:0:0:0:0:1', 'U', '');
INSERT INTO `his_config_info` VALUES (11, 31, 'ms-gateway-dev.yml', 'DEFAULT_GROUP', '', 'spring:\r\n  redis:\r\n    host: localhost\r\n    port: 6379\r\n    password: \r\n  cloud:\r\n    gateway:\r\n      discovery:\r\n        locator:\r\n          lowerCaseServiceId: true\r\n          enabled: true\r\n      routes:\r\n        # 认证中心\r\n        - id: ms-auth\r\n          uri: lb://ms-auth\r\n          predicates:\r\n            - Path=/auth/**\r\n          filters:\r\n            - StripPrefix=1\r\n\r\n        # # 代码生成\r\n        # - id: ms-gen\r\n        #   uri: lb://ms-gen\r\n        #   predicates:\r\n        #     - Path=/code/**\r\n        #   filters:\r\n        #     - StripPrefix=1\r\n        # 定时任务\r\n        - id: ms-job\r\n          uri: lb://ms-job\r\n          predicates:\r\n            - Path=/schedule/**\r\n          filters:\r\n            - StripPrefix=1\r\n\r\n# 不校验白名单\r\nignore:\r\n  whites:\r\n    - /auth/logout\r\n    - /auth/**\r\n    - /**/v2/api-docs\r\n    - /csrf\r\n    - /*/swagger-ui.html\r\n', '72b9aa4c7c2b9f0ea7924945281b8db6', '2020-09-17 17:00:23', '2020-09-17 17:00:24', NULL, '0:0:0:0:0:0:0:1', 'U', '');
INSERT INTO `his_config_info` VALUES (11, 32, 'ms-gateway-dev.yml', 'DEFAULT_GROUP', '', 'spring:\r\n  redis:\r\n    host: localhost\r\n    port: 6379\r\n    password: \r\n  cloud:\r\n    gateway:\r\n      discovery:\r\n        locator:\r\n          lowerCaseServiceId: true\r\n          enabled: true\r\n      routes:\r\n        # 认证中心\r\n        - id: ms-auth\r\n          uri: lb://ms-auth\r\n          predicates:\r\n            - Path=/auth/**\r\n          filters:\r\n            - StripPrefix=1\r\n\r\n        # # 代码生成\r\n        # - id: ms-gen\r\n        #   uri: lb://ms-gen\r\n        #   predicates:\r\n        #     - Path=/code/**\r\n        #   filters:\r\n        #     - StripPrefix=1\r\n        # 定时任务\r\n        - id: ms-job\r\n          uri: lb://ms-job\r\n          predicates:\r\n            - Path=/schedule/**\r\n          filters:\r\n            - StripPrefix=1\r\n\r\n# 不校验白名单\r\nignore:\r\n  whites:\r\n    - /auth/logout\r\n    - /auth/**\r\n    - /schedule/v2/api-docs\r\n    - /auth/v2/api-docs\r\n    - /csrf\r\n    - /*/swagger-ui.html\r\n', '0a13cc0a2eee5369f0f9837a0e3efa2a', '2020-09-17 17:00:35', '2020-09-17 17:00:36', NULL, '0:0:0:0:0:0:0:1', 'U', '');
INSERT INTO `his_config_info` VALUES (16, 33, 'ms-auth-dev.yml', 'DEFAULT_GROUP', '', 'spring: \r\n  datasource:\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://localhost:3306/grade_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\r\n    username: root\r\n    password: password\r\n  redis:\r\n    host: localhost\r\n    port: 6379\r\n    password: \r\n# swagger 配置\r\nswagger:\r\n  title: 定时任务接口文档\r\n  license: Powered By xiaobing\r\n  licenseUrl: https://baidu\r\n  authorization:\r\n    name: ms OAuth\r\n    auth-regex: ^.*$\r\n    authorization-scope-list:\r\n      - scope: server\r\n        description: 客户端授权范围\r\n    token-url-list:\r\n      - http://localhost:8080/auth/login\r\n', 'f738c38f28671f2563c1f8e8c2435fb4', '2020-09-17 17:02:54', '2020-09-17 17:02:54', NULL, '0:0:0:0:0:0:0:1', 'U', '');
INSERT INTO `his_config_info` VALUES (16, 34, 'ms-auth-dev.yml', 'DEFAULT_GROUP', '', 'spring: \r\n  datasource:\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://localhost:3306/grade_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\r\n    username: root\r\n    password: root\r\n  redis:\r\n    host: localhost\r\n    port: 6379\r\n    password: \r\n# swagger 配置\r\nswagger:\r\n  title: 定时任务接口文档\r\n  license: Powered By xiaobing\r\n  licenseUrl: https://baidu\r\n  authorization:\r\n    name: ms OAuth\r\n    auth-regex: ^.*$\r\n    authorization-scope-list:\r\n      - scope: server\r\n        description: 客户端授权范围\r\n    token-url-list:\r\n      - http://localhost:8080/auth/login\r\n', '23374833b472e9169c8f926060445d24', '2020-09-17 17:31:51', '2020-09-17 17:31:51', NULL, '0:0:0:0:0:0:0:1', 'U', '');
INSERT INTO `his_config_info` VALUES (16, 35, 'ms-auth-dev.yml', 'DEFAULT_GROUP', '', 'spring: \r\n  datasource:\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://localhost:3306/grade_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\r\n    username: root\r\n    password: root\r\n  redis:\r\n    host: localhost\r\n    port: 6379\r\n    password: \r\n# swagger 配置\r\nswagger:\r\n  title: 定时任务接口文档\r\n  license: Powered By xiaobing\r\n  licenseUrl: https://baidu\r\n  authorization:\r\n    name: ms OAuth\r\n    auth-regex: ^.*$\r\n    authorization-scope-list:\r\n      - scope: server\r\n        description: 客户端授权范围\r\n    token-url-list:\r\n      - http://localhost:9200/auth/login\r\n', 'fcfb67477b6f6333c7936cf0ac91b2ed', '2020-09-17 17:32:32', '2020-09-17 17:32:33', NULL, '0:0:0:0:0:0:0:1', 'U', '');
INSERT INTO `his_config_info` VALUES (16, 36, 'ms-auth-dev.yml', 'DEFAULT_GROUP', '', 'spring: \r\n  datasource:\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://localhost:3306/grade_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\r\n    username: root\r\n    password: root\r\n  redis:\r\n    host: localhost\r\n    port: 6379\r\n    password: \r\n# swagger 配置\r\nswagger:\r\n  title: 定时任务接口文档\r\n  license: Powered By xiaobing\r\n  licenseUrl: https://baidu\r\n  authorization:\r\n    name: ms OAuth\r\n    auth-regex: ^.*$\r\n    authorization-scope-list:\r\n      - scope: server\r\n        description: 客户端授权范围\r\n    token-url-list:\r\n      - http://localhost:9200/auth/login\r\n', 'fcfb67477b6f6333c7936cf0ac91b2ed', '2020-09-17 17:33:43', '2020-09-17 17:33:44', NULL, '0:0:0:0:0:0:0:1', 'U', '');
INSERT INTO `his_config_info` VALUES (11, 37, 'ms-gateway-dev.yml', 'DEFAULT_GROUP', '', 'spring:\r\n  redis:\r\n    host: localhost\r\n    port: 6379\r\n    password: \r\n  cloud:\r\n    gateway:\r\n      discovery:\r\n        locator:\r\n          lowerCaseServiceId: true\r\n          enabled: true\r\n      routes:\r\n        # 认证中心\r\n        - id: ms-auth\r\n          uri: lb://ms-auth\r\n          predicates:\r\n            - Path=/auth/**\r\n\r\n        # # 代码生成\r\n        # - id: ms-gen\r\n        #   uri: lb://ms-gen\r\n        #   predicates:\r\n        #     - Path=/code/**\r\n        #   filters:\r\n        #     - StripPrefix=1\r\n        # 定时任务\r\n        - id: ms-job\r\n          uri: lb://ms-job\r\n          predicates:\r\n            - Path=/schedule/**\r\n\r\n# 不校验白名单\r\nignore:\r\n  whites:\r\n    - /auth/logout\r\n    - /auth/**\r\n    - /schedule/v2/api-docs\r\n    - /auth/v2/api-docs\r\n    - /csrf\r\n    - /*/swagger-ui.html\r\n', '02d02bb2665d54a0bf4d9d2c92ea4024', '2020-09-17 19:52:42', '2020-09-17 19:52:42', NULL, '0:0:0:0:0:0:0:1', 'U', '');
INSERT INTO `his_config_info` VALUES (13, 38, 'sentinel-ms-gateway', 'DEFAULT_GROUP', '', '[\r\n    {\r\n        \"resource\": \"ms-auth\",\r\n        \"count\": 500,\r\n        \"grade\": 1,\r\n        \"limitApp\": \"default\",\r\n        \"strategy\": 0,\r\n        \"controlBehavior\": 0\r\n    },\r\n	{\r\n        \"resource\": \"ms-gen\",\r\n        \"count\": 200,\r\n        \"grade\": 1,\r\n        \"limitApp\": \"default\",\r\n        \"strategy\": 0,\r\n        \"controlBehavior\": 0\r\n    },\r\n	{\r\n        \"resource\": \"ms-job\",\r\n        \"count\": 300,\r\n        \"grade\": 1,\r\n        \"limitApp\": \"default\",\r\n        \"strategy\": 0,\r\n        \"controlBehavior\": 0\r\n    }\r\n]', 'cb400d9199d3d8300f32f9588b80e682', '2020-09-17 19:54:02', '2020-09-17 19:54:02', NULL, '0:0:0:0:0:0:0:1', 'U', '');
INSERT INTO `his_config_info` VALUES (11, 39, 'ms-gateway-dev.yml', 'DEFAULT_GROUP', '', 'spring:\r\n  redis:\r\n    host: localhost\r\n    port: 6379\r\n    password: \r\n  cloud:\r\n    gateway:\r\n      discovery:\r\n        locator:\r\n          lowerCaseServiceId: true\r\n          enabled: true\r\n      routes:\r\n        # 认证中心\r\n        - id: ms-auth\r\n          uri: lb://ms-auth\r\n          predicates:\r\n            - Path=/auth/**\r\n          filters:\r\n            - StripPrefix=1\r\n        # # 代码生成\r\n        # - id: ms-gen\r\n        #   uri: lb://ms-gen\r\n        #   predicates:\r\n        #     - Path=/code/**\r\n        #   filters:\r\n        #     - StripPrefix=1\r\n        # 定时任务\r\n        - id: ms-job\r\n          uri: lb://ms-job\r\n          predicates:\r\n            - Path=/schedule/**\r\n          filters:\r\n            - StripPrefix=1\r\n\r\n# 不校验白名单\r\nignore:\r\n  whites:\r\n    - /auth/logout\r\n    - /auth/**\r\n    - /schedule/v2/api-docs\r\n    - /auth/v2/api-docs\r\n    - /csrf\r\n    - /*/swagger-ui.html\r\n', 'bde74f7694296ce4982cdf7c0ebd551d', '2020-09-17 19:54:40', '2020-09-17 19:54:40', NULL, '0:0:0:0:0:0:0:1', 'U', '');
INSERT INTO `his_config_info` VALUES (0, 40, 'ms-notice-dev.yml', 'DEFAULT_GROUP', '', '# Spring\r\nspring: \r\n  datasource:\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://localhost:3306/grade_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\r\n    username: root\r\n    password: root\r\n\r\n# Mybatis配置\r\nmybatis:\r\n    # 搜索指定包别名\r\n    typeAliasesPackage: com.ruoyi.job.domain\r\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\r\n    mapperLocations: classpath:mapper/**/*.xml\r\n\r\n# swagger 配置\r\nswagger:\r\n  title: 定时任务接口文档\r\n  license: Powered By xiaobing\r\n  licenseUrl: https://baidu\r\n  authorization:\r\n    name: ms OAuth\r\n    auth-regex: ^.*$\r\n    authorization-scope-list:\r\n      - scope: server\r\n        description: 客户端授权范围\r\n    token-url-list:\r\n      - http://localhost:8080/auth/login\r\n', '47541dc16500cef54b78c264ce1764e8', '2020-09-17 20:00:28', '2020-09-17 20:00:28', NULL, '0:0:0:0:0:0:0:1', 'I', '');
INSERT INTO `his_config_info` VALUES (41, 41, 'ms-notice-dev.yml', 'DEFAULT_GROUP', '', '# Spring\r\nspring: \r\n  datasource:\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://localhost:3306/grade_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\r\n    username: root\r\n    password: root\r\n\r\n# Mybatis配置\r\nmybatis:\r\n    # 搜索指定包别名\r\n    typeAliasesPackage: com.ruoyi.job.domain\r\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\r\n    mapperLocations: classpath:mapper/**/*.xml\r\n\r\n# swagger 配置\r\nswagger:\r\n  title: 定时任务接口文档\r\n  license: Powered By xiaobing\r\n  licenseUrl: https://baidu\r\n  authorization:\r\n    name: ms OAuth\r\n    auth-regex: ^.*$\r\n    authorization-scope-list:\r\n      - scope: server\r\n        description: 客户端授权范围\r\n    token-url-list:\r\n      - http://localhost:8080/auth/login\r\n', '47541dc16500cef54b78c264ce1764e8', '2020-09-17 20:01:06', '2020-09-17 20:01:07', NULL, '0:0:0:0:0:0:0:1', 'U', '');
INSERT INTO `his_config_info` VALUES (41, 42, 'ms-notice-dev.yml', 'DEFAULT_GROUP', '', '# Spring\r\nspring: \r\n  datasource:\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://localhost:3306/grade_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\r\n    username: root\r\n    password: root\r\n\r\n# Mybatis配置\r\nmybatis:\r\n    # 搜索指定包别名\r\n    typeAliasesPackage: com.ruoyi.job.domain\r\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\r\n    mapperLocations: classpath:mapper/**/*.xml\r\n\r\n# swagger 配置\r\nswagger:\r\n  title: 通知接口文档\r\n  license: Powered By xiaobing\r\n  licenseUrl: https://baidu\r\n  authorization:\r\n    name: ms OAuth\r\n    auth-regex: ^.*$\r\n    authorization-scope-list:\r\n      - scope: server\r\n        description: 客户端授权范围\r\n    token-url-list:\r\n      - http://localhost:8080/auth/login\r\n', '947d747a5868eae7d749d2d431652ac3', '2020-09-17 20:01:53', '2020-09-17 20:01:53', NULL, '0:0:0:0:0:0:0:1', 'U', '');
INSERT INTO `his_config_info` VALUES (11, 43, 'ms-gateway-dev.yml', 'DEFAULT_GROUP', '', 'spring:\r\n  redis:\r\n    host: localhost\r\n    port: 6379\r\n    password: \r\n  cloud:\r\n    gateway:\r\n      discovery:\r\n        locator:\r\n          lowerCaseServiceId: true\r\n          enabled: true\r\n      routes:\r\n        # 认证中心\r\n        - id: ms-auth\r\n          uri: lb://ms-auth\r\n          predicates:\r\n            - Path=/auth/**\r\n          filters:\r\n            - StripPrefix=1\r\n        # # 代码生成\r\n        # - id: ms-gen\r\n        #   uri: lb://ms-gen\r\n        #   predicates:\r\n        #     - Path=/code/**\r\n        #   filters:\r\n        #     - StripPrefix=1\r\n        # 定时任务\r\n        - id: ms-job\r\n          uri: lb://ms-job\r\n          predicates:\r\n            - Path=/schedule/**\r\n          filters:\r\n            - StripPrefix=1\r\n\r\n# 不校验白名单\r\nignore:\r\n  whites:\r\n    - /auth/logout\r\n    - /auth/**\r\n    - /schedule/v2/api-docs\r\n    - /auth/v2/api-docs\r\n    - /csrf\r\n    - /*/swagger-ui.html\r\n', 'bde74f7694296ce4982cdf7c0ebd551d', '2020-09-17 20:03:28', '2020-09-17 20:03:28', NULL, '0:0:0:0:0:0:0:1', 'U', '');
INSERT INTO `his_config_info` VALUES (16, 44, 'ms-auth-dev.yml', 'DEFAULT_GROUP', '', 'spring: \r\n  datasource:\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://localhost:3306/grade_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\r\n    username: root\r\n    password: root\r\n  redis:\r\n    host: localhost\r\n    port: 6379\r\n    password: \r\n# swagger 配置\r\nswagger:\r\n  title: 定时任务接口文档\r\n  license: Powered By xiaobing\r\n  licenseUrl: https://baidu\r\n  authorization:\r\n    name: ms OAuth\r\n    auth-regex: ^.*$\r\n    authorization-scope-list:\r\n      - scope: server\r\n        description: 客户端授权范围\r\n    token-url-list:\r\n      - http://localhost:9200/login\r\n', 'f8cb5db76d1d6c076d7c43d820873d1c', '2020-09-17 20:05:22', '2020-09-17 20:05:22', NULL, '0:0:0:0:0:0:0:1', 'U', '');
INSERT INTO `his_config_info` VALUES (11, 45, 'ms-gateway-dev.yml', 'DEFAULT_GROUP', '', 'spring:\r\n  redis:\r\n    host: localhost\r\n    port: 6379\r\n    password: \r\n  cloud:\r\n    gateway:\r\n      discovery:\r\n        locator:\r\n          lowerCaseServiceId: true\r\n          enabled: true\r\n      routes:\r\n        # 认证中心\r\n        - id: ms-auth\r\n          uri: lb://ms-auth\r\n          predicates:\r\n            - Path=/auth/**\r\n          filters:\r\n            - StripPrefix=1\r\n        # # 代码生成\r\n        # - id: ms-gen\r\n        #   uri: lb://ms-gen\r\n        #   predicates:\r\n        #     - Path=/code/**\r\n        #   filters:\r\n        #     - StripPrefix=1\r\n        # 定时任务\r\n        - id: ms-job\r\n          uri: lb://ms-job\r\n          predicates:\r\n            - Path=/schedule/**\r\n          filters:\r\n            - StripPrefix=1\r\n        - id: ms-notice\r\n          uri: lb://ms-notice\r\n          predicates:\r\n            - Path=/notice/**\r\n          filters:\r\n            - StripPrefix=1\r\n\r\n# 不校验白名单\r\nignore:\r\n  whites:\r\n    - /auth/logout\r\n    - /auth/**\r\n    - /schedule/v2/api-docs\r\n    - /auth/v2/api-docs\r\n    - /csrf\r\n    - /*/swagger-ui.html\r\n', '8bcdf8d0bbc9d648bc455783fb172311', '2020-09-17 20:12:30', '2020-09-17 20:12:30', NULL, '0:0:0:0:0:0:0:1', 'U', '');
INSERT INTO `his_config_info` VALUES (11, 46, 'ms-gateway-dev.yml', 'DEFAULT_GROUP', '', 'spring:\r\n  redis:\r\n    host: localhost\r\n    port: 6379\r\n    password: \r\n  cloud:\r\n    gateway:\r\n      discovery:\r\n        locator:\r\n          lowerCaseServiceId: true\r\n          enabled: true\r\n      routes:\r\n        # 认证中心\r\n        - id: ms-auth\r\n          uri: lb://ms-auth\r\n          predicates:\r\n            - Path=/auth/**\r\n          filters:\r\n            - StripPrefix=1\r\n        # # 代码生成\r\n        # - id: ms-gen\r\n        #   uri: lb://ms-gen\r\n        #   predicates:\r\n        #     - Path=/code/**\r\n        #   filters:\r\n        #     - StripPrefix=1\r\n        # 定时任务\r\n        - id: ms-job\r\n          uri: lb://ms-job\r\n          predicates:\r\n            - Path=/schedule/**\r\n          filters:\r\n            - StripPrefix=1\r\n        - id: ms-notice\r\n          uri: lb://ms-notice\r\n          predicates:\r\n            - Path=/notice/**\r\n          filters:\r\n            - StripPrefix=1\r\n\r\n# 不校验白名单\r\nignore:\r\n  whites:\r\n    - /auth/logout\r\n    - /csrf', 'd6c8e8afb7f2bf026f1850a36c76233a', '2020-09-17 20:14:48', '2020-09-17 20:14:49', NULL, '0:0:0:0:0:0:0:1', 'U', '');
INSERT INTO `his_config_info` VALUES (11, 47, 'ms-gateway-dev.yml', 'DEFAULT_GROUP', '', 'spring:\r\n  redis:\r\n    host: localhost\r\n    port: 6379\r\n    password: \r\n  cloud:\r\n    gateway:\r\n      discovery:\r\n        locator:\r\n          lowerCaseServiceId: true\r\n          enabled: true\r\n      routes:\r\n        # 认证中心\r\n        - id: ms-auth\r\n          uri: lb://ms-auth\r\n          predicates:\r\n            - Path=/auth/**\r\n          filters:\r\n            - StripPrefix=1\r\n        # # 代码生成\r\n        # - id: ms-gen\r\n        #   uri: lb://ms-gen\r\n        #   predicates:\r\n        #     - Path=/code/**\r\n        #   filters:\r\n        #     - StripPrefix=1\r\n        # 定时任务\r\n        - id: ms-job\r\n          uri: lb://ms-job\r\n          predicates:\r\n            - Path=/schedule/**\r\n          filters:\r\n            - StripPrefix=1\r\n        - id: ms-notice\r\n          uri: lb://ms-notice\r\n          predicates:\r\n            - Path=/notice/**\r\n          filters:\r\n            - StripPrefix=1\r\n\r\n# 不校验白名单\r\nignore:\r\n  whites:\r\n    - /auth\r\n    - /csrf', 'be24ec557e2bcf4c777f663a7db37c88', '2020-09-17 20:19:12', '2020-09-17 20:19:13', NULL, '0:0:0:0:0:0:0:1', 'U', '');
INSERT INTO `his_config_info` VALUES (11, 48, 'ms-gateway-dev.yml', 'DEFAULT_GROUP', '', 'spring:\r\n  redis:\r\n    host: localhost\r\n    port: 6379\r\n    password: \r\n  cloud:\r\n    gateway:\r\n      discovery:\r\n        locator:\r\n          lowerCaseServiceId: true\r\n          enabled: true\r\n      routes:\r\n        # 认证中心\r\n        - id: ms-auth\r\n          uri: lb://ms-auth\r\n          predicates:\r\n            - Path=/auth/**\r\n          filters:\r\n            - StripPrefix=1\r\n        # # 代码生成\r\n        # - id: ms-gen\r\n        #   uri: lb://ms-gen\r\n        #   predicates:\r\n        #     - Path=/code/**\r\n        #   filters:\r\n        #     - StripPrefix=1\r\n        # 定时任务\r\n        - id: ms-job\r\n          uri: lb://ms-job\r\n          predicates:\r\n            - Path=/schedule/**\r\n          filters:\r\n            - StripPrefix=1\r\n        - id: ms-notice\r\n          uri: lb://ms-notice\r\n          predicates:\r\n            - Path=/notice/**\r\n          filters:\r\n            - StripPrefix=1\r\n\r\n# 不校验白名单\r\nignore:\r\n  whites:\r\n    - /auth/login\r\n    - /v2/api-docs\r\n    - /csrf', '2c4ca43f4b2b862513c3cdd58a3fa678', '2020-09-17 20:20:35', '2020-09-17 20:20:36', NULL, '0:0:0:0:0:0:0:1', 'U', '');
INSERT INTO `his_config_info` VALUES (11, 49, 'ms-gateway-dev.yml', 'DEFAULT_GROUP', '', 'spring:\r\n  redis:\r\n    host: localhost\r\n    port: 6379\r\n    password: \r\n  cloud:\r\n    gateway:\r\n      discovery:\r\n        locator:\r\n          lowerCaseServiceId: true\r\n          enabled: true\r\n      routes:\r\n        # 认证中心\r\n        - id: ms-auth\r\n          uri: lb://ms-auth\r\n          predicates:\r\n            - Path=/auth/**\r\n          filters:\r\n            - StripPrefix=1\r\n        # # 代码生成\r\n        # - id: ms-gen\r\n        #   uri: lb://ms-gen\r\n        #   predicates:\r\n        #     - Path=/code/**\r\n        #   filters:\r\n        #     - StripPrefix=1\r\n        # 定时任务\r\n        - id: ms-job\r\n          uri: lb://ms-job\r\n          predicates:\r\n            - Path=/schedule/**\r\n          filters:\r\n            - StripPrefix=1\r\n        - id: ms-notice\r\n          uri: lb://ms-notice\r\n          predicates:\r\n            - Path=/notice/**\r\n          filters:\r\n            - StripPrefix=1\r\n\r\n# 不校验白名单\r\nignore:\r\n  whites:\r\n    - /auth/login\r\n    - /v2/api-docs\r\n    - /csrf\r\n    - /auth/ms/send/code', '370c669eb9e44cbbd7b37ebd64e5372e', '2020-09-17 20:21:31', '2020-09-17 20:21:32', NULL, '0:0:0:0:0:0:0:1', 'U', '');

-- ----------------------------
-- Table structure for permissions
-- ----------------------------
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions`  (
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `resource` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `action` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  UNIQUE INDEX `uk_role_permission`(`role`, `resource`, `action`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permissions
-- ----------------------------

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  UNIQUE INDEX `idx_user_role`(`username`, `role`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES ('nacos', 'ROLE_ADMIN');

-- ----------------------------
-- Table structure for tb_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE `tb_user`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `nike_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '昵称',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `create_date` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_date` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `update_pid` bigint(20) NULL DEFAULT NULL COMMENT '修改人',
  `create_pid` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `sex` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `registration_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '推送ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1305069189467860994 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_user
-- ----------------------------
INSERT INTO `tb_user` VALUES (1295302933856514050, '17076466010', '17076466010', '2020-08-17 18:14:20', NULL, NULL, NULL, NULL, '2', NULL, NULL);
INSERT INTO `tb_user` VALUES (1295535665991774209, '17865325532', '17865325532', '2020-08-18 09:39:07', NULL, NULL, NULL, NULL, '2', NULL, '1a0018970a14334116d');
INSERT INTO `tb_user` VALUES (1295570373349740546, '15610475663', '15610475663', '2020-08-18 11:57:02', NULL, NULL, NULL, NULL, '2', NULL, '170976fa8a0bb6e0475');
INSERT INTO `tb_user` VALUES (1295589769610792961, '15726426715', '15726426715', '2020-08-18 13:14:07', NULL, NULL, NULL, NULL, '2', NULL, '160a3797c88f6983b9d');
INSERT INTO `tb_user` VALUES (1295590492075462657, '13698667099', '13698667099', '2020-08-18 13:16:59', NULL, NULL, NULL, NULL, '2', NULL, NULL);
INSERT INTO `tb_user` VALUES (1295590533292888066, '15092215709', '15092215709', '2020-08-18 13:17:09', NULL, NULL, NULL, NULL, '2', NULL, NULL);
INSERT INTO `tb_user` VALUES (1295591121481109506, '13173206919', '13173206919', '2020-08-18 13:19:29', NULL, NULL, NULL, NULL, '2', NULL, NULL);
INSERT INTO `tb_user` VALUES (1295591398523277314, '15315512605', '15315512605', '2020-08-18 13:20:35', NULL, NULL, NULL, NULL, '2', NULL, NULL);
INSERT INTO `tb_user` VALUES (1295591850644082690, '13388027259', '13388027259', '2020-08-18 13:22:23', NULL, NULL, NULL, NULL, '2', NULL, NULL);
INSERT INTO `tb_user` VALUES (1295591874778107906, '18513957821', '18513957821', '2020-08-18 13:22:29', NULL, NULL, NULL, NULL, '2', NULL, '140fe1da9e1ca90eadf');
INSERT INTO `tb_user` VALUES (1295592139333832705, '13791976627', '13791976627', '2020-08-18 13:23:32', NULL, NULL, NULL, NULL, '2', NULL, '18171adc03be94f5124');
INSERT INTO `tb_user` VALUES (1295592478367813633, '17600289722', '17600289722', '2020-08-18 13:24:52', NULL, NULL, NULL, NULL, '2', NULL, '171976fa8a3324dcef7');
INSERT INTO `tb_user` VALUES (1295592636400799746, '13361272729', '13361272729', '2020-08-18 13:25:30', NULL, NULL, NULL, NULL, '2', NULL, NULL);
INSERT INTO `tb_user` VALUES (1295593034905817089, '15054268069', '15054268069', '2020-08-18 13:27:05', NULL, NULL, NULL, NULL, '2', NULL, '1a0018970a14334116d');
INSERT INTO `tb_user` VALUES (1295594201496948738, '13589213134', '13589213134', '2020-08-18 13:31:43', NULL, NULL, NULL, NULL, '2', NULL, NULL);
INSERT INTO `tb_user` VALUES (1295594670906675201, '15351883673', '15351883673', '2020-08-18 13:33:35', NULL, NULL, NULL, NULL, '2', NULL, NULL);
INSERT INTO `tb_user` VALUES (1295597307462946818, '15653273907', '15653273907', '2020-08-18 13:44:04', NULL, NULL, NULL, NULL, '2', NULL, NULL);
INSERT INTO `tb_user` VALUES (1295597926890344449, '18661909119', '18661909119', '2020-08-18 13:46:31', NULL, NULL, NULL, NULL, '2', NULL, NULL);
INSERT INTO `tb_user` VALUES (1295694731204366338, '13361221922', '13361221922', '2020-08-18 20:11:11', NULL, NULL, NULL, NULL, '2', NULL, NULL);
INSERT INTO `tb_user` VALUES (1295703975555239938, '17667568506', '17667568506', '2020-08-18 20:47:55', NULL, NULL, NULL, NULL, '2', NULL, NULL);
INSERT INTO `tb_user` VALUES (1295858462777413634, '13345023203', '13345023203', '2020-08-19 07:01:48', NULL, NULL, NULL, NULL, '2', NULL, NULL);
INSERT INTO `tb_user` VALUES (1295891912574111745, '15771765129', '15771765129', '2020-08-19 09:14:43', NULL, NULL, NULL, NULL, '2', NULL, '101d855909caa4160db');
INSERT INTO `tb_user` VALUES (1295892529837248514, '18342241912', '18342241912', '2020-08-19 09:17:10', NULL, NULL, NULL, NULL, '2', NULL, '121c83f76097f6f0bd5');
INSERT INTO `tb_user` VALUES (1295951899556057090, '13913965245', '13913965245', '2020-08-19 13:13:05', NULL, NULL, NULL, NULL, '2', NULL, NULL);
INSERT INTO `tb_user` VALUES (1296355976697876481, '18057107797', '18057107797', '2020-08-20 15:58:45', NULL, NULL, NULL, NULL, '2', NULL, NULL);
INSERT INTO `tb_user` VALUES (1296673227682615298, '13335063101', '13335063101', '2020-08-21 12:59:23', NULL, NULL, NULL, NULL, '2', NULL, NULL);
INSERT INTO `tb_user` VALUES (1296994867129880578, '18560652515', '18560652515', '2020-08-22 10:17:28', NULL, NULL, NULL, NULL, '2', NULL, NULL);
INSERT INTO `tb_user` VALUES (1297791409554198530, '18953283053', '18953283053', '2020-08-24 15:02:38', NULL, NULL, NULL, NULL, '2', NULL, NULL);
INSERT INTO `tb_user` VALUES (1298089408427843586, '18561583600', '18561583600', '2020-08-25 10:46:47', NULL, NULL, NULL, NULL, '2', NULL, '1104a897922432fdc34');
INSERT INTO `tb_user` VALUES (1298158589701591041, '18866216142', '18866216142', '2020-08-25 15:21:41', NULL, NULL, NULL, NULL, NULL, NULL, '161a3797c8b6bd2d12a');
INSERT INTO `tb_user` VALUES (1299174007228678145, '15610475001', '15610475001', '2020-08-28 10:36:35', NULL, NULL, NULL, NULL, NULL, NULL, '190e35f7e0f46b4da9b');
INSERT INTO `tb_user` VALUES (1299640149448396801, '13325028818', '13325028818', '2020-08-29 17:28:52', NULL, NULL, NULL, NULL, NULL, NULL, '1a1018970a14ec7914c');
INSERT INTO `tb_user` VALUES (1299673980054343682, '19999229219', '19999229219', '2020-08-29 19:43:18', NULL, NULL, NULL, NULL, '2', NULL, '13065ffa4ebd3c37300');
INSERT INTO `tb_user` VALUES (1299675333656907778, '13137955986', '13137955986', '2020-08-29 19:48:41', NULL, NULL, NULL, NULL, '2', NULL, NULL);
INSERT INTO `tb_user` VALUES (1299676926368354306, '13700888797', '13700888797', '2020-08-29 19:55:01', NULL, NULL, NULL, NULL, '2', NULL, NULL);
INSERT INTO `tb_user` VALUES (1299676941023252481, '13223452091', '13223452091', '2020-08-29 19:55:04', NULL, NULL, NULL, NULL, '2', NULL, NULL);
INSERT INTO `tb_user` VALUES (1299681545953808386, '18665982113', '18665982113', '2020-08-29 20:13:22', NULL, NULL, NULL, NULL, '2', NULL, NULL);
INSERT INTO `tb_user` VALUES (1299685939948621825, '13463872900', '13463872900', '2020-08-29 20:30:50', NULL, NULL, NULL, NULL, '2', NULL, NULL);
INSERT INTO `tb_user` VALUES (1299693273039048706, '15631132627', '15631132627', '2020-08-29 20:59:58', NULL, NULL, NULL, NULL, '2', NULL, NULL);
INSERT INTO `tb_user` VALUES (1299698406485463042, '18712895921', '18712895921', '2020-08-29 21:20:22', NULL, NULL, NULL, NULL, '2', NULL, NULL);
INSERT INTO `tb_user` VALUES (1299713153092096001, '18311215867', '18311215867', '2020-08-29 22:18:58', NULL, NULL, NULL, NULL, '2', NULL, NULL);
INSERT INTO `tb_user` VALUES (1299718799912931330, '18321992861', '18321992861', '2020-08-29 22:41:24', NULL, NULL, NULL, NULL, '2', NULL, NULL);
INSERT INTO `tb_user` VALUES (1299926408477609986, '13460418682', '13460418682', '2020-08-30 12:26:22', NULL, NULL, NULL, NULL, '2', NULL, NULL);
INSERT INTO `tb_user` VALUES (1299945512894795778, '13838278985', '13838278985', '2020-08-30 13:42:17', NULL, NULL, NULL, NULL, '2', NULL, NULL);
INSERT INTO `tb_user` VALUES (1299978061666914306, '18339906355', '18339906355', '2020-08-30 15:51:37', NULL, NULL, NULL, NULL, '2', NULL, NULL);
INSERT INTO `tb_user` VALUES (1300692636352987138, '13849556589', '13849556589', '2020-09-01 15:11:05', NULL, NULL, NULL, NULL, '2', NULL, NULL);
INSERT INTO `tb_user` VALUES (1301050223135887361, '13581558306', '13581558306', '2020-09-02 14:52:00', NULL, NULL, NULL, NULL, '2', NULL, NULL);
INSERT INTO `tb_user` VALUES (1301091933485613057, '13255927889', '13255927889', '2020-09-02 17:37:45', NULL, NULL, NULL, NULL, '2', NULL, '121c83f76094460950b');
INSERT INTO `tb_user` VALUES (1301432994250702850, '13432900605', '13432900605', '2020-09-03 16:13:00', NULL, NULL, NULL, NULL, NULL, NULL, '160a3797c8b3c3f4549');
INSERT INTO `tb_user` VALUES (1301443353861492738, '15005157933', '15005157933', '2020-09-03 16:54:10', NULL, NULL, NULL, NULL, NULL, NULL, '160a3797c8b20521488');
INSERT INTO `tb_user` VALUES (1301691552018796545, '15100231080', '15100231080', '2020-09-04 09:20:25', NULL, NULL, NULL, NULL, NULL, NULL, '1a0018970a15f54e184');
INSERT INTO `tb_user` VALUES (1301731164071477250, '18765280251', '18765280251', '2020-09-04 11:57:49', NULL, NULL, NULL, NULL, NULL, NULL, '1507bfd3f7740d35e63');
INSERT INTO `tb_user` VALUES (1301734229033959425, '13331177559', '13331177559', '2020-09-04 12:10:00', NULL, NULL, NULL, NULL, NULL, NULL, '190e35f7e0f281cbb93');
INSERT INTO `tb_user` VALUES (1301768018263097345, '13792830337', '13792830337', '2020-09-04 14:24:16', NULL, NULL, NULL, NULL, '2', NULL, '1517bfd3f7734a68d67');
INSERT INTO `tb_user` VALUES (1301768303907782658, '18137193445', '18137193445', '2020-09-04 14:25:24', NULL, NULL, NULL, NULL, NULL, NULL, '18171adc03bc0e2adcb');
INSERT INTO `tb_user` VALUES (1301865158117244930, '13319832999', '13319832999', '2020-09-04 20:50:16', NULL, NULL, NULL, NULL, NULL, NULL, '1507bfd3f77645a27e5');
INSERT INTO `tb_user` VALUES (1302232828394160130, '15812408375', '15812408375', '2020-09-05 21:11:15', NULL, NULL, NULL, NULL, NULL, NULL, '1a0018970a11ec1d93f');
INSERT INTO `tb_user` VALUES (1302472902281084930, '18373389577', '18373389577', '2020-09-06 13:05:13', NULL, NULL, NULL, NULL, NULL, NULL, '171976fa8a36cf35bba');
INSERT INTO `tb_user` VALUES (1302533661933518850, '18725598007', '18725598007', '2020-09-06 17:06:40', NULL, NULL, NULL, NULL, NULL, NULL, '1507bfd3f7770012c90');
INSERT INTO `tb_user` VALUES (1302688476307210241, '18745216074', '18745216074', '2020-09-07 03:21:50', NULL, NULL, NULL, NULL, NULL, NULL, '13065ffa4eb997b5544');
INSERT INTO `tb_user` VALUES (1302786450181931010, '15551693365', '15551693365', '2020-09-07 09:51:09', NULL, NULL, NULL, NULL, NULL, NULL, '1104a897921b78fe0aa');
INSERT INTO `tb_user` VALUES (1302796398144077826, '15891777936', '15891777936', '2020-09-07 10:30:41', NULL, NULL, NULL, NULL, NULL, NULL, '191e35f7e0f7597a159');
INSERT INTO `tb_user` VALUES (1302864148426211330, '18339809249', '18339809249', '2020-09-07 14:59:54', NULL, NULL, NULL, NULL, NULL, NULL, '190e35f7e0f4091ecc4');
INSERT INTO `tb_user` VALUES (1303176139091034114, '13783606210', '13783606210', '2020-09-08 11:39:38', NULL, NULL, NULL, NULL, '2', NULL, NULL);
INSERT INTO `tb_user` VALUES (1303193211959328769, '15939155283', '15939155283', '2020-09-08 12:47:29', NULL, NULL, NULL, NULL, NULL, NULL, '101d855909f0bb51c94');
INSERT INTO `tb_user` VALUES (1303208431847030786, '13573272425', '13573272425', '2020-09-08 13:47:57', NULL, NULL, NULL, NULL, NULL, NULL, '1a0018970a13cd919be');
INSERT INTO `tb_user` VALUES (1303227934056202241, '13072580347', '13072580347', '2020-09-08 15:05:27', NULL, NULL, NULL, NULL, NULL, NULL, '13065ffa4eb8b3beaca');
INSERT INTO `tb_user` VALUES (1303637768220045313, '15166688066', '15166688066', '2020-09-09 18:13:59', NULL, NULL, NULL, NULL, '2', NULL, NULL);
INSERT INTO `tb_user` VALUES (1304089390620471298, '18310106033', '18310106033', '2020-09-11 00:08:34', NULL, NULL, NULL, NULL, '2', NULL, NULL);
INSERT INTO `tb_user` VALUES (1304309323828686850, '13322220735', '13322220735', '2020-09-11 14:42:30', NULL, NULL, NULL, NULL, '2', NULL, NULL);
INSERT INTO `tb_user` VALUES (1304309686610817026, '13072580147', '13072580147', '2020-09-11 14:43:57', NULL, NULL, NULL, NULL, NULL, NULL, '13065ffa4ebf126ff3a');
INSERT INTO `tb_user` VALUES (1304333477441302530, '13951656146', '13951656146', '2020-09-11 16:18:29', NULL, NULL, NULL, NULL, '2', NULL, NULL);
INSERT INTO `tb_user` VALUES (1304649824683552769, '13307462195', '13307462195', '2020-09-12 13:15:32', NULL, NULL, NULL, NULL, NULL, NULL, '190e35f7e0f2151bc5f');
INSERT INTO `tb_user` VALUES (1304681968415928322, '19977190901', '19977190901', '2020-09-12 15:23:16', NULL, NULL, NULL, NULL, NULL, NULL, '170976fa8a36b61b0fd');
INSERT INTO `tb_user` VALUES (1304721195786694658, '18118118859', '18118118859', '2020-09-12 17:59:08', NULL, NULL, NULL, NULL, '2', NULL, NULL);
INSERT INTO `tb_user` VALUES (1304753013005086721, '13686990798', '13686990798', '2020-09-12 20:05:34', NULL, NULL, NULL, NULL, '2', NULL, NULL);
INSERT INTO `tb_user` VALUES (1304977565857476609, '13990323220', '13990323220', '2020-09-13 10:57:52', NULL, NULL, NULL, NULL, NULL, NULL, '160a3797c8b7ae4618b');
INSERT INTO `tb_user` VALUES (1304983798098292737, '15650247796', '15650247796', '2020-09-13 11:22:38', NULL, NULL, NULL, NULL, NULL, NULL, '120c83f76093de4dddc');
INSERT INTO `tb_user` VALUES (1305069189467860993, '18112557234', '18112557234', '2020-09-13 17:01:56', NULL, NULL, NULL, NULL, NULL, NULL, '120c83f76090c0c9984');

-- ----------------------------
-- Table structure for tenant_capacity
-- ----------------------------
DROP TABLE IF EXISTS `tenant_capacity`;
CREATE TABLE `tenant_capacity`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Tenant ID',
  `quota` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '配额，0表示使用默认值',
  `usage` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '使用量',
  `max_size` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '聚合子配置最大个数',
  `max_aggr_size` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大变更历史数量',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '租户容量信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tenant_capacity
-- ----------------------------

-- ----------------------------
-- Table structure for tenant_info
-- ----------------------------
DROP TABLE IF EXISTS `tenant_info`;
CREATE TABLE `tenant_info`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `kp` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'kp',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_id',
  `tenant_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_name',
  `tenant_desc` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'tenant_desc',
  `create_source` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'create_source',
  `gmt_create` bigint(20) NOT NULL COMMENT '创建时间',
  `gmt_modified` bigint(20) NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_tenant_info_kptenantid`(`kp`, `tenant_id`) USING BTREE,
  INDEX `idx_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'tenant_info' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tenant_info
-- ----------------------------

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('nacos', '$2a$10$g9UzcuEcYKwcePlsTPM5bOsWTtJPj.1TQnmD.Af/rR2tZcInbk7BC', 1);

SET FOREIGN_KEY_CHECKS = 1;
