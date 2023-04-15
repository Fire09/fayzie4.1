-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.24-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for astralrp
CREATE DATABASE IF NOT EXISTS `astralrp` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `astralrp`;

-- Dumping structure for table astralrp.bank_transactions
CREATE TABLE IF NOT EXISTS `bank_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(40) NOT NULL,
  `sender` varchar(50) NOT NULL,
  `target` varchar(50) NOT NULL,
  `label` varchar(255) NOT NULL DEFAULT '',
  `amount` int(11) NOT NULL,
  `iden` varchar(50) NOT NULL DEFAULT '',
  `type` varchar(50) NOT NULL DEFAULT 'income',
  `date` varchar(255) DEFAULT NULL,
  `business_id` varchar(255) DEFAULT NULL,
  `transaction_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17217 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.bulletclub_leaderboard
CREATE TABLE IF NOT EXISTS `bulletclub_leaderboard` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `difficulty` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `score` int(255) DEFAULT NULL,
  `cid` int(255) DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.businesses
CREATE TABLE IF NOT EXISTS `businesses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `business_id` varchar(255) NOT NULL,
  `business_name` varchar(255) DEFAULT NULL,
  `employees` longtext DEFAULT NULL,
  `roles` longtext DEFAULT NULL,
  `bank` int(255) DEFAULT 0,
  `bank_id` int(8) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.characters
CREATE TABLE IF NOT EXISTS `characters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(50) DEFAULT NULL,
  `first_name` varchar(50) NOT NULL DEFAULT 'John',
  `last_name` varchar(50) NOT NULL DEFAULT 'Doe',
  `date_created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `dob` varchar(50) DEFAULT 'NULL',
  `cash` int(9) DEFAULT 500,
  `bank` int(9) NOT NULL DEFAULT 5000,
  `phone_number` varchar(15) DEFAULT NULL,
  `story` text NOT NULL,
  `new` int(1) NOT NULL DEFAULT 1,
  `deleted` int(11) NOT NULL DEFAULT 0,
  `gender` int(1) NOT NULL DEFAULT 0,
  `job` varchar(50) DEFAULT 'unemployed',
  `jail_time` int(11) NOT NULL DEFAULT 0,
  `dirty_money` int(11) NOT NULL DEFAULT 0,
  `gang_type` int(11) NOT NULL DEFAULT 0,
  `jail_time_mobster` int(11) unsigned zerofill NOT NULL DEFAULT 00000000000,
  `judge_type` int(11) NOT NULL DEFAULT 0,
  `iswjob` int(11) NOT NULL DEFAULT 0,
  `metaData` varchar(1520) DEFAULT '{}',
  `stress_level` int(11) DEFAULT 0,
  `bones` mediumtext DEFAULT '{}',
  `emotes` varchar(4160) DEFAULT '{}',
  `paycheck` int(11) DEFAULT 0,
  `stocks` mediumtext DEFAULT NULL,
  `rehab` int(12) DEFAULT 0,
  `meta` text DEFAULT 'move_m@casual@d',
  `dna` text DEFAULT '{}',
  `wallpaper` longtext DEFAULT NULL,
  `pp` longtext DEFAULT '',
  `policemdtinfo` longtext DEFAULT '',
  `tags` longtext DEFAULT '',
  `gallery` longtext DEFAULT '',
  `bank_id` int(8) DEFAULT NULL,
  `profilepic` varchar(255) DEFAULT NULL,
  `information` longtext DEFAULT NULL,
  `minimap` int(11) DEFAULT NULL,
  `shell` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1348 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.characters_cars
CREATE TABLE IF NOT EXISTS `characters_cars` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(50) DEFAULT NULL,
  `cid` int(11) DEFAULT NULL,
  `purchase_price` float DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `vehicle_state` longtext DEFAULT NULL,
  `fuel` int(11) DEFAULT 100,
  `name` varchar(50) DEFAULT NULL,
  `engine_damage` bigint(19) unsigned DEFAULT 1000,
  `body_damage` bigint(20) DEFAULT 1000,
  `degredation` longtext DEFAULT '100,100,100,100,100,100,100,100',
  `current_garage` varchar(50) DEFAULT 'T',
  `financed` int(11) DEFAULT 0,
  `last_payment` int(11) DEFAULT 0,
  `coords` longtext DEFAULT NULL,
  `license_plate` varchar(255) NOT NULL DEFAULT '',
  `payments_left` int(3) DEFAULT 0,
  `server_number` int(11) DEFAULT NULL,
  `data` longtext DEFAULT NULL,
  `repoed` int(11) NOT NULL DEFAULT 0,
  `garage_info` varchar(50) DEFAULT NULL,
  `newcoords` longtext DEFAULT NULL,
  `location` longtext DEFAULT NULL,
  `vehiclepic` varchar(255) DEFAULT NULL,
  `information` longtext DEFAULT NULL,
  `metaData` longtext DEFAULT NULL,
  `appearance` longtext DEFAULT NULL,
  `mods` longtext DEFAULT NULL,
  `damage` longtext DEFAULT NULL,
  `shared_job` varchar(255) DEFAULT NULL,
  `wheelfitment` longtext DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=123231 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.characters_clothes
CREATE TABLE IF NOT EXISTS `characters_clothes` (
  `cid` int(11) DEFAULT NULL,
  `assExist` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.characters_houses
CREATE TABLE IF NOT EXISTS `characters_houses` (
  `id` int(11) NOT NULL,
  `citizenid` varchar(50) DEFAULT '[]',
  `name` varchar(50) DEFAULT NULL,
  `label` varchar(50) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `tier` int(11) DEFAULT NULL,
  `owned` varchar(50) DEFAULT NULL,
  `coords` text DEFAULT NULL,
  `hasgarage` varchar(50) DEFAULT 'false',
  `garage` varchar(200) DEFAULT '[]',
  `keyholders` text DEFAULT NULL,
  `decorations` longtext DEFAULT NULL,
  `stash` text DEFAULT NULL,
  `outfit` text DEFAULT NULL,
  `logout` text DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.characters_house_plants
CREATE TABLE IF NOT EXISTS `characters_house_plants` (
  `id` int(11) NOT NULL,
  `houseid` varchar(50) DEFAULT '11111',
  `plants` varchar(65000) DEFAULT '[]'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.characters_weapons
CREATE TABLE IF NOT EXISTS `characters_weapons` (
  `id` int(11) NOT NULL DEFAULT 0,
  `type` varchar(255) DEFAULT NULL,
  `ammo` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.character_current
CREATE TABLE IF NOT EXISTS `character_current` (
  `cid` int(11) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `drawables` mediumtext DEFAULT NULL,
  `props` mediumtext DEFAULT NULL,
  `drawtextures` mediumtext DEFAULT NULL,
  `proptextures` mediumtext DEFAULT NULL,
  `assExists` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.character_emails
CREATE TABLE IF NOT EXISTS `character_emails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` varchar(255) NOT NULL,
  `from` varchar(255) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `time` int(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5556 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.character_face
CREATE TABLE IF NOT EXISTS `character_face` (
  `cid` int(11) DEFAULT NULL,
  `hairColor` mediumtext DEFAULT NULL,
  `headBlend` mediumtext DEFAULT NULL,
  `headOverlay` mediumtext DEFAULT NULL,
  `headStructure` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.character_hospital_patients
CREATE TABLE IF NOT EXISTS `character_hospital_patients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL,
  `illness` varchar(50) NOT NULL DEFAULT 'none',
  `level` int(11) NOT NULL DEFAULT 0,
  `time` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.character_motel
