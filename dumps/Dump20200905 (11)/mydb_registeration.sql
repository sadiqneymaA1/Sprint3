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
-- Table structure for table `registeration`
--

DROP TABLE IF EXISTS `registeration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registeration` (
  `id_registeration` int NOT NULL AUTO_INCREMENT,
  `year` int NOT NULL,
  `term` varchar(6) NOT NULL,
  `professor_name` varchar(45) NOT NULL,
  `capacity` varchar(45) NOT NULL,
  `id_Course` int NOT NULL,
  PRIMARY KEY (`id_registeration`),
  UNIQUE KEY `idregisteration_UNIQUE` (`id_registeration`),
  KEY `fk_registeration_Course_idx` (`id_Course`),
  CONSTRAINT `fk_registeration_Course` FOREIGN KEY (`id_Course`) REFERENCES `course` (`id_Course`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registeration`
--

LOCK TABLES `registeration` WRITE;
/*!40000 ALTER TABLE `registeration` DISABLE KEYS */;
INSERT INTO `registeration` VALUES (1,2016,'fall','Morring','30',1),(2,2016,'fall','Nate','50',2),(3,2016,'fall','Nate','50',2),(4,2016,'fall','Barrus','35',3),(5,2016,'fall','Jensen','30',4),(6,2017,'winter','Morring','30',1),(7,2017,'winter','Barney','35',1),(8,2017,'winter','Nate','50',2),(9,2017,'winter','Jensen','30',4);
/*!40000 ALTER TABLE `registeration` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-09-05  2:38:00
