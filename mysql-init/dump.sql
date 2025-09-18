/*
 Navicat Premium Data Transfer

 Source Server         : Localhost
 Source Server Type    : MySQL
 Source Server Version : 100432
 Source Host           : localhost:3306
 Source Schema         : task_scheduler

 Target Server Type    : MySQL
 Target Server Version : 100432
 File Encoding         : 65001

 Date: 17/09/2025 04:42:10
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for status
-- ----------------------------
DROP TABLE IF EXISTS `status`;
CREATE TABLE `status`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `position` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 77 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of status
-- ----------------------------
INSERT INTO `status` VALUES (30, 'sdfgsdfg', 1);
INSERT INTO `status` VALUES (65, 'asdfasvvv', 3);
INSERT INTO `status` VALUES (74, 'zdfadsfdsfadadsad', 2);

-- ----------------------------
-- Table structure for task
-- ----------------------------
DROP TABLE IF EXISTS `task`;
CREATE TABLE `task`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `assignedUserId` int NULL DEFAULT NULL,
  `statusId` int NULL DEFAULT NULL,
  `createdAt` datetime(6) NOT NULL DEFAULT current_timestamp(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `dueDate` datetime(0) NULL DEFAULT NULL,
  `position` int NOT NULL DEFAULT 1,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `completed` tinyint NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_e3bd734666db0cb70e8c8d542c8`(`assignedUserId`) USING BTREE,
  INDEX `FK_02068239bb8d5b2fc7f3ded618c`(`statusId`) USING BTREE,
  CONSTRAINT `FK_02068239bb8d5b2fc7f3ded618c` FOREIGN KEY (`statusId`) REFERENCES `status` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_e3bd734666db0cb70e8c8d542c8` FOREIGN KEY (`assignedUserId`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 217 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of task
-- ----------------------------
INSERT INTO `task` VALUES (186, '2asdfasdfadfadfadsfds', 1, 30, '2025-09-16 04:55:18.722249', '2025-09-16 22:01:56.000000', NULL, 1, 'asdfasdfasdfadsfadsfsadfadsf', 0);
INSERT INTO `task` VALUES (202, 'Tfasdfasdfasdfgt', 1, 65, '2025-09-16 21:33:39.224946', '2025-09-17 04:16:14.000000', NULL, 3, NULL, 0);
INSERT INTO `task` VALUES (208, 'asdfasdf', 1, 74, '2025-09-16 22:39:07.621296', '2025-09-17 03:54:50.000000', NULL, 2, NULL, 1);
INSERT INTO `task` VALUES (209, 'asdfadsf', 1, 65, '2025-09-17 01:18:42.541156', '2025-09-17 04:16:14.000000', NULL, 2, NULL, 0);
INSERT INTO `task` VALUES (210, 'sdfsdfg', NULL, 65, '2025-09-17 02:52:01.796699', '2025-09-17 04:16:14.000000', NULL, 1, NULL, 0);
INSERT INTO `task` VALUES (211, 'sdfgsfdg', NULL, 30, '2025-09-17 02:52:02.584219', '2025-09-17 04:16:12.000000', NULL, 2, NULL, 0);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `available` tinyint NOT NULL DEFAULT 1,
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `passwordHash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `fullName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `permissions` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `lastSeen` datetime(0) NOT NULL,
  `createdAt` datetime(6) NOT NULL DEFAULT current_timestamp(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `IDX_78a916df40e02a9deb1c4b75ed`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', 1, 'admin', '$2b$10$7aYOffvOmUFlMaRHSNSwOu6NfsAYa.x6z7RhKSWsKWt8nc94jkmMm', 'Admin User', NULL, '2025-09-17 02:28:08', '2025-09-14 10:50:38.000000', '2025-09-17 03:11:44.000000');
INSERT INTO `user` VALUES (2, 'jdoe', 1, 'user', '$2b$10$7aYOffvOmUFlMaRHSNSwOu6NfsAYa.x6z7RhKSWsKWt8nc94jkmMm', 'John Doe', 'see_other_tasks', '2025-09-15 21:10:10', '2025-09-14 10:50:38.000000', '2025-09-17 03:11:43.000000');
INSERT INTO `user` VALUES (3, 'vv', 1, 'user', '$2b$10$7aYOffvOmUFlMaRHSNSwOu6NfsAYa.x6z7RhKSWsKWt8nc94jkmMm', 'Alice Smith1', 'see_other_tasks', '2025-09-17 02:51:38', '2025-09-14 10:50:38.000000', '2025-09-17 03:11:43.000000');

SET FOREIGN_KEY_CHECKS = 1;
