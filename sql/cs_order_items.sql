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
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `spec_name` varchar(10) NOT NULL,
  `price` double NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`order_id`,`product_id`,`spec_name`),
  KEY `FKEY_order_items_TO_products` (`product_id`),
  CONSTRAINT `FKEY_order_items_TO_orders` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `FKEY_order_items_TO_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,7,'250g',200,3),(2,2,'240g',250,3),(2,8,'250g',200,2),(2,20,'380g',200,1),(3,11,'300g',200,3),(3,17,'280g',280,4),(3,19,'150g',100,1),(4,1,'300g',225,3),(4,9,'140g',200,2),(4,13,'150g',100,2),(4,16,'280g',180,3),(4,17,'280g',280,3),(4,20,'380g',200,2),(4,21,'300g',200,2),(4,22,'260g',180,3),(5,4,'250g',200,1),(5,7,'250g',200,5),(5,18,'280g',180,2),(5,19,'150g',100,4),(6,6,'250g',200,4),(6,11,'300g',200,3),(6,12,'280g',100,3),(6,15,'150g',100,3),(6,17,'150g',100,2),(7,3,'300g',180,10),(7,8,'250g',200,5),(7,16,'280g',180,5),(8,9,'140g',200,2),(8,10,'120g',300,2),(9,3,'300g',180,2),(9,7,'250g',200,2),(9,8,'250g',200,3),(9,9,'140g',200,2),(10,3,'300g',180,4),(11,16,'150g',100,6),(12,4,'250g',200,3),(12,7,'250g',200,2),(12,9,'140g',200,5),(13,3,'300g',180,3),(14,4,'250g',200,5),(14,5,'140g',200,2),(15,4,'250g',200,3),(16,2,'240g',250,2),(17,3,'300g',180,3),(18,6,'250g',200,4),(18,7,'250g',200,8),(18,13,'150g',100,5),(19,11,'300g',200,3),(19,16,'150g',100,2),(19,16,'280g',180,2),(20,7,'250g',200,3),(21,2,'240g',250,8),(21,3,'300g',180,1),(22,7,'250g',200,3),(22,19,'280g',180,3),(23,6,'250g',200,4),(24,10,'120g',300,4),(25,4,'250g',180,5),(25,5,'140g',200,2),(26,2,'240g',225,2),(26,4,'250g',180,2),(26,7,'250g',200,5),(27,4,'250g',200,6),(28,7,'250g',200,2),(29,7,'250g',200,3);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-03  0:19:32