CREATE TABLE IF NOT EXISTS `character_motel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL,
  `building_type` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1195 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.character_outfits
CREATE TABLE IF NOT EXISTS `character_outfits` (
  `cid` int(11) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `name` text DEFAULT NULL,
  `slot` int(11) DEFAULT NULL,
  `drawables` text DEFAULT '{}',
  `props` text DEFAULT '{}',
  `drawtextures` text DEFAULT '{}',
  `proptextures` text DEFAULT '{}',
  `hairColor` text DEFAULT '{}'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.character_passes
CREATE TABLE IF NOT EXISTS `character_passes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL,
  `rank` int(11) NOT NULL DEFAULT 1,
  `name` text NOT NULL,
  `giver` text NOT NULL,
  `pass_type` text NOT NULL,
  `business_name` text NOT NULL,
  `bank` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=150 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.character_tattoos
CREATE TABLE IF NOT EXISTS `character_tattoos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL DEFAULT 0,
  `tattoos` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3751 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.cryptos
CREATE TABLE IF NOT EXISTS `cryptos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cryptoid` int(255) NOT NULL,
  `cryptoname` varchar(255) DEFAULT NULL,
  `cryptotag` varchar(255) DEFAULT NULL,
  `cryptoicon` varchar(255) DEFAULT NULL,
  `buyable` int(1) DEFAULT NULL,
  `exchangeable` int(1) DEFAULT NULL,
  `sellable` int(1) DEFAULT NULL,
  `value` int(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.dark_market
CREATE TABLE IF NOT EXISTS `dark_market` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(255) NOT NULL,
  `product_price` varchar(255) DEFAULT NULL,
  `product_itemid` varchar(255) DEFAULT NULL,
  `cryptoid` int(1) DEFAULT NULL,
  `product_icon` varchar(255) DEFAULT NULL,
  `zone` varchar(255) DEFAULT 'heist1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.delivery_job
CREATE TABLE IF NOT EXISTS `delivery_job` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `active` float DEFAULT NULL,
  `jobType` varchar(50) DEFAULT NULL,
  `dropAmount` int(2) DEFAULT NULL,
  `pickup` varchar(255) DEFAULT NULL,
  `drop` varchar(255) DEFAULT NULL,
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.doj_duty
CREATE TABLE IF NOT EXISTS `doj_duty` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `src` int(255) DEFAULT 0,
  `cid` int(255) DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `job` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.driving_tests
CREATE TABLE IF NOT EXISTS `driving_tests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) DEFAULT NULL,
  `icid` int(11) DEFAULT NULL,
  `instructor` varchar(255) DEFAULT NULL,
  `timestamp` text DEFAULT NULL,
  `points` varchar(255) DEFAULT '0',
  `passed` varchar(255) DEFAULT 'false',
  `results` text DEFAULT '{}',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.fine_types
