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
-- Table structure for table `product_specs`
--

DROP TABLE IF EXISTS `product_specs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_specs` (
  `product_id` int NOT NULL,
  `spec_name` varchar(10) NOT NULL,
  `unit_price` double DEFAULT NULL,
  `stock` int NOT NULL,
  `photo_url` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`product_id`,`spec_name`),
  CONSTRAINT `FK_product_specs_TO_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_specs`
--

LOCK TABLES `product_specs` WRITE;
/*!40000 ALTER TABLE `product_specs` DISABLE KEYS */;
INSERT INTO `product_specs` VALUES (1,'300g',250,100,'/cs/images/products/1-300g.png'),(2,'240g',250,135,'/cs/images/products/2-240g.png'),(3,'300g',200,27,'/cs/images/products/3-300g.png'),(4,'250g',200,194,'/cs/images/products/4-250g.png'),(5,'140g',200,46,'/cs/images/products/5-140g.png'),(6,'250g',200,38,'/cs/images/products/6-250g.png'),(7,'250g',200,17,'/cs/images/products/7-250g.png'),(8,'250g',200,40,'/cs/images/products/8-250g.png'),(9,'140g',200,39,'/cs/images/products/9-140g.png'),(10,'120g',300,44,'/cs/images/products/10-120g.png'),(11,'300g',200,41,'/cs/images/products/11-300g.png'),(12,'280g',100,47,'/cs/images/products/12-280g.png'),(13,'150g',100,43,'/cs/images/products/13-150g.png'),(13,'280g',180,50,'/cs/images/products/13-280g.png'),(14,'150g',100,50,'/cs/images/products/14-150g.png'),(14,'280g',180,50,'/cs/images/products/14-280g.png'),(15,'150g',100,47,'/cs/images/products/15-150g.png'),(15,'280g',180,50,'/cs/images/products/15-280g.png'),(16,'150g',100,42,'/cs/images/products/16-150g.png'),(16,'280g',180,40,'/cs/images/products/16-280g.png'),(17,'150g',100,48,'/cs/images/products/17-150g.png'),(17,'280g',280,43,'/cs/images/products/17-280g.png'),(18,'280g',180,48,'/cs/images/products/18-280g.png'),(19,'150g',100,45,'/cs/images/products/19-150g.png'),(19,'280g',180,47,'/cs/images/products/19-280g.png'),(20,'380g',200,47,'/cs/images/products/20-380g.png'),(21,'300g',200,48,'/cs/images/products/21-300g.png'),(22,'260g',180,47,'/cs/images/products/22-260g.png');
/*!40000 ALTER TABLE `product_specs` ENABLE KEYS */;
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
