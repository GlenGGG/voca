-- MySQL dump 10.13  Distrib 8.0.11, for Win64 (x86_64)
--
-- Host: localhost    Database: voca_rdb
-- ------------------------------------------------------
-- Server version	8.0.11

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8mb4 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `voca_site_user`
--

DROP TABLE IF EXISTS `voca_site_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `voca_site_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `name` varchar(30) NOT NULL,
  `gender` int(11) DEFAULT NULL,
  `date_of_register` date NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_admin` tinyint(1) NOT NULL,
  `depart_id` int(11) DEFAULT NULL,
  `orgniza_id` int(11) DEFAULT NULL,
  `position_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `voca_site_user_depart_id_1c0074c1_fk_voca_site_depart_id` (`depart_id`),
  KEY `voca_site_user_orgniza_id_529ad3e1_fk_voca_site_orgniza_id` (`orgniza_id`),
  KEY `voca_site_user_position_id_58abbb9b_fk_voca_site_position_id` (`position_id`),
  CONSTRAINT `voca_site_user_depart_id_1c0074c1_fk_voca_site_depart_id` FOREIGN KEY (`depart_id`) REFERENCES `voca_site_depart` (`id`),
  CONSTRAINT `voca_site_user_orgniza_id_529ad3e1_fk_voca_site_orgniza_id` FOREIGN KEY (`orgniza_id`) REFERENCES `voca_site_orgniza` (`id`),
  CONSTRAINT `voca_site_user_position_id_58abbb9b_fk_voca_site_position_id` FOREIGN KEY (`position_id`) REFERENCES `voca_site_position` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voca_site_user`
--

LOCK TABLES `voca_site_user` WRITE;
/*!40000 ALTER TABLE `voca_site_user` DISABLE KEYS */;
INSERT INTO `voca_site_user` VALUES (1,'a','2018-07-06 00:00:00.000000','123@163.com','Dean',1,'2018-07-06',1,0,NULL,NULL,NULL),(2,'b','2018-07-06 00:00:00.000000','ljkljlk@163.com','Sam',1,'2018-07-06',1,0,NULL,NULL,NULL),(3,'c','2018-07-06 00:00:00.000000','gh@163.com','Link',1,'2018-07-06',1,0,NULL,NULL,NULL),(4,'d','2018-07-06 00:00:00.000000','ui@qq.com','Ruby',2,'2018-07-06',1,0,NULL,NULL,NULL),(5,'e','2018-07-06 00:00:00.000000','poiuy@qq.com','Jo',2,'2018-07-06',1,0,NULL,NULL,NULL),(6,'f','2018-07-06 00:00:00.000000','jdjj@qq.com','Hellen',2,'2018-07-06',1,0,NULL,NULL,NULL),(7,'g','2018-07-06 00:00:00.000000','hjhu@qq,com','Bobby',1,'2018-07-06',1,0,NULL,NULL,NULL),(8,'h','2018-07-06 00:00:00.000000','haha@qq.com','Lilith',2,'2018-07-06',1,0,NULL,NULL,NULL),(9,'i','2018-07-06 00:00:00.000000','heihei@qq.com','Luther',1,'2018-07-06',1,0,NULL,NULL,NULL),(10,'j','2018-07-06 00:00:00.000000','hehe@qq.com','Rick',1,'2018-07-06',1,0,NULL,NULL,NULL),(11,'k','2018-07-06 00:00:00.000000','yaya@qq.com','Glen',1,'2018-07-06',1,0,NULL,NULL,NULL),(12,'l','2018-07-06 00:00:00.000000','lkjh@163.com','Magge',2,'2018-07-06',1,0,NULL,NULL,NULL),(13,'m','2018-07-06 00:00:00.000000','jlk@163.com','Swing',1,'2018-07-06',1,0,NULL,NULL,NULL),(14,'n','2018-07-06 00:00:00.000000','asd@163.com','Tode',1,'2018-07-06',1,0,NULL,NULL,NULL),(15,'o','2018-07-06 00:00:00.000000','qwe@163.com','Pie',2,'2018-07-06',1,0,NULL,NULL,NULL),(16,'p','2018-07-06 00:00:00.000000','gjh@qq.com','Aplle',1,'2018-07-06',1,0,NULL,NULL,NULL),(17,'q','2018-07-06 00:00:00.000000','poi@qq.com','Mae',2,'2018-07-06',1,0,NULL,NULL,NULL),(18,'r','2018-07-06 00:00:00.000000','lkj@qq.com','Jesues',1,'2018-07-06',1,0,NULL,NULL,NULL),(19,'s','2018-07-06 00:00:00.000000','zzx@qq.com','God',1,'2018-07-06',1,0,NULL,NULL,NULL),(20,'t','2018-07-06 00:00:00.000000','asd@qq.com','Win',1,'2018-07-06',1,0,1,1,8),(21,'u','2018-07-06 00:00:00.000000','rty@qq.com','Jhon',1,'2018-07-06',1,0,2,2,7),(22,'v','2018-07-06 00:00:00.000000','wer@qq.com','Meoi',1,'2018-07-06',1,0,3,3,6),(23,'w','2018-07-06 00:00:00.000000','qwe@qq.com','Jude',2,'2018-07-06',1,0,4,4,5),(24,'x','2018-07-06 00:00:00.000000','369@qq.com','Mon',1,'2018-07-06',1,0,5,5,4),(25,'y','2018-07-06 00:00:00.000000','258@qq.com','Suck',2,'2018-07-06',1,0,6,6,3),(26,'z','2018-07-06 00:00:00.000000','963@qq.com','Yuu',2,'2018-07-06',1,1,7,7,2),(27,'a','2018-07-06 00:00:00.000000','741@qq.com','Graber',1,'2018-07-06',1,0,8,9,1),(28,'b','2018-07-06 00:00:00.000000','852@qq.com','Ryse',1,'2018-07-06',1,0,9,8,2),(29,'c','2018-07-06 00:00:00.000000','147@qq.com','Son',1,'2018-07-06',1,0,5,10,3),(30,'d','2018-07-06 00:00:00.000000','321@qq.com','Fartr',1,'2018-07-06',1,0,10,11,4),(31,'e','2018-07-06 00:00:00.000000','654@qq.com','Sawe',2,'2018-07-06',1,0,11,12,5),(32,'f','2018-07-06 00:00:00.000000','987@qq.com','Qweiu',1,'2018-07-06',1,0,12,13,6),(33,'g','2018-07-06 00:00:00.000000','789@qq.com','Pop',2,'2018-07-06',1,0,13,14,7),(34,'h','2018-07-06 00:00:00.000000','456@q.com','Push',1,'2018-07-06',1,0,14,15,8),(35,'i','2018-07-06 00:00:00.000000','123@qq.com','Jet',1,'2018-07-06',1,0,1,16,9),(36,'j','2018-07-06 00:00:00.000000','159@163.com','Lag',1,'2018-07-06',1,0,14,15,10),(37,'k','2018-07-06 00:00:00.000000','357@163.com','Backe',1,'2018-07-06',1,0,2,14,11),(38,'l','2018-07-06 00:00:00.000000','753@163.com','Robert',1,'2018-07-06',1,0,3,13,12),(39,'m','2018-07-06 00:00:00.000000','951@163.com','Lang',1,'2018-07-06',1,0,4,12,13),(40,'n','2018-07-06 00:00:00.000000','987@163.com','Lana',2,'2018-07-06',1,0,5,1,14),(41,'o','2018-07-06 00:00:00.000000','654@163.com','Taylor',2,'2018-07-06',1,0,6,11,13),(42,'p','2018-07-06 00:00:00.000000','321@163.com','Troie',1,'2018-07-06',1,0,7,10,12),(43,'q','2018-07-06 00:00:00.000000','369@163.com','Akelise',2,'2018-07-06',1,0,8,9,11),(44,'r','2018-07-06 00:00:00.000000','258@163.com','Iimp',1,'2018-07-06',1,0,9,8,10),(45,'s','2018-07-06 00:00:00.000000','147@163.com','Fiona',2,'2018-07-06',1,0,10,7,9),(46,'t','2018-07-06 00:00:00.000000','963@163.com','Frank',1,'2018-07-06',1,0,11,6,8),(47,'u','2018-07-06 00:00:00.000000','852@163.com','LLP',2,'2018-07-06',1,0,12,5,7),(48,'v','2018-07-06 00:00:00.000000','741@163.com','Hwe',1,'2018-07-06',1,0,13,4,6),(49,'w','2018-07-06 00:00:00.000000','789@163.com','Newyiork',2,'2018-07-06',1,0,14,3,5),(50,'x','2018-07-06 00:00:00.000000','456@136.com','Su',2,'2018-07-06',1,0,2,2,4);
/*!40000 ALTER TABLE `voca_site_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `IN_User_TRG` AFTER INSERT ON `voca_site_user` FOR EACH ROW insert into voca_site_pspage(email, update_time, user_id) values(NEW.email, now(), NEW.id) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `voca_site_pspage`
--

