-- ПУНКТ 1. ЗАПОЛНЕНИЕ БАЗЫ

DROP DATABASE IF EXISTS vk;
CREATE DATABASE vk;
USE vk;

DROP TABLE IF EXISTS `communities`;
CREATE TABLE `communities` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `communities_name_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `communities` VALUES ('10','deleniti'),
('9','est'),
('7','hic'),
('3','laboriosam'),
('8','non'),
('2','quae'),
('4','repellat'),
('1','sit'),
('5','ut'),
('6','voluptas'); 


DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastname` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Фамиль',
  `email` varchar(120) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` bigint(20) DEFAULT NULL,
  `is_active` bool DEFAULT TRUE,
  `age` int(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `users_phone_idx` (`phone`),
  KEY `users_firstname_lastname_idx` (`firstname`,`lastname`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `users` VALUES ('1','Cassandra','Senger','hermann.godfrey@example.com','489', true , 14),
('2','Cassandra','Dach','jillian81@example.org','912', true, 24),
('3','Tate','Schumm','dwelch@example.net','1', true, 34),
('4','Cassandra','Watsica','flossie08@example.com','0', true, 12),
('5','Garland','Rippin','keira34@example.org','940', true, 14),
('6','Jana','Douglas','hiram26@example.com','88', true, 9),
('7','Cassandra','Koss','eleonore73@example.net','0', true, 45),
('8','Noah','Barton','maribel99@example.com','399927', true, 75),
('9','Mitchell','Senger','ndoyle@example.net','1', true, 63),
('10','Cristobal','Pacocha','jerry13@example.com','1', true, 24); 


DROP TABLE IF EXISTS `likes`;
CREATE TABLE `likes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `media_id` bigint(20) unsigned NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `likes` VALUES ('1','1','1','1974-01-07 17:09:53'),
('2','2','2','1975-07-03 08:32:23'),
('3','3','3','1991-07-19 06:59:52'),
('4','4','4','1992-08-25 16:59:04'),
('5','5','5','1991-02-12 13:29:12'),
('6','6','6','2017-12-02 22:03:36'),
('7','7','7','1996-12-04 15:59:57'),
('8','8','8','2016-01-24 08:45:16'),
('9','9','9','1982-03-26 03:26:49'),
('10','10','10','1972-02-22 10:33:37'); 

DROP TABLE IF EXISTS `media_types`;
CREATE TABLE `media_types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `media_types` VALUES ('1','est','2013-02-11 02:27:34','2016-10-07 08:55:15'),
('2','ea','1996-12-06 18:09:43','1999-02-25 05:44:27'),
('3','consequatur','2006-01-29 23:44:20','1978-01-20 04:17:05'),
('4','cupiditate','2017-04-06 05:19:56','1992-02-08 13:01:53'),
('5','officia','2002-08-28 14:44:40','1976-08-27 19:16:01'); 

DROP TABLE IF EXISTS `media`;
CREATE TABLE `media` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `media_type_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `body` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `filename` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `media_type_id` (`media_type_id`),
  CONSTRAINT `media_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `media_ibfk_2` FOREIGN KEY (`media_type_id`) REFERENCES `media_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `media` VALUES ('1','1','1','Excepturi eligendi rerum eaque quos dolorum vitae tenetur magnam. Repudiandae libero necessitatibus aut voluptatem alias fuga voluptas.','dolorum','0',NULL,'2011-09-07 07:51:44','2010-04-28 02:13:17'),
