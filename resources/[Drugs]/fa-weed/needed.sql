CREATE TABLE `weed` (
  `id` int NOT NULL AUTO_INCREMENT,
  `gender` int NOT NULL,
  `coords` varchar(255) NOT NULL,
  `strain` varchar(255) NOT NULL,
  `timestamp` int NOT NULL,
  `last_harvest` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;