DROP TABLE IF EXISTS `voca_site_pspage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `voca_site_pspage` (
  `pspage_id` int(11) NOT NULL AUTO_INCREMENT,
  `info` longtext,
  `email` varchar(255) NOT NULL,
  `joborein` longtext,
  `update_time` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`pspage_id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `voca_site_pspage_user_id_e4ae0356_fk_voca_site_user_id` FOREIGN KEY (`user_id`) REFERENCES `voca_site_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voca_site_pspage`
--

LOCK TABLES `voca_site_pspage` WRITE;
/*!40000 ALTER TABLE `voca_site_pspage` DISABLE KEYS */;
INSERT INTO `voca_site_pspage` VALUES (1,'本科','456@136.com',NULL,'2018-07-06 18:24:23.000000',50),(2,'本科','789@163.com',NULL,'2018-07-06 18:24:23.000000',49),(3,'本科','741@163.com',NULL,'2018-07-06 18:24:23.000000',48),(4,'本科','852@163.com',NULL,'2018-07-06 18:24:23.000000',47),(5,'本科','963@163.com',NULL,'2018-07-06 18:24:23.000000',46),(6,'本科','147@163.com',NULL,'2018-07-06 18:24:23.000000',45),(7,'本科','258@163.com',NULL,'2018-07-06 18:24:23.000000',44),(8,'本科','369@163.com',NULL,'2018-07-06 18:24:23.000000',43),(9,'本科','321@163.com',NULL,'2018-07-06 18:24:23.000000',42),(10,'本科','654@163.com',NULL,'2018-07-06 18:24:23.000000',41),(11,'本科','987@163.com',NULL,'2018-07-06 18:24:23.000000',40),(12,'本科','951@163.com',NULL,'2018-07-06 18:24:23.000000',39),(13,'本科','753@163.com',NULL,'2018-07-06 18:24:23.000000',38),(14,'本科','357@163.com',NULL,'2018-07-06 18:24:23.000000',37),(15,'本科','159@163.com',NULL,'2018-07-06 18:24:23.000000',36),(16,'本科','123@qq.com',NULL,'2018-07-06 18:24:23.000000',35),(17,'本科','456@q.com',NULL,'2018-07-06 18:24:23.000000',34),(18,'本科','789@qq.com',NULL,'2018-07-06 18:24:23.000000',33),(19,'本科','987@qq.com',NULL,'2018-07-06 18:24:23.000000',32),(20,'本科','654@qq.com',NULL,'2018-07-06 18:24:23.000000',31),(21,'本科','321@qq.com',NULL,'2018-07-06 18:24:23.000000',30),(22,'本科','147@qq.com',NULL,'2018-07-06 18:24:23.000000',29),(23,'本科','852@qq.com',NULL,'2018-07-06 18:24:23.000000',28),(24,'本科','741@qq.com',NULL,'2018-07-06 18:24:23.000000',27),(25,'本科','963@qq.com',NULL,'2018-07-06 18:24:23.000000',26),(26,'本科','258@qq.com',NULL,'2018-07-06 18:24:23.000000',25),(27,'本科','369@qq.com',NULL,'2018-07-06 18:24:23.000000',24),(28,'本科','qwe@qq.com',NULL,'2018-07-06 18:24:23.000000',23),(29,'本科','wer@qq.com',NULL,'2018-07-06 18:24:23.000000',22),(30,'本科','rty@qq.com',NULL,'2018-07-06 18:24:23.000000',21),(31,'本科','asd@qq.com',NULL,'2018-07-06 18:24:23.000000',20),(32,'本科','zzx@qq.com','经理','2018-07-06 18:24:23.000000',19),(33,'本科','lkj@qq.com','经理','2018-07-06 18:24:23.000000',18),(34,'本科','poi@qq.com','经理','2018-07-06 18:24:23.000000',17),(35,'本科','gjh@qq.com','经理','2018-07-06 18:24:23.000000',16),(36,'本科','qwe@163.com','经理','2018-07-06 18:24:23.000000',15),(37,'本科','asd@163.com','经理','2018-07-06 18:24:23.000000',14),(38,'本科','jlk@163.com','经理','2018-07-06 18:24:23.000000',13),(39,'本科','lkjh@163.com','经理','2018-07-06 18:24:23.000000',12),(40,'本科','yaya@qq.com','经理','2018-07-06 18:24:23.000000',11),(41,'本科','hehe@qq.com','经理','2018-07-06 18:24:23.000000',10),(42,'本科','heihei@qq.com','经理','2018-07-06 18:24:23.000000',9),(43,'本科','haha@qq.com','经理','2018-07-06 18:24:23.000000',8),(44,'本科','hjhu@qq,com','经理','2018-07-06 18:24:23.000000',7),(45,'本科','jdjj@qq.com','经理','2018-07-06 18:24:23.000000',6),(46,'本科','poiuy@qq.com','经理','2018-07-06 18:24:23.000000',5),(47,'本科','ui@qq.com','经理','2018-07-06 18:24:23.000000',4),(48,'本科','gh@163.com','经理','2018-07-06 18:24:23.000000',3),(49,'本科','ljkljlk@163.com','经理','2018-07-06 18:24:23.000000',2),(50,'本科','123@163.com','经理','2018-07-06 18:24:23.000000',1);
/*!40000 ALTER TABLE `voca_site_pspage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voca_site_univs`
--

DROP TABLE IF EXISTS `voca_site_univs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `voca_site_univs` (
  `univs_id` varchar(8) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`univs_id`),
  UNIQUE KEY `voca_site_univs_name_cf656e1f_uniq` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voca_site_univs`
--

LOCK TABLES `voca_site_univs` WRITE;
/*!40000 ALTER TABLE `voca_site_univs` DISABLE KEYS */;
INSERT INTO `voca_site_univs` VALUES ('a9','Columbia Univ'),('a4','Cornell Univ'),('a1','Harvard Univ'),('a7','Princeton Univ'),('a2','Stanford Univ'),('a5','Tokyo Univ'),('a3','Univ Cambridge'),('a10','Univ Chicago'),('a8','Univ Oxford'),('a6','Yale Univ');
/*!40000 ALTER TABLE `voca_site_univs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voca_site_depart`
--

DROP TABLE IF EXISTS `voca_site_depart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `voca_site_depart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `voca_site_depart_name_1c19869f_uniq` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voca_site_depart`
--

LOCK TABLES `voca_site_depart` WRITE;
/*!40000 ALTER TABLE `voca_site_depart` DISABLE KEYS */;
INSERT INTO `voca_site_depart` VALUES (10,'产品开发部'),(3,'人事部'),(7,'出口部'),(4,'后勤部'),(6,'国际部'),(13,'客服部'),(11,'市场部'),(9,'广告部'),(14,'技术部'),(2,'秘书处'),(1,'营销部'),(12,'行政部'),(5,'财务部'),(8,'进口部');
/*!40000 ALTER TABLE `voca_site_depart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voca_site_orgniza`
--

DROP TABLE IF EXISTS `voca_site_orgniza`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `voca_site_orgniza` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `voca_site_orgniza_name_4b915e6e_uniq` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voca_site_orgniza`
--

LOCK TABLES `voca_site_orgniza` WRITE;
/*!40000 ALTER TABLE `voca_site_orgniza` DISABLE KEYS */;
INSERT INTO `voca_site_orgniza` VALUES (1,'腾飞公司','北京'),(2,'华谊公司','北京'),(3,'狮门影视','纽约'),(4,'惠普','加利福尼亚'),(5,'飞利浦电器','上海'),(6,'科尔兄弟','弗罗里达'),(7,'猎人保全','德克萨斯'),(8,'微软','硅谷'),(9,'美的','北京'),(10,'京东','上海'),(11,'淘宝','北京'),(12,'叮当药业','香港'),(13,'同仁堂','北京'),(14,'协和医院','北京'),(15,'东方航空','杭州'),(16,'亚马逊','纽约');
/*!40000 ALTER TABLE `voca_site_orgniza` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voca_site_position`
--

DROP TABLE IF EXISTS `voca_site_position`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `voca_site_position` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(15) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `voca_site_position_name_d3c99e48_uniq` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voca_site_position`
--

LOCK TABLES `voca_site_position` WRITE;
/*!40000 ALTER TABLE `voca_site_position` DISABLE KEYS */;
INSERT INTO `voca_site_position` VALUES (10,'产品开发部经理'),(3,'人事部经理'),(7,'出口部部长'),(2,'副总经理'),(4,'后勤部经理'),(6,'国际部部长'),(13,'客服部部长'),(11,'市场部经理'),(9,'广告部部长'),(1,'总经理'),(14,'技术部经理'),(12,'行政部部长'),(5,'财务部经理'),(8,'进口部部长');
/*!40000 ALTER TABLE `voca_site_position` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voca_site_pspage_user_visit`
--

DROP TABLE IF EXISTS `voca_site_pspage_user_visit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `voca_site_pspage_user_visit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `visit_time` datetime(6) NOT NULL,
  `pspage_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `voca_site_pspageuservisi_pspage_id_user_id_visit__651a470c_uniq` (`pspage_id`,`user_id`,`visit_time`),
  KEY `voca_site_pspageuservisit_user_id_44e9f26b_fk_voca_site_user_id` (`user_id`),
  CONSTRAINT `voca_site_pspageuser_pspage_id_9a1825c7_fk_voca_site` FOREIGN KEY (`pspage_id`) REFERENCES `voca_site_pspage` (`pspage_id`),
  CONSTRAINT `voca_site_pspageuservisit_user_id_44e9f26b_fk_voca_site_user_id` FOREIGN KEY (`user_id`) REFERENCES `voca_site_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voca_site_pspage_user_visit`
--

LOCK TABLES `voca_site_pspage_user_visit` WRITE;
/*!40000 ALTER TABLE `voca_site_pspage_user_visit` DISABLE KEYS */;
INSERT INTO `voca_site_pspage_user_visit` VALUES (1,'2018-07-01 00:00:00.000000',1,1),(2,'2018-07-01 00:00:00.000000',2,2),(3,'2018-07-01 00:00:00.000000',3,3),(4,'2018-07-01 00:00:00.000000',4,4),(5,'2018-07-01 00:00:00.000000',5,5),(6,'2018-07-01 00:00:00.000000',6,6),(7,'2018-07-01 00:00:00.000000',7,7),(8,'2018-07-01 00:00:00.000000',8,8),(9,'2018-07-01 00:00:00.000000',9,9),(10,'2018-07-01 00:00:00.000000',10,10),(11,'2018-07-01 00:00:00.000000',11,11),(12,'2018-07-01 00:00:00.000000',12,12),(13,'2018-07-01 00:00:00.000000',13,13),(14,'2018-07-01 00:00:00.000000',14,14),(15,'2018-07-01 00:00:00.000000',15,15);
/*!40000 ALTER TABLE `voca_site_pspage_user_visit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voca_site_user_friend`
--

DROP TABLE IF EXISTS `voca_site_user_friend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `voca_site_user_friend` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `from_user_id` int(11) NOT NULL,
  `to_user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `voca_site_user_friend_from_user_id_to_user_id_dbd10646_uniq` (`from_user_id`,`to_user_id`),
  KEY `voca_site_user_friend_to_user_id_ff94a351_fk_voca_site_user_id` (`to_user_id`),
  CONSTRAINT `voca_site_user_friend_from_user_id_d2019ec5_fk_voca_site_user_id` FOREIGN KEY (`from_user_id`) REFERENCES `voca_site_user` (`id`),
  CONSTRAINT `voca_site_user_friend_to_user_id_ff94a351_fk_voca_site_user_id` FOREIGN KEY (`to_user_id`) REFERENCES `voca_site_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voca_site_user_friend`
--

LOCK TABLES `voca_site_user_friend` WRITE;
/*!40000 ALTER TABLE `voca_site_user_friend` DISABLE KEYS */;
INSERT INTO `voca_site_user_friend` VALUES (1,1,50),(2,2,49),(3,3,48),(4,4,47),(5,5,46),(6,6,45),(7,7,44),(8,8,43),(9,9,42),(10,10,41),(20,41,10),(19,42,9),(18,43,8),(17,44,7),(16,45,6),(15,46,5),(14,47,4),(13,48,3),(12,49,2),(11,50,1);
/*!40000 ALTER TABLE `voca_site_user_friend` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voca_site_user_univs_attend`
--

DROP TABLE IF EXISTS `voca_site_user_univs_attend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `voca_site_user_univs_attend` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `enroll_time` datetime(6) DEFAULT NULL,
  `univs_id` varchar(8) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `voca_site_userunivsattend_user_id_univs_id_16f4e8f7_uniq` (`user_id`,`univs_id`),
  KEY `voca_site_userunivsa_univs_id_94635c1a_fk_voca_site` (`univs_id`),
  CONSTRAINT `voca_site_userunivsa_univs_id_94635c1a_fk_voca_site` FOREIGN KEY (`univs_id`) REFERENCES `voca_site_univs` (`univs_id`),
  CONSTRAINT `voca_site_userunivsattend_user_id_7582e825_fk_voca_site_user_id` FOREIGN KEY (`user_id`) REFERENCES `voca_site_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voca_site_user_univs_attend`
--

LOCK TABLES `voca_site_user_univs_attend` WRITE;
/*!40000 ALTER TABLE `voca_site_user_univs_attend` DISABLE KEYS */;
INSERT INTO `voca_site_user_univs_attend` VALUES (1,NULL,'a1',1),(2,NULL,'a2',2),(3,NULL,'a3',3),(4,NULL,'a4',4),(5,NULL,'a5',5),(6,NULL,'a6',6),(7,NULL,'a7',7),(8,NULL,'a8',8),(9,NULL,'a9',9),(10,NULL,'a10',10),(11,NULL,'a1',11),(12,NULL,'a2',12),(13,NULL,'a3',13),(14,NULL,'a4',14),(15,NULL,'a5',15),(16,NULL,'a6',16),(17,NULL,'a7',17),(18,NULL,'a8',18),(19,NULL,'a9',19),(20,NULL,'a10',20),(21,NULL,'a1',21),(22,NULL,'a2',22),(23,NULL,'a3',23),(24,NULL,'a4',24),(25,NULL,'a5',25),(26,NULL,'a6',26),(27,NULL,'a7',27),(28,NULL,'a8',28),(29,NULL,'a9',29),(30,NULL,'a10',30),(31,NULL,'a1',31),(32,NULL,'a2',32),(33,NULL,'a3',33),(34,NULL,'a4',34),(35,NULL,'a5',35),(36,NULL,'a6',36),(37,NULL,'a7',37),(38,NULL,'a8',38),(39,NULL,'a9',39),(40,NULL,'a10',40),(41,NULL,'a1',41),(42,NULL,'a2',42),(43,NULL,'a3',43),(44,NULL,'a4',44),(45,NULL,'a5',45),(46,NULL,'a6',46),(47,NULL,'a7',47),(48,NULL,'a8',48),(49,NULL,'a9',49),(50,NULL,'a10',50);
/*!40000 ALTER TABLE `voca_site_user_univs_attend` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voca_site_user_univs_gra`
--

DROP TABLE IF EXISTS `voca_site_user_univs_gra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `voca_site_user_univs_gra` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `grad_time` datetime(6) DEFAULT NULL,
  `univs_id` varchar(8) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `voca_site_userunivsgra_user_id_univs_id_8fb1a31d_uniq` (`user_id`,`univs_id`),
  KEY `voca_site_userunivsg_univs_id_a5b7d827_fk_voca_site` (`univs_id`),
  CONSTRAINT `voca_site_userunivsg_univs_id_a5b7d827_fk_voca_site` FOREIGN KEY (`univs_id`) REFERENCES `voca_site_univs` (`univs_id`),
  CONSTRAINT `voca_site_userunivsgra_user_id_b53a10d0_fk_voca_site_user_id` FOREIGN KEY (`user_id`) REFERENCES `voca_site_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voca_site_user_univs_gra`
--

LOCK TABLES `voca_site_user_univs_gra` WRITE;
/*!40000 ALTER TABLE `voca_site_user_univs_gra` DISABLE KEYS */;
INSERT INTO `voca_site_user_univs_gra` VALUES (1,NULL,'a1',1),(2,NULL,'a2',2),(3,NULL,'a3',3),(4,NULL,'a4',4),(5,NULL,'a5',5),(6,NULL,'a6',6),(7,NULL,'a7',7),(8,NULL,'a8',8),(9,NULL,'a9',9),(10,NULL,'a10',10),(11,NULL,'a1',11),(12,NULL,'a2',12),(13,NULL,'a3',13),(14,NULL,'a4',14),(15,NULL,'a5',15),(16,NULL,'a6',16),(17,NULL,'a7',17),(18,NULL,'a8',18),(19,NULL,'a9',19),(20,NULL,'a10',20),(21,NULL,'a1',21),(22,NULL,'a2',22),(23,NULL,'a3',23),(24,NULL,'a4',24),(25,NULL,'a5',25),(26,NULL,'a6',26),(27,NULL,'a7',27),(28,NULL,'a8',28),(29,NULL,'a9',29),(30,NULL,'a10',30),(31,NULL,'a1',31),(32,NULL,'a2',32),(33,NULL,'a3',33),(34,NULL,'a4',34),(35,NULL,'a5',35),(36,NULL,'a6',36),(37,NULL,'a7',37),(38,NULL,'a8',38),(39,NULL,'a9',39),(40,NULL,'a10',40),(41,NULL,'a1',41),(42,NULL,'a2',42),(43,NULL,'a3',43),(44,NULL,'a4',44),(45,NULL,'a5',45),(46,NULL,'a6',46),(47,NULL,'a7',47),(48,NULL,'a8',48),(49,NULL,'a9',49),(50,NULL,'a10',50);
/*!40000 ALTER TABLE `voca_site_user_univs_gra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voca_site_user_user_message`
--

DROP TABLE IF EXISTS `voca_site_user_user_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `voca_site_user_user_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message_receiver_id` int(11) NOT NULL,
  `message_sender_id` int(11) NOT NULL,
  `message` longtext NOT NULL,
  `message_sent_time` datetime(6) NOT NULL,
  `message_read` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `voca_site_user_user__message_receiver_id_f7e008b9_fk_voca_site` (`message_receiver_id`),
  KEY `voca_site_user_user__message_sender_id_0dd585c6_fk_voca_site` (`message_sender_id`),
  CONSTRAINT `voca_site_user_user__message_receiver_id_f7e008b9_fk_voca_site` FOREIGN KEY (`message_receiver_id`) REFERENCES `voca_site_user` (`id`),
  CONSTRAINT `voca_site_user_user__message_sender_id_0dd585c6_fk_voca_site` FOREIGN KEY (`message_sender_id`) REFERENCES `voca_site_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voca_site_user_user_message`
--

LOCK TABLES `voca_site_user_user_message` WRITE;
/*!40000 ALTER TABLE `voca_site_user_user_message` DISABLE KEYS */;
INSERT INTO `voca_site_user_user_message` VALUES (1,1,2,'Fly to the moon','2018-07-08 00:00:00.000000',0),(2,3,4,'promise','2018-07-08 00:00:00.000000',1),(3,5,6,'yellow line','2018-07-08 00:00:00.000000',0),(4,7,8,'worrior','2018-07-08 00:00:00.000000',1),(5,9,10,'mad hat','2018-07-08 00:00:00.000000',0),(6,11,12,'jet lag','2018-07-08 00:00:00.000000',1),(7,13,14,'born to love','2018-07-08 00:00:00.000000',1),(8,15,16,'supernatural','2018-07-08 00:00:00.000000',0),(9,17,18,'demon','2018-07-08 00:00:00.000000',0),(10,19,20,'vampire','2018-07-08 00:00:00.000000',1);
/*!40000 ALTER TABLE `voca_site_user_user_message` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `IN_User_User_Message_TRG` AFTER INSERT ON `voca_site_user_user_message` FOR EACH ROW BEGIN
	IF NEW.message_receiver_id = NEW.message_sender_id THEN
		SIGNAL SQLSTATE 'TX000' SET MESSAGE_TEXT = 'Exception occurred when user send message to himself/herself';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-07-07 20:51:55
