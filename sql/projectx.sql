/*
SQLyog Ultimate v12.08 (64 bit)
MySQL - 8.0.32 : Database - javaweb
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`javaweb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `javaweb`;

/*Table structure for table `test` */

DROP TABLE IF EXISTS `test`;

CREATE TABLE `test` (
  `testid` int NOT NULL AUTO_INCREMENT,
  `timelimite` int NOT NULL,
  `students` varchar(255) NOT NULL,
  `author` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`testid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `test` */

insert  into `test`(`testid`,`timelimite`,`students`,`author`) values (1,200,'student1/students2',NULL);

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `main_passrate` double DEFAULT NULL,
  `last_passrate` double DEFAULT NULL,
  `number` int DEFAULT NULL,
  `pass_number` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `user` */

insert  into `user`(`id`,`username`,`password`,`category`,`main_passrate`,`last_passrate`,`number`,`pass_number`) values (1,'admin','admin','admin',0.7125,0.1,80,57),(2,'user_students','student','user',0.5,0.8,50,25),(3,'user_teacher','teacher','admin',1,1,50,50),(9,'test','test','user',0.5098039215686274,1,51,26);

/*Table structure for table `words` */

DROP TABLE IF EXISTS `words`;

CREATE TABLE `words` (
  `WordsId` int NOT NULL AUTO_INCREMENT,
  `English` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Chinese` varchar(255) NOT NULL,
  PRIMARY KEY (`WordsId`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `words` */

insert  into `words`(`WordsId`,`English`,`Chinese`) values (1,'apple','苹果'),(2,'university','大学'),(3,'pig','猪'),(4,'smartphone','智能手机'),(5,'banana','香蕉'),(6,'teacher','教师'),(7,'book','书'),(9,'water','水'),(10,'pen','钢笔'),(11,'item','物品'),(17,'paper','纸');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