CREATE TABLE IF NOT EXISTS `fine_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jailtime` int(11) DEFAULT 0,
  `amount` int(11) DEFAULT NULL,
  `category` int(11) DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.gangs
CREATE TABLE IF NOT EXISTS `gangs` (
  `cid` int(11) NOT NULL DEFAULT 0,
  `gang_name` mediumtext NOT NULL,
  `reputation` int(11) NOT NULL DEFAULT 0,
  `leader` mediumtext NOT NULL DEFAULT '0',
  `ingang` mediumtext NOT NULL,
  `mission_complete` mediumtext DEFAULT NULL,
  PRIMARY KEY (`cid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.general_variables
CREATE TABLE IF NOT EXISTS `general_variables` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` text DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.group_banking
CREATE TABLE IF NOT EXISTS `group_banking` (
  `group_type` mediumtext DEFAULT NULL,
  `bank` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.hospital_patients
CREATE TABLE IF NOT EXISTS `hospital_patients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL,
  `level` int(11) NOT NULL,
  `illness` text NOT NULL DEFAULT '',
  `time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1306 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.houses
CREATE TABLE IF NOT EXISTS `houses` (
  `id` int(11) NOT NULL DEFAULT 0,
  `cid` int(11) NOT NULL DEFAULT 0,
  `model` text DEFAULT '',
  `data` text DEFAULT '{}',
  `furniture` text DEFAULT '{}',
  `mykeys` text NOT NULL DEFAULT '{}',
  `house_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.jobs_whitelist
CREATE TABLE IF NOT EXISTS `jobs_whitelist` (
  `cid` int(11) DEFAULT NULL,
  `job` varchar(50) DEFAULT 'unemployed',
  `rank` int(11) DEFAULT 0,
  `callsign` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.mdw_charges
CREATE TABLE IF NOT EXISTS `mdw_charges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(255) NOT NULL,
  `color` varchar(255) DEFAULT NULL,
  `charges` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.mdw_evidence
CREATE TABLE IF NOT EXISTS `mdw_evidence` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `identifier` longtext DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `cid` int(255) DEFAULT NULL,
  `incidentId` int(255) DEFAULT NULL,
  `tags` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2150 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.mdw_incidents
CREATE TABLE IF NOT EXISTS `mdw_incidents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `author` varchar(255) DEFAULT NULL,
  `unix` varchar(255) DEFAULT NULL,
  `info` longtext DEFAULT NULL,
  `evidence` longtext DEFAULT NULL,
  `officers` longtext DEFAULT NULL,
  `persons` longtext DEFAULT NULL,
  `tags` longtext DEFAULT NULL,
  `vehicles` longtext DEFAULT NULL,
  `criminals` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=836 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.mdw_incidents_ems
CREATE TABLE IF NOT EXISTS `mdw_incidents_ems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `author` varchar(255) DEFAULT NULL,
  `unix` varchar(255) DEFAULT NULL,
  `info` longtext DEFAULT NULL,
  `ems` longtext DEFAULT NULL,
  `persons` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.mdw_warrants
CREATE TABLE IF NOT EXISTS `mdw_warrants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(255) DEFAULT 0,
  `incidentid` int(255) DEFAULT 0,
  `expiry` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.mech_materials
CREATE TABLE IF NOT EXISTS `mech_materials` (
  `garage` text DEFAULT 'Tow Garage',
  `Scrap` int(11) DEFAULT 0,
  `Plastic` int(11) DEFAULT 0,
  `Glass` int(11) DEFAULT 0,
  `Steel` int(11) DEFAULT 0,
  `Aluminium` int(11) DEFAULT 0,
  `Rubber` int(11) DEFAULT 0,
  `Copper` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.paychecks
CREATE TABLE IF NOT EXISTS `paychecks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(255) DEFAULT NULL,
  `job` varchar(255) DEFAULT NULL,
  `amount` int(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=876 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.phone_calls
CREATE TABLE IF NOT EXISTS `phone_calls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` int(255) NOT NULL,
  `number` varchar(255) DEFAULT NULL,
  `date` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22223 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.phone_contacts
CREATE TABLE IF NOT EXISTS `phone_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `number` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=2441 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.phone_invoices
CREATE TABLE IF NOT EXISTS `phone_invoices` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `amount` int(11) NOT NULL DEFAULT 0,
  `society` tinytext DEFAULT NULL,
  `sender` varchar(50) DEFAULT NULL,
  `sendercitizenid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.phone_tweets
CREATE TABLE IF NOT EXISTS `phone_tweets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `sender` varchar(50) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=1066 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.phone_yp
CREATE TABLE IF NOT EXISTS `phone_yp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(255) DEFAULT 0,
  `phonenr` varchar(255) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3491 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.pickups
CREATE TABLE IF NOT EXISTS `pickups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` varchar(255) NOT NULL,
  `itemid` varchar(255) DEFAULT NULL,
  `information` varchar(255) DEFAULT '{}',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=322 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.playerstattoos
CREATE TABLE IF NOT EXISTS `playerstattoos` (
  `identifier` int(11) DEFAULT NULL,
  `tattoos` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.player_logs
CREATE TABLE IF NOT EXISTS `player_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `steamid` varchar(255) DEFAULT NULL,
  `log` longtext DEFAULT NULL,
  `date` longtext DEFAULT NULL,
  `cid` int(255) DEFAULT NULL,
  `data` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1265 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.properties
CREATE TABLE IF NOT EXISTS `properties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(255) DEFAULT NULL,
  `cid` varchar(255) DEFAULT NULL,
  `propertyname` varchar(255) DEFAULT NULL,
  `coords` varchar(255) DEFAULT NULL,
  `haskeys` varchar(255) DEFAULT NULL,
  `propertysold` int(1) DEFAULT NULL,
  `propertyprice` int(100) DEFAULT NULL,
  `locked` int(1) DEFAULT 1,
  `propertycategory` varchar(255) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `shell` varchar(255) DEFAULT NULL,
  `property_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.racing_tracks
CREATE TABLE IF NOT EXISTS `racing_tracks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `checkpoints` text DEFAULT NULL,
  `track_name` text DEFAULT NULL,
  `creator` text DEFAULT NULL,
  `distance` text DEFAULT NULL,
  `races` text DEFAULT NULL,
  `fastest_car` text DEFAULT NULL,
  `fastest_name` text DEFAULT NULL,
  `fastest_lap` int(11) DEFAULT NULL,
  `fastest_sprint` int(11) DEFAULT NULL,
  `fastest_sprint_name` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `data` text DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.stash
CREATE TABLE IF NOT EXISTS `stash` (
  `owner_cid` int(11) DEFAULT NULL,
  `admin` int(11) DEFAULT NULL,
  `x` int(122) DEFAULT NULL,
  `y` int(122) DEFAULT NULL,
  `z` int(122) DEFAULT NULL,
  `g_x` int(122) DEFAULT NULL,
  `g_y` int(122) DEFAULT NULL,
  `g_z` int(122) DEFAULT NULL,
  `owner_pin` int(11) DEFAULT NULL,
  `guest_pin` int(11) DEFAULT NULL,
  `useGarage` int(11) DEFAULT NULL,
  `tier` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.storage_units
CREATE TABLE IF NOT EXISTS `storage_units` (
  `id` longtext DEFAULT NULL,
  `data` longtext DEFAULT NULL,
  `given_access` varchar(50) DEFAULT '[]'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.transaction_history
CREATE TABLE IF NOT EXISTS `transaction_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` text NOT NULL,
  `trans_id` int(11) NOT NULL,
  `account` text NOT NULL,
  `amount` int(11) NOT NULL,
  `trans_type` text NOT NULL,
  `receiver` text NOT NULL,
  `message` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.tweets
CREATE TABLE IF NOT EXISTS `tweets` (
  `handle` longtext NOT NULL,
  `message` varchar(500) NOT NULL,
  `time` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hex_id` varchar(100) DEFAULT NULL,
  `steam_id` varchar(50) DEFAULT NULL,
  `community_id` varchar(100) DEFAULT NULL,
  `license` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL DEFAULT 'Uknown',
  `ip` varchar(50) NOT NULL DEFAULT 'Uknown',
  `rank` varchar(50) NOT NULL DEFAULT 'user',
  `date_created` timestamp NOT NULL DEFAULT current_timestamp(),
  `controls` text DEFAULT '{}',
  `settings` text DEFAULT '{}',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=758 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.user_apartment
CREATE TABLE IF NOT EXISTS `user_apartment` (
  `room` int(11) NOT NULL AUTO_INCREMENT,
  `roomType` int(1) DEFAULT NULL,
  `cid` mediumtext NOT NULL,
  `mykeys` varchar(50) NOT NULL DEFAULT '[]',
  `ilness` mediumtext NOT NULL DEFAULT 'Alive',
  `isImprisoned` mediumtext NOT NULL DEFAULT '0',
  `isClothesSpawn` mediumtext NOT NULL DEFAULT 'true',
  `cash` int(11) DEFAULT 0,
  PRIMARY KEY (`room`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.user_bans
CREATE TABLE IF NOT EXISTS `user_bans` (
  `steam_id` longtext NOT NULL DEFAULT '',
  `discord_id` longtext NOT NULL DEFAULT '',
  `steam_name` longtext NOT NULL DEFAULT '',
  `reason` longtext NOT NULL DEFAULT '',
  `details` longtext NOT NULL,
  `date_banned` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.user_boat
CREATE TABLE IF NOT EXISTS `user_boat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) DEFAULT '{}',
  `boat_name` varchar(255) DEFAULT '{}',
  `boat_model` varchar(255) DEFAULT '{}',
  `boat_price` varchar(255) DEFAULT '{}',
  `boat_plate` varchar(255) DEFAULT '{}',
  `boat_state` varchar(255) DEFAULT '{}',
  `boat_colorprimary` varchar(255) DEFAULT '{}',
  `boat_colorsecondary` varchar(255) DEFAULT '{}',
  `boat_pearlescentcolor` varchar(255) DEFAULT '{}',
  `boat_wheelcolor` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.user_contacts
CREATE TABLE IF NOT EXISTS `user_contacts` (
  `identifier` varchar(40) NOT NULL,
  `name` longtext NOT NULL,
  `number` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.user_crypto
CREATE TABLE IF NOT EXISTS `user_crypto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cryptoid` varchar(255) NOT NULL,
  `cryptoamount` varchar(255) DEFAULT NULL,
  `cryptocid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1560 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.user_inventory2
CREATE TABLE IF NOT EXISTS `user_inventory2` (
  `item_id` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(500) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `information` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `slot` int(11) NOT NULL,
  `dropped` tinyint(4) NOT NULL DEFAULT 0,
  `creationDate` bigint(20) NOT NULL DEFAULT 0,
  `quality` int(11) DEFAULT 100,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=321328 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.user_licenses
CREATE TABLE IF NOT EXISTS `user_licenses` (
  `cid` longtext NOT NULL,
  `type` longtext NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.user_messages
CREATE TABLE IF NOT EXISTS `user_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender` varchar(10) NOT NULL,
  `receiver` varchar(10) NOT NULL,
  `message` varchar(255) NOT NULL DEFAULT '0',
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `isRead` int(11) NOT NULL DEFAULT 0,
  `time` longtext DEFAULT 0,
  `unix` longtext DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8831 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.user_priors
CREATE TABLE IF NOT EXISTS `user_priors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(255) NOT NULL,
  `charge` varchar(255) DEFAULT NULL,
  `times` int(255) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1455 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.user_settings
CREATE TABLE IF NOT EXISTS `user_settings` (
  `hex_id` varchar(255) NOT NULL DEFAULT '',
  `settings` varchar(255) DEFAULT '{}',
  PRIMARY KEY (`hex_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.vehicle_display
CREATE TABLE IF NOT EXISTS `vehicle_display` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model` varchar(60) COLLATE utf8mb4_turkish_ci NOT NULL,
  `name` varchar(60) COLLATE utf8mb4_turkish_ci NOT NULL,
  `commission` int(11) NOT NULL DEFAULT 10,
  `baseprice` int(11) NOT NULL DEFAULT 25,
  `price` int(11) DEFAULT 25000,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.vehicle_mdt
CREATE TABLE IF NOT EXISTS `vehicle_mdt` (
  `dbid` int(11) NOT NULL,
  `plate` varchar(255) DEFAULT NULL,
  `notes` varchar(50) DEFAULT NULL,
  `image` varchar(255) DEFAULT 'https://cdn.discordapp.com/attachments/832371566859124821/881624386317201498/Screenshot_1607.png',
  `code` int(11) DEFAULT 0,
  `stolen` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.weapons_serials
CREATE TABLE IF NOT EXISTS `weapons_serials` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) DEFAULT NULL,
  `serial` mediumtext DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `information` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11785 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.weed
CREATE TABLE IF NOT EXISTS `weed` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `x` int(11) DEFAULT 0,
  `y` int(11) DEFAULT 0,
  `z` int(11) DEFAULT 0,
  `growth` int(11) DEFAULT 0,
  `type` varchar(50) DEFAULT NULL,
  `time` longtext DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.weed_plants
CREATE TABLE IF NOT EXISTS `weed_plants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` varchar(255) DEFAULT NULL,
  `x` varchar(255) DEFAULT NULL,
  `y` varchar(255) DEFAULT NULL,
  `z` varchar(255) DEFAULT NULL,
  `gender` int(1) DEFAULT 1,
  `water` varchar(255) DEFAULT NULL,
  `n` double DEFAULT NULL,
  `p` double DEFAULT NULL,
  `k` double DEFAULT NULL,
  `last_harvest` int(255) DEFAULT 0,
  `maleseeds` int(255) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=777 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.__banking_logs
CREATE TABLE IF NOT EXISTS `__banking_logs` (
  `cid` int(11) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `reason` longtext NOT NULL,
  `withdraw` int(11) DEFAULT NULL,
  `business` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.__objects
CREATE TABLE IF NOT EXISTS `__objects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model` varchar(255) NOT NULL,
  `coordinates` longtext DEFAULT NULL,
  `metaData` longtext DEFAULT NULL,
  `randomId` int(255) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.__scenes
CREATE TABLE IF NOT EXISTS `__scenes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `coords` longtext NOT NULL,
  `text` varchar(255) DEFAULT NULL,
  `distance` varchar(255) DEFAULT NULL,
  `color` varchar(255) DEFAULT NULL,
  `caret` varchar(255) DEFAULT NULL,
  `font` varchar(255) DEFAULT NULL,
  `solid` varchar(255) DEFAULT NULL,
  `background` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3105 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table astralrp.__vehiclemods
CREATE TABLE IF NOT EXISTS `__vehiclemods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `durability` int(11) DEFAULT NULL,
  `license_plate` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=167 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
