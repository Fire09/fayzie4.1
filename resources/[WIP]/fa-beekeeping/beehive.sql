-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.9.2-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for Faye
CREATE DATABASE IF NOT EXISTS `Faye` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `Faye`;

-- Dumping structure for table Faye._beehives
CREATE TABLE IF NOT EXISTS `_beehives` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `coords` longtext NOT NULL,
  `heading` int(11) DEFAULT 0,
  `timestamp` int(11) DEFAULT 0,
  `has_queen` varchar(50) DEFAULT '0',
  `last_harvest` int(11) DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 AVG_ROW_LENGTH=16384;

-- Dumping data for table Faye._beehives: ~0 rows (approximately)
/*!40000 ALTER TABLE `_beehives` DISABLE KEYS */;
INSERT INTO `_beehives` (`id`, `coords`, `heading`, `timestamp`, `has_queen`, `last_harvest`) VALUES
	(1, '{"x":-1768.576904296875,"y":2080.871337890625,"z":120.39066314697266}', 163, 1668631293, '0', 1668713773);
/*!40000 ALTER TABLE `_beehives` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
