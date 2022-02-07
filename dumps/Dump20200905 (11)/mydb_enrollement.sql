-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	8.0.19

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
-- Table structure for table `enrollement`
--

DROP TABLE IF EXISTS `enrollement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enrollement` (
  `id_Enrollement` int NOT NULL AUTO_INCREMENT,
  `id_registeration` int NOT NULL,
  `id_student` int NOT NULL,
  PRIMARY KEY (`id_Enrollement`),
  KEY `fk_Enrollement_registeration1_idx` (`id_registeration`),
  KEY `fk_Enrollement_student1_idx` (`id_student`),
  CONSTRAINT `fk_Enrollement_registeration1` FOREIGN KEY (`id_registeration`) REFERENCES `registeration` (`id_registeration`),
  CONSTRAINT `fk_Enrollement_student1` FOREIGN KEY (`id_student`) REFERENCES `student` (`id_student`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrollement`
--

LOCK TABLES `enrollement` WRITE;
/*!40000 ALTER TABLE `enrollement` DISABLE KEYS */;
INSERT INTO `enrollement` VALUES (1,7,6),(2,6,7),(3,8,7),(4,9,7),(5,5,4),(6,8,9),(7,4,4),(8,4,3),(9,4,5),(10,5,5),(11,1,1),(12,3,1),(13,8,8),(14,6,10);
/*!40000 ALTER TABLE `enrollement` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-09-05  2:38:01
