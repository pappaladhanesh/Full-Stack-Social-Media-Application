CREATE DATABASE IF NOT EXISTS `mydevify_social`;
USE `mydevify_social`;

SET FOREIGN_KEY_CHECKS = 0;

-- -------------------------------------------
-- Table: users (must be first — others depend on it)
-- -------------------------------------------
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(200) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(200) NOT NULL,
  `name` varchar(200) NOT NULL,
  `coverPic` varchar(200) DEFAULT NULL,
  `profilePic` varchar(200) DEFAULT NULL,
  `city` varchar(200) DEFAULT NULL,
  `website` varchar(200) DEFAULT NULL,
  `bio` varchar(200) DEFAULT NULL,
  `facebookProfile` varchar(30) DEFAULT NULL,
  `instagramProfile` varchar(30) DEFAULT NULL,
  `XProfile` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- -------------------------------------------
-- Table: posts
-- -------------------------------------------
CREATE TABLE IF NOT EXISTS `posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `desc` varchar(600) NOT NULL,
  `img` varchar(200) DEFAULT NULL,
  `userId` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- -------------------------------------------
-- Table: comments
-- -------------------------------------------
CREATE TABLE IF NOT EXISTS `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `desc` varchar(300) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `userId` int(11) NOT NULL,
  `postId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `postId` (`postId`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`postId`) REFERENCES `posts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- -------------------------------------------
-- Table: likes
-- -------------------------------------------
CREATE TABLE IF NOT EXISTS `likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `postId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `postId` (`postId`),
  CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`postId`) REFERENCES `posts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- -------------------------------------------
-- Table: relationships
-- -------------------------------------------
CREATE TABLE IF NOT EXISTS `relationships` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `followerUserId` int(11) NOT NULL,
  `followedUserId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `followerUserId` (`followerUserId`),
  KEY `followedUserId` (`followedUserId`),
  CONSTRAINT `relationships_ibfk_1` FOREIGN KEY (`followerUserId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `relationships_ibfk_2` FOREIGN KEY (`followedUserId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- -------------------------------------------
-- Table: stories
-- -------------------------------------------
CREATE TABLE IF NOT EXISTS `stories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `img` varchar(200) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `createdAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `stories_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- -------------------------------------------
-- Sample Data
-- -------------------------------------------

INSERT INTO `users` (`id`, `username`, `email`, `password`, `name`) VALUES
(1, 'dhanesh', 'dhanesh@example.com', '$2a$10$CcYmjwVjtrHMl.sYvDQc3OlkNT1pkBcorlrkUIzkyIx7pGYN/a6lG', 'Dhanesh'),
(2, 'example', 'example@example.com', '$2a$10$Txv.Mg0hqpVv7Bof4KZRr.CyaGa1CEBiT6fS15mfZWSIE6AV95MjK', 'Example User');

INSERT INTO `posts` (`id`, `desc`, `img`, `userId`, `createdAt`) VALUES
(23, 'Welcome to SocialPulse! A full-stack React Node.js MySQL social media app.', '', 1, '2024-02-25 20:21:46'),
(24, 'Join the journey of innovation! Open source and built with passion.', NULL, 1, '2024-02-25 20:23:53');

INSERT INTO `comments` (`id`, `desc`, `createdAt`, `userId`, `postId`) VALUES
(16, 'First Comment', '2024-02-25 19:22:12', 1, 23),
(17, 'Great post!', '2024-02-25 19:29:22', 1, 24);

INSERT INTO `likes` (`id`, `userId`, `postId`) VALUES
(1, 1, 23),
(2, 1, 24);

SET FOREIGN_KEY_CHECKS = 1;
