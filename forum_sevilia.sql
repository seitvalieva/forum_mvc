-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.30 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for forum_sevilia
CREATE DATABASE IF NOT EXISTS `forum_sevilia` /*!40100 DEFAULT CHARACTER SET latin1 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `forum_sevilia`;

-- Dumping structure for table forum_sevilia.message
CREATE TABLE IF NOT EXISTS `message` (
  `id_message` int NOT NULL AUTO_INCREMENT,
  `textMessage` text NOT NULL,
  `postDate` datetime DEFAULT NULL,
  `user_id` int NOT NULL DEFAULT '0',
  `topic_id` int NOT NULL,
  PRIMARY KEY (`id_message`),
  KEY `id_user` (`user_id`) USING BTREE,
  KEY `id_topic` (`topic_id`) USING BTREE,
  CONSTRAINT `FK__forum_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id_user`),
  CONSTRAINT `FK_message_topic` FOREIGN KEY (`topic_id`) REFERENCES `topic` (`id_topic`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- Dumping data for table forum_sevilia.message: ~7 rows (approximately)
INSERT INTO `message` (`id_message`, `textMessage`, `postDate`, `user_id`, `topic_id`) VALUES
	(1, 'hello', '2024-06-11 16:07:02', 1, 2),
	(2, 'hola', '2024-06-11 16:07:04', 3, 1),
	(3, 'salut', '2024-06-11 16:07:09', 2, 3),
	(4, 'que tal?', '2024-06-11 16:07:11', 3, 1),
	(5, 'how are you?', '2024-06-11 16:07:12', 1, 2),
	(6, 'comment ca va?', '2024-06-11 16:07:12', 2, 3),
	(7, 'test', '2024-06-11 16:07:13', 1, 1);

-- Dumping structure for table forum_sevilia.topic
CREATE TABLE IF NOT EXISTS `topic` (
  `id_topic` int NOT NULL AUTO_INCREMENT,
  `titleTopic` varchar(50) NOT NULL DEFAULT '0',
  `publicationDate` datetime DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id_topic`),
  KEY `id_user` (`user_id`) USING BTREE,
  CONSTRAINT `FK_topic_forum_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Dumping data for table forum_sevilia.topic: ~3 rows (approximately)
INSERT INTO `topic` (`id_topic`, `titleTopic`, `publicationDate`, `user_id`) VALUES
	(1, 'topic es', '2024-06-11 16:07:23', 3),
	(2, 'topic en', '2024-06-11 16:07:24', 1),
	(3, 'topic fr', '2024-06-11 16:07:24', 2);

-- Dumping structure for table forum_sevilia.user
CREATE TABLE IF NOT EXISTS `user` (
  `id_user` int NOT NULL AUTO_INCREMENT,
  `pseudo` varchar(50) NOT NULL DEFAULT '0',
  `email` varchar(255) NOT NULL DEFAULT '0',
  `password` varchar(255) NOT NULL DEFAULT '0',
  `registrationDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Dumping data for table forum_sevilia.user: ~3 rows (approximately)
INSERT INTO `user` (`id_user`, `pseudo`, `email`, `password`, `registrationDate`) VALUES
	(1, 'user en', 'en@email.com', 'xxx', NULL),
	(2, 'user fr', 'fr@email.com', 'xxx', NULL),
	(3, 'user es', 'es@email.com', 'xxx', NULL);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
