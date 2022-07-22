/*
SQLyog Ultimate v10.00 Beta1
MySQL - 8.0.25 : Database - ss
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`ss` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `ss`;

/*Table structure for table `admin` */

DROP TABLE IF EXISTS `admin`;

CREATE TABLE `admin` (
  `admin_name` varchar(20) NOT NULL,
  `admin_sex` varchar(2) DEFAULT NULL,
  `admin_age` int DEFAULT NULL,
  `admin_phone` varchar(15) DEFAULT NULL,
  `admin_building` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`admin_name`),
  KEY `admin_building` (`admin_building`),
  CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`admin_building`) REFERENCES `building` (`building_num`),
  CONSTRAINT `admin_chk_1` CHECK (((`admin_sex` = _utf8mb3'男') or (`admin_sex` = _utf8mb3'女'))),
  CONSTRAINT `admin_chk_2` CHECK (((`admin_age` > 0) and (`admin_age` < 100)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `admin` */

insert  into `admin`(`admin_name`,`admin_sex`,`admin_age`,`admin_phone`,`admin_building`) values ('周叔','男',45,'14526765889','c3'),('李叔','男',35,'13432925679','C1'),('陆阿姨','女',35,'13423568790','c5'),('陈阿姨','女',55,'13692517989','C2'),('黄叔','男',38,'19865343677','c4');

/*Table structure for table `building` */

DROP TABLE IF EXISTS `building`;

CREATE TABLE `building` (
  `building_num` varchar(5) NOT NULL,
  `stay_num` varchar(3) NOT NULL,
  `building_p_total` int DEFAULT NULL,
  `building_dept` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`building_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `building` */

insert  into `building`(`building_num`,`stay_num`,`building_p_total`,`building_dept`) values ('C1','',40,'汽车学院'),('C2','',40,'电子信息工程学院'),('C3','',40,'计算机工程学院'),('C4','',8,'建筑学院'),('C5','',8,'管理学院');

/*Table structure for table `food` */

DROP TABLE IF EXISTS `food`;

CREATE TABLE `food` (
  `building_num` varchar(5) DEFAULT NULL,
  `stay_num` varchar(3) NOT NULL,
  `food_name` varchar(20) NOT NULL,
  `food_type` varchar(5) DEFAULT NULL,
  `food_num` varchar(3) DEFAULT NULL,
  `food_date` date DEFAULT NULL,
  `food_time` time DEFAULT NULL,
  PRIMARY KEY (`food_name`),
  KEY `building_num` (`building_num`),
  KEY `stay_num` (`stay_num`),
  CONSTRAINT `food_ibfk_1` FOREIGN KEY (`building_num`) REFERENCES `building` (`building_num`),
  CONSTRAINT `food_ibfk_2` FOREIGN KEY (`stay_num`) REFERENCES `room` (`room`),
  CONSTRAINT `food_chk_1` CHECK ((`food_num` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `food` */

insert  into `food`(`building_num`,`stay_num`,`food_name`,`food_type`,`food_num`,`food_date`,`food_time`) values ('C1','111','汉堡','即食快餐','1','2021-09-20','17:00:00');

/*Table structure for table `goods` */

DROP TABLE IF EXISTS `goods`;

CREATE TABLE `goods` (
  `stay_num` varchar(3) DEFAULT NULL,
  `goods_table` int DEFAULT NULL,
  `goods_chair` int DEFAULT NULL,
  `goods_bed` int DEFAULT NULL,
  `goods_fan` int DEFAULT NULL,
  `goods_light` int DEFAULT NULL,
  `goods_windows` int DEFAULT NULL,
  `goods_door` int DEFAULT NULL,
  KEY `stay_num` (`stay_num`),
  CONSTRAINT `goods_ibfk_1` FOREIGN KEY (`stay_num`) REFERENCES `room` (`room`),
  CONSTRAINT `goods_chk_1` CHECK ((`goods_table` > 0)),
  CONSTRAINT `goods_chk_2` CHECK ((`goods_chair` > 0)),
  CONSTRAINT `goods_chk_3` CHECK ((`goods_bed` > 0)),
  CONSTRAINT `goods_chk_4` CHECK ((`goods_fan` > 0)),
  CONSTRAINT `goods_chk_5` CHECK ((`goods_light` > 0)),
  CONSTRAINT `goods_chk_6` CHECK ((`goods_windows` > 0)),
  CONSTRAINT `goods_chk_7` CHECK ((`goods_door` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `goods` */

insert  into `goods`(`stay_num`,`goods_table`,`goods_chair`,`goods_bed`,`goods_fan`,`goods_light`,`goods_windows`,`goods_door`) values ('111',4,4,4,1,2,2,2),('510',2,2,2,2,2,2,2);

/*Table structure for table `in_out` */

DROP TABLE IF EXISTS `in_out`;

CREATE TABLE `in_out` (
  `student_name` varchar(5) NOT NULL,
  `building_num` varchar(5) DEFAULT NULL,
  `in_out_date` date DEFAULT NULL,
  `in_out_time` time DEFAULT NULL,
  `inorout` varchar(2) DEFAULT NULL,
  KEY `building_num` (`building_num`),
  CONSTRAINT `in_out_ibfk_1` FOREIGN KEY (`building_num`) REFERENCES `building` (`building_num`),
  CONSTRAINT `in_out_chk_1` CHECK (((`inorout` = _utf8mb3'出') or (`inorout` = _utf8mb3'入')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `in_out` */

insert  into `in_out`(`student_name`,`building_num`,`in_out_date`,`in_out_time`,`inorout`) values ('张一','C1','2021-09-20','09:00:00','出'),('张一','C1','2021-09-20','11:00:00','入');

/*Table structure for table `room` */

DROP TABLE IF EXISTS `room`;

CREATE TABLE `room` (
  `building_num` varchar(5) NOT NULL,
  `room` varchar(3) NOT NULL,
  `room_type` varchar(5) DEFAULT NULL,
  `room_count` int DEFAULT NULL,
  `room_num` int DEFAULT NULL,
  `room_name` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`room`),
  KEY `building_num` (`building_num`),
  KEY `index_room` (`room`),
  CONSTRAINT `room_ibfk_1` FOREIGN KEY (`building_num`) REFERENCES `building` (`building_num`),
  CONSTRAINT `room_chk_1` CHECK (((`room_type` = _utf8mb4'普通') or (`room_type` = _utf8mb4'豪华'))),
  CONSTRAINT `room_chk_2` CHECK (((`room_count` = _utf8mb3'2') or (`room_count` = _utf8mb3'4'))),
  CONSTRAINT `room_chk_3` CHECK (((`room_num` > 0) and (`room_num` <= 4)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `room` */

insert  into `room`(`building_num`,`room`,`room_type`,`room_count`,`room_num`,`room_name`) values ('c1','111','普通',4,NULL,NULL),('c1','112','普通',4,NULL,NULL),('c1','113','普通',4,NULL,NULL),('c1','114','普通',4,NULL,NULL),('c1','115','普通',4,NULL,NULL),('c1','116','普通',4,NULL,NULL),('c1','118','普通',4,NULL,NULL),('c1','119','普通',4,NULL,NULL),('c1','120','普通',4,NULL,NULL),('c2','211','普通',4,NULL,NULL),('c2','212','普通',4,NULL,NULL),('c2','213','普通',4,NULL,NULL),('c2','214','普通',4,NULL,NULL),('c2','215','普通',4,NULL,NULL),('c2','216','普通',4,NULL,NULL),('c2','218','普通',4,NULL,NULL),('c2','219','普通',4,NULL,NULL),('c2','220','普通',4,NULL,NULL),('c3','311','普通',4,NULL,NULL),('c3','312','普通',4,NULL,NULL),('c3','313','普通',4,NULL,NULL),('c3','314','普通',4,NULL,NULL),('c3','315','普通',4,NULL,NULL),('c3','316','普通',4,NULL,NULL),('c3','318','普通',4,NULL,NULL),('c3','319','普通',4,NULL,NULL),('c3','320','普通',4,NULL,NULL),('c4','410','豪华',2,NULL,NULL),('c4','413','豪华',2,NULL,NULL),('c4','414','豪华',2,NULL,NULL),('c4','415','豪华',2,NULL,NULL),('c4','416','豪华',2,NULL,NULL),('c4','418','豪华',2,NULL,NULL),('c4','419','豪华',2,NULL,NULL),('c4','420','豪华',2,NULL,NULL),('c4','430','豪华',2,NULL,NULL),('c4','440','豪华',2,NULL,NULL),('c5','510','豪华',2,NULL,NULL),('c5','520','豪华',2,NULL,NULL),('c5','530','豪华',2,NULL,NULL),('c5','540','豪华',2,NULL,NULL);

/*Table structure for table `room_inside` */

DROP TABLE IF EXISTS `room_inside`;

CREATE TABLE `room_inside` (
  `building_num` varchar(5) NOT NULL,
  `room` varchar(3) NOT NULL,
  `room_num` int DEFAULT NULL,
  `student_num` varchar(12) DEFAULT NULL,
  `student_name` varchar(10) DEFAULT NULL,
  UNIQUE KEY `student_name` (`student_name`),
  KEY `building_num` (`building_num`),
  KEY `room` (`room`),
  KEY `student_num` (`student_num`),
  CONSTRAINT `room_inside_ibfk_1` FOREIGN KEY (`building_num`) REFERENCES `building` (`building_num`),
  CONSTRAINT `room_inside_ibfk_2` FOREIGN KEY (`room`) REFERENCES `room` (`room`),
  CONSTRAINT `room_inside_ibfk_3` FOREIGN KEY (`student_num`) REFERENCES `student` (`student_num`),
  CONSTRAINT `room_inside_chk_1` CHECK (((`room_num` > 0) and (`room_num` <= 4)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `room_inside` */

insert  into `room_inside`(`building_num`,`room`,`room_num`,`student_num`,`student_name`) values ('C1','111',1,'201910097079','张一'),('C1','111',2,'201910097080','张二'),('C1','111',3,'202010097079','张三'),('C1','111',4,'202010097081','张四'),('C2','211',1,'202010097082','张五'),('C3','311',1,'202010098081','李一');

/*Table structure for table `stay` */

DROP TABLE IF EXISTS `stay`;

CREATE TABLE `stay` (
  `stay_num` varchar(3) NOT NULL,
  `student_name` varchar(20) NOT NULL,
  `stay_water` int DEFAULT NULL,
  `stay_ele` int DEFAULT NULL,
  `stay_fix` int DEFAULT NULL,
  `stay` int NOT NULL,
  `stay_date` date DEFAULT NULL,
  `stay_add` int DEFAULT NULL,
  PRIMARY KEY (`stay`),
  KEY `stay_num` (`stay_num`),
  CONSTRAINT `stay_ibfk_1` FOREIGN KEY (`stay_num`) REFERENCES `room` (`room`),
  CONSTRAINT `stay_chk_1` CHECK ((`stay_water` > 0)),
  CONSTRAINT `stay_chk_2` CHECK ((`stay_ele` > 0)),
  CONSTRAINT `stay_chk_3` CHECK ((`stay_fix` > 0)),
  CONSTRAINT `stay_chk_4` CHECK ((`stay` > 0)),
  CONSTRAINT `stay_chk_5` CHECK ((`stay_add` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `stay` */

insert  into `stay`(`stay_num`,`student_name`,`stay_water`,`stay_ele`,`stay_fix`,`stay`,`stay_date`,`stay_add`) values ('111','张一',50,200,25,2200,'2021-08-11',2475),('510','张五',50,200,25,4400,'2021-08-11',4675);

/*Table structure for table `student` */

DROP TABLE IF EXISTS `student`;

CREATE TABLE `student` (
  `student_name` varchar(5) NOT NULL,
  `student_num` varchar(12) NOT NULL,
  `student_sex` varchar(2) DEFAULT NULL,
  `student_age` varchar(3) DEFAULT NULL,
  `student_phone` varchar(11) DEFAULT NULL,
  `student_dept` varchar(10) DEFAULT NULL,
  `student_major` varchar(5) DEFAULT NULL,
  `stay_num` varchar(3) DEFAULT NULL,
  `building_num` varchar(5) DEFAULT NULL,
  `class` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`student_num`),
  KEY `building_num` (`building_num`),
  KEY `stay_num` (`stay_num`),
  KEY `index_name` (`student_name`),
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`building_num`) REFERENCES `building` (`building_num`),
  CONSTRAINT `student_ibfk_2` FOREIGN KEY (`stay_num`) REFERENCES `room` (`room`),
  CONSTRAINT `student_chk_1` CHECK (((`student_sex` = _utf8mb4'男') or (`student_sex` = _utf8mb4'女'))),
  CONSTRAINT `student_chk_2` CHECK (((`student_age` > 0) and (`student_age` < 100)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `student` */

insert  into `student`(`student_name`,`student_num`,`student_sex`,`student_age`,`student_phone`,`student_dept`,`student_major`,`stay_num`,`building_num`,`class`) values ('张一','201910097079','男','22','13432925679','计算机工程学院','网络工程',NULL,NULL,'网络工程2班'),('张二','201910097080','男','21','13465856890','计算机工程学院','网络工程',NULL,NULL,'网络工程2班'),('张三','202010097079','男','21','13432925680','计算机工程学院','计算机科学',NULL,NULL,'计算机1班'),('张四','202010097081','男','21','13432925681','计算机工程学院','计算机科学',NULL,NULL,'计算机2班'),('张五','202010097082','男','20','13432676943','管理学院','经济学',NULL,NULL,'经济2班'),('张六','202010097083','女','20','12365688659','管理学院','历史学',NULL,NULL,'历史2班'),('张八','202010097088','女','21','13432955685','计算机工程学院','计算机科学',NULL,NULL,'计算机2班'),('李一','202010098081','女','21','13432924567','计算机工程学院','网络工程',NULL,NULL,'网络工程2班');

/*Table structure for table `c1` */

DROP TABLE IF EXISTS `c1`;

/*!50001 DROP VIEW IF EXISTS `c1` */;
/*!50001 DROP TABLE IF EXISTS `c1` */;

/*!50001 CREATE TABLE  `c1`(
 `building_num` varchar(5) ,
 `admin_name` varchar(20) ,
 `room_type` varchar(5) ,
 `room` varchar(3) 
)*/;

/*Table structure for table `c2` */

DROP TABLE IF EXISTS `c2`;

/*!50001 DROP VIEW IF EXISTS `c2` */;
/*!50001 DROP TABLE IF EXISTS `c2` */;

/*!50001 CREATE TABLE  `c2`(
 `building_num` varchar(5) ,
 `admin_name` varchar(20) ,
 `room_type` varchar(5) ,
 `room` varchar(3) 
)*/;

/*Table structure for table `c3` */

DROP TABLE IF EXISTS `c3`;

/*!50001 DROP VIEW IF EXISTS `c3` */;
/*!50001 DROP TABLE IF EXISTS `c3` */;

/*!50001 CREATE TABLE  `c3`(
 `building_num` varchar(5) ,
 `admin_name` varchar(20) ,
 `room_type` varchar(5) ,
 `room` varchar(3) 
)*/;

/*Table structure for table `c4` */

DROP TABLE IF EXISTS `c4`;

/*!50001 DROP VIEW IF EXISTS `c4` */;
/*!50001 DROP TABLE IF EXISTS `c4` */;

/*!50001 CREATE TABLE  `c4`(
 `building_num` varchar(5) ,
 `admin_name` varchar(20) ,
 `room_type` varchar(5) ,
 `room` varchar(3) 
)*/;

/*Table structure for table `c5` */

DROP TABLE IF EXISTS `c5`;

/*!50001 DROP VIEW IF EXISTS `c5` */;
/*!50001 DROP TABLE IF EXISTS `c5` */;

/*!50001 CREATE TABLE  `c5`(
 `building_num` varchar(5) ,
 `admin_name` varchar(20) ,
 `room_type` varchar(5) ,
 `room` varchar(3) 
)*/;

/*View structure for view c1 */

/*!50001 DROP TABLE IF EXISTS `c1` */;
/*!50001 DROP VIEW IF EXISTS `c1` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `c1` AS select `building`.`building_num` AS `building_num`,`admin`.`admin_name` AS `admin_name`,`room`.`room_type` AS `room_type`,`room`.`room` AS `room` from ((`admin` join `room`) join `building`) where ((`building`.`building_num` = 'c1') and (`admin`.`admin_name` = '李叔') and (`room`.`room` like '1%')) */;

/*View structure for view c2 */

/*!50001 DROP TABLE IF EXISTS `c2` */;
/*!50001 DROP VIEW IF EXISTS `c2` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `c2` AS select `building`.`building_num` AS `building_num`,`admin`.`admin_name` AS `admin_name`,`room`.`room_type` AS `room_type`,`room`.`room` AS `room` from ((`admin` join `room`) join `building`) where ((`building`.`building_num` = 'c2') and (`admin`.`admin_name` = '陈阿姨') and (`room`.`room` like '2%')) */;

/*View structure for view c3 */

/*!50001 DROP TABLE IF EXISTS `c3` */;
/*!50001 DROP VIEW IF EXISTS `c3` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `c3` AS select `building`.`building_num` AS `building_num`,`admin`.`admin_name` AS `admin_name`,`room`.`room_type` AS `room_type`,`room`.`room` AS `room` from ((`admin` join `room`) join `building`) where ((`building`.`building_num` = 'c3') and (`admin`.`admin_name` = '周叔') and (`room`.`room` like '3%')) */;

/*View structure for view c4 */

/*!50001 DROP TABLE IF EXISTS `c4` */;
/*!50001 DROP VIEW IF EXISTS `c4` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `c4` AS select `building`.`building_num` AS `building_num`,`admin`.`admin_name` AS `admin_name`,`room`.`room_type` AS `room_type`,`room`.`room` AS `room` from ((`admin` join `room`) join `building`) where ((`building`.`building_num` = 'c4') and (`admin`.`admin_name` = '黄叔') and (`room`.`room` like '4%')) */;

/*View structure for view c5 */

/*!50001 DROP TABLE IF EXISTS `c5` */;
/*!50001 DROP VIEW IF EXISTS `c5` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `c5` AS select `building`.`building_num` AS `building_num`,`admin`.`admin_name` AS `admin_name`,`room`.`room_type` AS `room_type`,`room`.`room` AS `room` from ((`admin` join `room`) join `building`) where ((`building`.`building_num` = 'c5') and (`admin`.`admin_name` = '陆阿姨') and (`room`.`room` like '5%')) */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
