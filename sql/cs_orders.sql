-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: cs
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_email` varchar(60) NOT NULL,
  `created_date` date NOT NULL,
  `created_time` time NOT NULL,
  `status` int NOT NULL,
  `shipping_type` varchar(10) NOT NULL,
  `shipping_fee` double NOT NULL,
  `shipping_note` varchar(250) DEFAULT NULL,
  `payment_type` varchar(10) NOT NULL,
  `payment_fee` double NOT NULL,
  `payment_note` varchar(250) DEFAULT NULL,
  `recipient_name` varchar(20) NOT NULL,
  `recipient_email` varchar(60) NOT NULL,
  `recipient_phone` varchar(20) NOT NULL,
  `shipping_address` varchar(100) NOT NULL,
  `sub_total` double NOT NULL,
  `discount_amount` double NOT NULL,
  `total_amount` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKEY_orders_TO_customers_idx` (`customer_email`),
  CONSTRAINT `FKEY_orders_TO_customers` FOREIGN KEY (`customer_email`) REFERENCES `customers` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'1noahhan210@gmail.com','2022-08-30','21:06:44',6,'STORE',60,'貨運單號:741852963 已簽收','CARD',0,'信用卡號:4311-95**-****2222,授權碼:777777,交易時間:2024-06-30T21:07:04.006834800','韓諾亞公主','1noahhan210@gmail.com','0920010210','全家南京復興店,台北市中山區復興北路１５４號１Ｆ,店號:21075',600,600,660),(2,'1noahhan210@gmail.com','2023-01-15','10:22:19',6,'SHOP',0,'客戶已簽收','SHOP',0,'已付款','韓諾亞','1noahhan210@gmail.com','0920010210','胖松鼠實體店　新北市新店區中正路270號1樓',1350,1215,1215),(3,'1noahhan210@gmail.com','2024-03-30','21:24:49',6,'HOME',150,'已簽收','ATM',0,'已確認款項','韓諾亞','1noahhan210@gmail.com','0920010210','台北市復興北路99號12樓',1820,1638,1788),(4,'1noahhan210@gmail.com','2024-04-30','21:28:25',6,'STORE',60,'已完成','STORE',0,'已確認款項','韓諾亞','1noahhan210@gmail.com','0920010210','全家南京復興店,台北市中山區復興北路１５４號１Ｆ,店號:21075',3995,3596,3656),(5,'1noahhan210@gmail.com','2024-04-30','21:30:35',6,'HOME',150,'已完成','HOME',50,'已確認款項','韓諾亞','1noahhan210@gmail.com','0920010210','台北市復興北路99號12樓',1960,1764,1964),(6,'test005@gmail.com','2024-05-01','21:32:44',6,'SHOP',0,'已簽收','SHOP',0,'已確認款項','烏咪','test005@gmail.com','0912345674','胖松鼠實體店　新北市新店區中正路270號1樓',2200,2200,2200),(7,'test005@gmail.com','2024-05-05','21:33:16',6,'HOME',150,'已簽收','HOME',50,'已確認款項','烏咪','test005@gmail.com','0912345674','台北市復興北路99號',3700,3700,3900),(8,'test005@gmail.com','2024-05-22','21:33:35',6,'HOME',150,'已簽收','HOME',50,'已確認款項','烏咪','test005@gmail.com','0912345674','台北市復興北路99號',1000,1000,1200),(9,'test005@gmail.com','2024-05-23','21:49:06',6,'HOME',150,'已簽收','HOME',50,'已確認款項','烏咪','test005@gmail.com','0912345674','台北市復興北路99號',1760,1760,1960),(10,'test005@gmail.com','2024-05-23','21:50:26',6,'STORE',60,'已簽收','STORE',0,'已確認款項','烏咪','test005@gmail.com','0912345674','全家松山車站店,台北市信義區松山路11號,店號:20236',720,720,780),(11,'test005@gmail.com','2024-05-24','21:50:47',6,'HOME',150,'已簽收','ATM',0,'已確認款項','烏咪','test005@gmail.com','0912345674','台北市復興北路99號',600,600,750),(12,'1noahhan210@gmail.com','2024-05-25','22:00:25',6,'STORE',60,'已簽收','CARD',0,'已確認款項','韓諾亞','1noahhan210@gmail.com','0920010210','全家敦中店,台北市松山區敦化北路4巷1號,店號:11718',2000,1800,1860),(13,'1noahhan210@gmail.com','2024-05-26','22:00:56',6,'HOME',150,'已簽收','CARD',0,'已確認款項','韓諾亞','1noahhan210@gmail.com','0920010210','台北市復興北路99號12樓',540,486,636),(14,'test005@gmail.com','2024-05-27','22:17:58',6,'STORE',60,'已簽收','CARD',0,'已確認款項','烏咪','test005@gmail.com','0912345674','全家南京復興店,台北市中山區復興北路１５４號１Ｆ,店號:21075',1400,1260,1320),(15,'test005@gmail.com','2024-05-28','22:18:19',6,'HOME',150,'已簽收','CARD',0,'已確認款項','烏咪','test005@gmail.com','0912345674','台北市復興北路99號',600,540,690),(16,'test005@gmail.com','2024-05-28','22:18:52',6,'HOME',150,'已簽收','CARD',0,'已確認款項','烏咪','test005@gmail.com','0912345674','台北市復興北路99號',500,450,600),(17,'test005@gmail.com','2024-05-30','22:21:09',6,'HOME',150,'已簽收','CARD',0,'已確認款項','烏咪','test005@gmail.com','0912345674','台北市復興北路99號',540,486,636),(18,'test005@gmail.com','2024-06-01','23:03:24',6,'HOME',150,'已簽收','ATM',0,'已確認款項','烏咪','test005@gmail.com','0912345674','台北市復興北路99號',2900,2900,3050),(19,'test005@gmail.com','2024-06-15','23:12:42',6,'STORE',60,'已簽收','CARD',0,'已確認款項','烏咪','test005@gmail.com','0912345674','全家南京復興店,台北市中山區復興北路１５４號１Ｆ,店號:21075',1160,1160,1220),(20,'test005@gmail.com','2024-06-24','23:13:29',6,'HOME',150,'已簽收','ATM',0,'已確認款項','烏咪','test005@gmail.com','0912345674','台北市復興北路99號',600,600,750),(21,'test005@gmail.com','2024-06-30','23:27:29',3,'STORE',60,'貨運單號:741852963','CARD',0,'信用卡號:4311-95**-****2222,授權碼:777777,交易時間:2024-06-30T23:27:50.875471500','烏咪','test005@gmail.com','0912345674','全家南京復興店,台北市中山區復興北路１５４號１Ｆ,店號:21075',2180,2180,2240),(22,'test005@gmail.com','2024-07-02','22:22:46',3,'STORE',60,'貨運編號:147258963','CARD',0,'信用卡號:4311-95**-****2222,授權碼:777777,交易時間:2024-07-02T22:23:08.536178600','烏咪','test005@gmail.com','0912345674','全家南京復興店,台北市中山區復興北路１５４號１Ｆ,店號:21075',1140,1140,1200),(23,'test005@gmail.com','2024-07-02','22:38:39',0,'STORE',60,NULL,'CARD',0,NULL,'烏咪','test005@gmail.com','0912345674','全家南京復興店,台北市中山區復興北路１５４號１Ｆ,店號:21075',800,800,860),(24,'test005@gmail.com','2024-07-02','22:39:25',3,'HOME',150,'貨運編號741852963','CARD',0,'信用卡號:4311-95**-****2222,授權碼:777777,交易時間:2024-07-02T22:39:47.917193700','烏咪','test005@gmail.com','0912345674','台北市復興北路99號',1200,1200,1350),(25,'test005@gmail.com','2024-07-02','23:32:09',0,'STORE',60,NULL,'CARD',0,NULL,'烏咪','test005@gmail.com','0912345674','全家南京復興店,台北市中山區復興北路１５４號１Ｆ,店號:21075',1300,1170,1230),(26,'test005@gmail.com','2024-07-02','23:33:07',3,'HOME',150,'貨運編號:147258963','CARD',0,'信用卡號:4311-95**-****2222,授權碼:777777,交易時間:2024-07-02T23:33:27.771890800','烏咪','test005@gmail.com','0912345674','台北市復興北路99號',1810,1629,1779),(27,'test005@gmail.com','2024-07-02','23:48:04',0,'STORE',60,NULL,'CARD',0,NULL,'烏咪','test005@gmail.com','0912345674','全家南京復興店,台北市中山區復興北路１５４號１Ｆ,店號:21075',1200,1080,1140),(28,'test005@gmail.com','2024-07-02','23:48:43',3,'HOME',150,'貨運單號:741852963','CARD',0,'信用卡號:4311-95**-****2222,授權碼:777777,交易時間:2024-07-02T23:49:04.018020600','烏咪','test005@gmail.com','0912345674','台北市復興北路99號',400,360,510),(29,'test005@gmail.com','2024-07-03','00:13:28',3,'STORE',60,'貨運單號741852963','CARD',0,'信用卡號:4311-95**-****2222,授權碼:777777,交易時間:2024-07-03T00:13:53.520911100','烏咪','test005@gmail.com','0912345674','全家慶城店,台北市松山區慶城街8號,店號:2710',600,540,600);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `log_orders_status` AFTER UPDATE ON `orders` FOR EACH ROW INSERT INTO order_logs(order_id, old_status, new_status, payment_note, shipping_note) 
		VALUES (new.id, old.status, new.status, new.payment_note, new.shipping_note) */;;
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

-- Dump completed on 2024-07-03  0:19:32