('2','2','2','Explicabo incidunt iste corporis quis et rem quas. Voluptatem molestiae soluta voluptatem. Et fugit ducimus dolor dolorem voluptatem qui veritatis. Dolores aliquam nulla et quas fugit. Iusto sed qui incidunt consequatur voluptas.','recusandae','4531',NULL,'2000-06-29 15:39:53','2002-08-29 06:18:26'),
('3','3','3','Velit consequatur est culpa sit ut voluptas. Rerum laudantium inventore vel temporibus laborum molestiae. Ea voluptas aliquid omnis veniam incidunt.','et','569',NULL,'2019-03-13 01:43:48','1977-04-26 11:06:13'),
('4','4','4','Laborum itaque consequatur ad ut. Id debitis expedita magni et. Ea officia et porro dolorum ut.','nihil','78989436',NULL,'2007-10-11 13:26:00','2015-10-25 22:06:03'),
('5','5','5','Aut eum iure magni iusto nemo et. Deleniti quisquam dolores cupiditate autem non aliquid. Sunt iusto aut veritatis temporibus quia qui. Nobis voluptates et vero laudantium eos non eum cupiditate.','et','9584',NULL,'1997-03-15 16:15:42','2002-01-14 10:47:00'),
('6','1','6','Voluptatem quam eos dolorem dicta enim. Minus quos qui voluptates quaerat laudantium totam. Omnis laudantium dolorem voluptatem dolorum consequuntur exercitationem reiciendis. Ut nisi dolores deserunt eveniet distinctio.','voluptatem','61394219',NULL,'2004-09-19 03:53:20','1978-04-08 03:49:59'),
('7','2','7','Sint unde blanditiis aut est ipsam deleniti tempore qui. Laudantium nihil sit tempore est ipsa. Sequi laborum doloremque quam. Qui fuga ratione tempora iusto.','reprehenderit','17',NULL,'2000-07-16 18:34:04','1998-10-27 13:32:46'),
('8','3','8','Minima beatae et itaque quia. Vitae dolor velit quas. Ut enim qui cupiditate voluptas voluptatem.','eum','293',NULL,'1971-11-18 04:49:38','2016-10-06 02:39:36'),
('9','4','9','Velit natus excepturi vel ratione. Dolor dolor et qui velit non vero. Voluptatem ut voluptatum consequuntur id eum.','aliquam','547214',NULL,'2010-03-02 10:51:00','2018-04-27 13:44:21'),
('10','5','10','Autem iste repudiandae sit dolorem qui consequuntur. Quis explicabo corporis omnis qui maxime minus aut. Et iusto quas maxime quod eius sunt architecto.','voluptas','140025',NULL,'1990-05-26 22:46:25','2001-09-13 17:26:46'); 


DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `from_user_id` bigint(20) unsigned NOT NULL,
  `to_user_id` bigint(20) unsigned NOT NULL,
  `body` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `messages_from_user_id` (`from_user_id`),
  KEY `messages_to_user_id` (`to_user_id`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`from_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`to_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `messages` VALUES ('1','1','1','Officiis eligendi corporis quaerat et. Non et cupiditate quaerat enim voluptates. Consequatur est vel et illo ratione illo. Quia atque cumque ad quo ea.','2010-10-15 18:15:36'),
('2','2','2','Omnis voluptas pariatur consequatur. Ad a eos porro omnis nemo eligendi molestiae. Nam mollitia ut necessitatibus magnam ut sequi sunt.','1986-06-11 14:01:32'),
('3','3','3','Omnis eveniet quaerat fuga modi quia praesentium iste. Inventore ut sunt officia. Cum adipisci adipisci aspernatur quas voluptate rerum.','1972-09-29 01:22:08'),
('4','4','4','Dolorem quam et omnis nobis impedit. Dolores dolor est laudantium similique suscipit. Dolorum eligendi officia vitae molestiae.','2009-12-24 08:07:23'),
('5','5','5','Id amet dolorem ea blanditiis. Ex occaecati necessitatibus repellat ut ipsa tempore impedit. Consequatur necessitatibus omnis quia itaque in.','2044-03-03 07:33:25'),
('6','6','6','Ipsa numquam explicabo voluptatum odit perspiciatis. Et eum id vero eum. Voluptatem aut repellendus aspernatur quia.','2045-12-29 11:41:20'),
('7','7','7','Quis mollitia aut in omnis eos ea voluptatibus. Amet aliquid magnam ipsam voluptas voluptatem iure minus.','2107-01-15 14:46:45'),
('8','8','8','Necessitatibus delectus amet dolore qui. Repellendus qui fugiat molestiae quas et natus. Qui vero quia doloremque. Est quos sit aut quia reiciendis hic.','2018-08-12 17:27:35'),
('9','9','9','Omnis eius labore nulla. Voluptatem sit quis aut sunt doloremque consequuntur. Omnis odit iure consequatur et fugiat quaerat suscipit.','1980-02-28 00:00:35'),
('10','10','10','At esse et ut voluptate optio blanditiis non. Nulla dolorum et unde et ea velit. Aspernatur facilis modi et ut eum sit in. Deleniti rerum voluptatum nam sunt maxime.','1988-10-19 11:51:02'); 


DROP TABLE IF EXISTS `photo_albums`;
CREATE TABLE `photo_albums` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `photo_albums_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `photo_albums` VALUES ('1','qui','1'),
('2','dolorum','2'),
('3','perspiciatis','3'),
('4','est','4'),
('5','corporis','5'),
('6','doloribus','6'),
('7','et','7'),
('8','aut','8'),
('9','et','9'),
('10','voluptatibus','10'); 


DROP TABLE IF EXISTS `photos`;
CREATE TABLE `photos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `album_id` bigint(20) unsigned NOT NULL,
  `media_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `album_id` (`album_id`),
  KEY `media_id` (`media_id`),
  CONSTRAINT `photos_ibfk_1` FOREIGN KEY (`album_id`) REFERENCES `photo_albums` (`id`),
  CONSTRAINT `photos_ibfk_2` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `photos` VALUES ('1','1','1'),
('2','2','2'),
('3','3','3'),
('4','4','4'),
('5','5','5'),
('6','6','6'),
('7','7','7'),
('8','8','8'),
('9','9','9'),
('10','10','10'); 


DROP TABLE IF EXISTS `profiles`;
CREATE TABLE `profiles` (
  `user_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `gender` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `photo_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `hometown` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `profiles` VALUES ('1',NULL,'1975-08-12','1','1975-11-20 12:12:48',NULL),
('2',NULL,'2014-06-13','2','2003-09-15 02:55:41',NULL),
('3',NULL,'1988-05-11','3','1985-04-29 14:52:55',NULL),
('4',NULL,'1970-11-02','4','1999-08-17 23:07:11',NULL),
('5',NULL,'1988-01-18','5','1994-04-18 19:41:21',NULL),
('6',NULL,'1987-08-19','6','2016-06-10 13:11:39',NULL),
('7',NULL,'1989-05-21','7','1988-01-11 11:26:51',NULL),
('8',NULL,'2008-08-19','8','1991-04-29 21:18:56',NULL),
('9',NULL,'1989-02-17','9','1981-07-31 00:39:29',NULL),
('10',NULL,'1970-02-06','10','2007-07-25 09:30:30',NULL); 


DROP TABLE IF EXISTS `users_communities`;
CREATE TABLE `users_communities` (
  `user_id` bigint(20) unsigned NOT NULL,
  `community_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`community_id`),
  KEY `community_id` (`community_id`),
  CONSTRAINT `users_communities_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `users_communities_ibfk_2` FOREIGN KEY (`community_id`) REFERENCES `communities` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `users_communities` VALUES ('1','1'),
('2','2'),
('3','3'),
('4','4'),
('5','5'),
('6','6'),
('7','7'),
('8','8'),
('9','9'),
('10','10'); 

DROP TABLE IF EXISTS `friend_requests`;
CREATE TABLE `friend_requests` (
  `initiator_user_id` bigint(20) unsigned NOT NULL,
  `target_user_id` bigint(20) unsigned NOT NULL,
  `status` enum('requested','approved','unfriended','declined') COLLATE utf8_unicode_ci DEFAULT 'requested',
  `requested_at` datetime DEFAULT current_timestamp(),
  `confirmed_at` datetime DEFAULT NULL,
  PRIMARY KEY (`initiator_user_id`,`target_user_id`),
  KEY `initiator_user_id` (`initiator_user_id`),
  KEY `target_user_id` (`target_user_id`),
  CONSTRAINT `friend_requests_ibfk_1` FOREIGN KEY (`initiator_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `friend_requests_ibfk_2` FOREIGN KEY (`target_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `friend_requests` VALUES ('1','1','requested','1996-03-30 23:09:39','2013-11-25 19:09:35'),
('2','2','requested','2011-05-25 19:49:18','1990-09-25 07:42:00'),
('3','3','requested','1984-07-16 17:41:56','1999-07-06 10:36:30'),
('4','4','requested','1998-10-27 22:17:32','1998-03-26 15:36:08'),
('5','5','requested','1990-05-09 02:13:22','1994-12-05 15:58:05'),
('6','6','requested','1971-08-10 06:43:59','2002-06-29 22:24:45'),
('7','7','requested','2010-05-21 16:48:44','1986-11-27 11:05:01'),
('8','8','requested','1973-02-05 07:48:51','1978-10-15 07:48:12'),
('9','9','requested','2000-01-03 05:16:54','1981-07-29 08:58:59'),
('10','10','requested','2005-12-17 05:32:19','2007-08-22 00:16:48'); 

