-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Apr 04, 2017 at 09:48 PM
-- Server version: 10.1.13-MariaDB
-- PHP Version: 7.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `home_hunt`
--

-- --------------------------------------------------------

--
-- Table structure for table `adds`
--

CREATE TABLE `adds` (
  `id` int(10) UNSIGNED NOT NULL,
  `type` int(11) UNSIGNED NOT NULL,
  `status` int(11) UNSIGNED NOT NULL,
  `rating` int(2) UNSIGNED NOT NULL DEFAULT '0',
  `ratingCount` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `description` text,
  `town` varchar(75) NOT NULL,
  `address` varchar(500) DEFAULT NULL,
  `agentId` int(11) UNSIGNED NOT NULL,
  `dateCreated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

--
-- Dumping data for table `adds`
--

INSERT INTO `adds` (`id`, `type`, `status`, `rating`, `ratingCount`, `description`, `town`, `address`, `agentId`, `dateCreated`) VALUES
(1, 1, 2, 0, 0, 'lorem', 'Sofia', 'ul. Ivan Vazov 1', 1, '2017-04-01 12:55:00'),
(2, 1, 4, 5, 1, 'lorem 2', 'Sofia', 'ul. Hristo Botev 3', 2, '2017-04-01 13:10:57');

-- --------------------------------------------------------

--
-- Table structure for table `adds_attribute_types`
--

CREATE TABLE `adds_attribute_types` (
  `id` int(11) UNSIGNED NOT NULL,
  `type` varchar(50) NOT NULL,
  `display` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

--
-- Dumping data for table `adds_attribute_types`
--

INSERT INTO `adds_attribute_types` (`id`, `type`, `display`) VALUES
(1, 'quadature', 'Quadrature'),
(2, 'price', 'Price'),
(3, 'floor', 'Floor'),
(4, 'topFloor', 'Top floor'),
(5, 'hasParking', 'Has parking'),
(6, 'heatType', 'Heat type'),
(7, 'year', 'Year'),
(8, 'neighborhood', 'Neighborhood'),
(9, 'furnished', 'Furnished'),
(10, 'url', 'Url'),
(11, 'rooms', 'Rooms'),
(12, 'construction', 'Construction');

-- --------------------------------------------------------

--
-- Table structure for table `adds_attribute_values`
--

CREATE TABLE `adds_attribute_values` (
  `id` int(11) UNSIGNED NOT NULL,
  `addId` int(11) UNSIGNED NOT NULL,
  `addAttributeTypeId` int(11) UNSIGNED NOT NULL,
  `value` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

--
-- Dumping data for table `adds_attribute_values`
--

INSERT INTO `adds_attribute_values` (`id`, `addId`, `addAttributeTypeId`, `value`) VALUES
(1, 1, 2, '120000'),
(2, 1, 5, 'yes'),
(3, 2, 3, '3'),
(4, 1, 3, '3');

-- --------------------------------------------------------

--
-- Table structure for table `adds_images`
--

CREATE TABLE `adds_images` (
  `id` int(11) UNSIGNED NOT NULL,
  `addId` int(11) UNSIGNED NOT NULL,
  `filename` varchar(150) NOT NULL,
  `contentType` varchar(150) NOT NULL,
  `extension` varchar(5) NOT NULL,
  `size` int(11) UNSIGNED NOT NULL,
  `width` int(5) UNSIGNED NOT NULL,
  `height` int(5) UNSIGNED NOT NULL,
  `isMain` smallint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

--
-- Dumping data for table `adds_images`
--

INSERT INTO `adds_images` (`id`, `addId`, `filename`, `contentType`, `extension`, `size`, `width`, `height`, `isMain`) VALUES
(1, 1, 'image1.jpg', 'application/png', 'jpg', 150000, 500, 350, 1),
(2, 2, 'image2.jpg', 'application/png', 'jpg', 150000, 500, 300, 1);

-- --------------------------------------------------------

--
-- Table structure for table `adds_statuses`
--

CREATE TABLE `adds_statuses` (
  `id` int(11) UNSIGNED NOT NULL,
  `type` varchar(50) NOT NULL,
  `display` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

--
-- Dumping data for table `adds_statuses`
--

INSERT INTO `adds_statuses` (`id`, `type`, `display`) VALUES
(1, 'visited', 'Visited'),
(2, 'notVisited', 'Not visited'),
(3, 'liked', 'Liked'),
(4, 'dislike', 'Dislike'),
(5, 'love', 'Love');

-- --------------------------------------------------------

--
-- Table structure for table `adds_types`
--

CREATE TABLE `adds_types` (
  `id` int(11) UNSIGNED NOT NULL,
  `type` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

--
-- Dumping data for table `adds_types`
--

INSERT INTO `adds_types` (`id`, `type`) VALUES
(1, 'apartment'),
(2, 'house');

-- --------------------------------------------------------

--
-- Table structure for table `agents`
--

CREATE TABLE `agents` (
  `id` int(11) UNSIGNED NOT NULL,
  `firstName` varchar(100) NOT NULL,
  `lastName` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(20) DEFAULT NULL,
  `company` varchar(200) DEFAULT NULL,
  `rating` int(2) UNSIGNED NOT NULL DEFAULT '0',
  `ratingCount` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `website` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

--
-- Dumping data for table `agents`
--

INSERT INTO `agents` (`id`, `firstName`, `lastName`, `phone`, `email`, `company`, `rating`, `ratingCount`, `website`, `dateCreated`) VALUES
(1, 'Denis', 'Lyjata', '+359 885 85 58 85', 'denis.lyjata@abv.bg', NULL, 0, 0, NULL, '2017-03-24 22:14:14'),
(2, 'Misho', 'Tarikata', '+359 887 87 78 87', 'misho.tarikata@abv.b', NULL, 2, 1, NULL, '2017-04-01 12:20:28');

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `id` int(11) UNSIGNED NOT NULL,
  `addId` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `agentId` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `status` int(11) UNSIGNED NOT NULL,
  `date` bigint(20) NOT NULL,
  `note` text,
  `dateCreated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

--
-- Dumping data for table `appointments`
--

INSERT INTO `appointments` (`id`, `addId`, `agentId`, `status`, `date`, `note`, `dateCreated`) VALUES
(56, 2, 2, 1, 1293683278, 'vccv', '2017-04-04 21:51:38');

-- --------------------------------------------------------

--
-- Table structure for table `appointments_statuses`
--

CREATE TABLE `appointments_statuses` (
  `id` int(11) UNSIGNED NOT NULL,
  `type` varchar(50) NOT NULL,
  `display` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

--
-- Dumping data for table `appointments_statuses`
--

INSERT INTO `appointments_statuses` (`id`, `type`, `display`) VALUES
(1, 'finished', 'Finished'),
(2, 'rejected', 'Rejected'),
(3, 'pending', 'Pending');

-- --------------------------------------------------------

--
-- Table structure for table `notes`
--

CREATE TABLE `notes` (
  `id` int(11) UNSIGNED NOT NULL,
  `objectType` varchar(50) NOT NULL,
  `objectId` int(11) UNSIGNED NOT NULL,
  `note` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

--
-- Dumping data for table `notes`
--

INSERT INTO `notes` (`id`, `objectType`, `objectId`, `note`) VALUES
(33, 'add', 2, 'Leave your comment on the agent'),
(34, 'agent', 2, 'Leave your comment on the agent');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` int(11) UNSIGNED NOT NULL,
  `userId` int(11) UNSIGNED NOT NULL,
  `cookie` varchar(500) NOT NULL,
  `expiresDate` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `userId`, `cookie`, `expiresDate`) VALUES
(12, 34, '3cd8ad4c-cbe7-487b-99b9-e0673f4b99e2', '2017-04-05 12:04:05'),
(22, 1, '8da8676a-1341-42b2-b776-e77733281208', '2017-04-07 22:35:32');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) UNSIGNED NOT NULL,
  `username` varchar(175) NOT NULL,
  `password` varchar(500) NOT NULL,
  `dateCreated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `dateCreated`) VALUES
(1, 'kolio', '123', '2017-03-28 22:26:30'),
(34, 'misho', '123', '2017-04-02 12:03:52');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `adds`
--
ALTER TABLE `adds`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_add_addtypes` (`type`),
  ADD KEY `FK_add_addstatuses` (`status`),
  ADD KEY `FK_add_agents` (`agentId`);

--
-- Indexes for table `adds_attribute_types`
--
ALTER TABLE `adds_attribute_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `adds_attribute_values`
--
ALTER TABLE `adds_attribute_values`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_add_attribute_values_add` (`addId`),
  ADD KEY `FK_add_attribute_values_add_attributetypes` (`addAttributeTypeId`);

--
-- Indexes for table `adds_images`
--
ALTER TABLE `adds_images`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `filename` (`filename`),
  ADD KEY `FK_addImages_add` (`addId`);

--
-- Indexes for table `adds_statuses`
--
ALTER TABLE `adds_statuses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `adds_types`
--
ALTER TABLE `adds_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `agents`
--
ALTER TABLE `agents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_appointments_add` (`addId`),
  ADD KEY `FK_appointments_agents` (`agentId`),
  ADD KEY `FK_appointments_appointments_statuses2` (`status`);

--
-- Indexes for table `appointments_statuses`
--
ALTER TABLE `appointments_statuses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notes`
--
ALTER TABLE `notes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_sessions_users` (`userId`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `adds`
--
ALTER TABLE `adds`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `adds_attribute_types`
--
ALTER TABLE `adds_attribute_types`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `adds_attribute_values`
--
ALTER TABLE `adds_attribute_values`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `adds_images`
--
ALTER TABLE `adds_images`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `adds_statuses`
--
ALTER TABLE `adds_statuses`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `adds_types`
--
ALTER TABLE `adds_types`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `agents`
--
ALTER TABLE `agents`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;
--
-- AUTO_INCREMENT for table `appointments_statuses`
--
ALTER TABLE `appointments_statuses`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `notes`
--
ALTER TABLE `notes`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;
--
-- AUTO_INCREMENT for table `sessions`
--
ALTER TABLE `sessions`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `adds`
--
ALTER TABLE `adds`
  ADD CONSTRAINT `FK_add_addstatuses` FOREIGN KEY (`status`) REFERENCES `adds_statuses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_add_addtypes` FOREIGN KEY (`type`) REFERENCES `adds_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_add_agents` FOREIGN KEY (`agentId`) REFERENCES `agents` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `adds_attribute_values`
--
ALTER TABLE `adds_attribute_values`
  ADD CONSTRAINT `FK_add_attribute_values_add` FOREIGN KEY (`addId`) REFERENCES `adds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_add_attribute_values_add_attributetypes` FOREIGN KEY (`addAttributeTypeId`) REFERENCES `adds_attribute_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `adds_images`
--
ALTER TABLE `adds_images`
  ADD CONSTRAINT `FK_addImages_add` FOREIGN KEY (`addId`) REFERENCES `adds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `FK_appointments_add` FOREIGN KEY (`addId`) REFERENCES `adds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_appointments_agents` FOREIGN KEY (`agentId`) REFERENCES `agents` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_appointments_appointments_statuses2` FOREIGN KEY (`status`) REFERENCES `appointments_statuses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sessions`
--
ALTER TABLE `sessions`
  ADD CONSTRAINT `FK_sessions_users` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
