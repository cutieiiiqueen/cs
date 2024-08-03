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
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `category` varchar(20) NOT NULL,
  `unit_price` double NOT NULL,
  `stock` int NOT NULL,
  `release_date` date NOT NULL DEFAULT (curdate()),
  `photo_url` varchar(250) DEFAULT NULL,
  `description` varchar(250) NOT NULL DEFAULT '',
  `discount` int NOT NULL DEFAULT '0',
  `status` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'招牌綜合堅果','綜合堅果',250,100,'2024-04-24','/cs/images/products/1-300g.png','成分：核桃、杏仁、腰果、南瓜子、蔓越莓',50,0),(2,'經典綜合堅果','綜合堅果',250,0,'2024-04-24','/cs/images/products/2-240g.png','成分：核桃、杏仁、腰果、胡桃、夏威夷豆',0,0),(3,'開心果','單品堅果',200,0,'2024-04-24','/cs/images/products/3-300g.png','成分：開心果',10,0),(4,'經典大核桃','綜合堅果',200,0,'2024-04-24','/cs/images/products/4-250g.png','成分：核桃',0,0),(5,'經典大胡桃','綜合堅果',200,0,'2024-04-24','/cs/images/products/5-140g.png','成分：胡桃',0,0),(6,'經典杏仁','單品堅果',200,0,'2024-04-24','/cs/images/products/6-250g.png','成分：杏仁',0,0),(7,'經典大腰果','單品堅果',200,0,'2024-04-24','/cs/images/products/7-250g.png','成分：腰果',0,0),(8,'薑黃腰果','單品堅果',200,0,'2024-04-24','/cs/images/products/8-250g.png','成分：薑黃粉、腰果',0,0),(9,'夏威夷豆','單品堅果',200,0,'2024-04-24','/cs/images/products/9-140g.png','成分：夏威夷豆',0,0),(10,'經典大松子','單品堅果',300,0,'2024-04-24','/cs/images/products/10-120g.png','成分：松子',0,0),(11,'經典南瓜子','單品堅果',200,0,'2024-04-24','/cs/images/products/11-300g.png','成分：南瓜子',0,0),(12,'經典葵瓜子','單品堅果',100,0,'2024-04-24','/cs/images/products/12-280g.png','成分：葵瓜子',0,0),(13,'白薏仁爆米香 (海鹽)','爆米香',100,0,'2024-05-14','/cs/images/products/13-150g.png','成分：白薏仁、海鹽',0,0),(14,'糙薏仁爆米香 (原味)','爆米香',100,0,'2024-05-20','/cs/images/products/14-150g.png','成分：糙薏仁',0,0),(15,'糙薏仁爆米香 (海鹽)','爆米香',100,0,'2024-05-22','/cs/images/products/15-150g.png','成分：糙薏仁、海鹽',0,0),(16,'糙薏仁爆米香 (黑糖)','爆米香',100,0,'2024-05-20','/cs/images/products/16-150g.png','成分：糙薏仁、黑糖',0,0),(17,'珍珠果爆米香 (黑糖)','爆米香',100,31,'2024-05-20','/cs/images/products/17-150g.png','成分：玉米(非基因改造)、黑糖、棕櫚油(非氫化植物油)、楓糖、樹薯澱粉、海鹽',0,0),(18,'經典綜合爆米香 無調味','爆米香',180,0,'2024-05-20','/cs/images/products/18-280g.png','成分：糙薏仁、紫米、大麥、糙麥、糙米',0,0),(19,'核桐麥 (原味)','爆米香',100,0,'2024-05-20','/cs/images/products/19-150g.png','成分：核桐麥',0,0),(20,'綜合葡萄乾','果乾',200,0,'2024-05-20','/cs/images/products/1-300g.png','成分：紅葡萄乾、黑葡萄乾、黃葡萄乾、青堤子',0,0),(21,'蔓越莓','果乾',200,0,'2024-05-22','/cs/images/products/21-300g.png','成分：蔓越莓',0,0),(22,'黑芝麻糕','其他',180,0,'2024-05-24','/cs/images/products/22-260g.png','成分：黑芝麻、麥芽、穀粉(薏仁、糙麥、糙米、紫米、玉米(非基因改造))',0,0);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
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
