-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Mar 24, 2017 at 09:38 PM
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
-- Table structure for table `add`
--

CREATE TABLE `add` (
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

-- --------------------------------------------------------

--
-- Table structure for table `add_attribute_types`
--

CREATE TABLE `add_attribute_types` (
  `id` int(11) UNSIGNED NOT NULL,
  `type` varchar(50) NOT NULL,
  `display` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

--
-- Dumping data for table `add_attribute_types`
--

INSERT INTO `add_attribute_types` (`id`, `type`, `display`) VALUES
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
-- Table structure for table `add_attribute_values`
--

CREATE TABLE `add_attribute_values` (
  `id` int(11) UNSIGNED NOT NULL,
  `addId` int(11) UNSIGNED NOT NULL,
  `addAttributeTypeId` int(11) UNSIGNED NOT NULL,
  `value` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

-- --------------------------------------------------------

--
-- Table structure for table `add_images`
--

CREATE TABLE `add_images` (
  `id` int(11) UNSIGNED NOT NULL,
  `addId` int(11) UNSIGNED NOT NULL,
  `filename` varchar(150) NOT NULL,
  `contentType` varchar(150) NOT NULL,
  `extension` varchar(5) NOT NULL,
  `size` int(11) UNSIGNED NOT NULL,
  `width` int(5) UNSIGNED NOT NULL,
  `height` int(5) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

-- --------------------------------------------------------

--
-- Table structure for table `add_statuses`
--

CREATE TABLE `add_statuses` (
  `id` int(11) UNSIGNED NOT NULL,
  `type` varchar(50) NOT NULL,
  `display` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

--
-- Dumping data for table `add_statuses`
--

INSERT INTO `add_statuses` (`id`, `type`, `display`) VALUES
(1, 'visited', 'Visited'),
(2, 'notVisited', 'Not visited'),
(3, 'liked', 'Liked'),
(4, 'dislike', 'Dislike'),
(5, 'love', 'Love');

-- --------------------------------------------------------

--
-- Table structure for table `add_types`
--

CREATE TABLE `add_types` (
  `id` int(11) UNSIGNED NOT NULL,
  `type` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

--
-- Dumping data for table `add_types`
--

INSERT INTO `add_types` (`id`, `type`) VALUES
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
(1, 'Denis', 'Lyjata', '+359 885 85 58 85', 'denis.lyjata@abv.bg', NULL, 4, 1, NULL, '2017-03-24 22:14:14');

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `id` int(11) UNSIGNED NOT NULL,
  `addId` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `agentId` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `status` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `date` datetime NOT NULL,
  `note` text
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

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
(1, 'agent', 1, 'mnogo lyje');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `add`
--
ALTER TABLE `add`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_add_addtypes` (`type`),
  ADD KEY `FK_add_addstatuses` (`status`),
  ADD KEY `FK_add_agents` (`agentId`);

--
-- Indexes for table `add_attribute_types`
--
ALTER TABLE `add_attribute_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `add_attribute_values`
--
ALTER TABLE `add_attribute_values`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_add_attribute_values_add` (`addId`),
  ADD KEY `FK_add_attribute_values_add_attributetypes` (`addAttributeTypeId`);

--
-- Indexes for table `add_images`
--
ALTER TABLE `add_images`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `filename` (`filename`),
  ADD KEY `FK_addImages_add` (`addId`);

--
-- Indexes for table `add_statuses`
--
ALTER TABLE `add_statuses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `add_types`
--
ALTER TABLE `add_types`
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
  ADD KEY `FK_appointments_appointments` (`status`);

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
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `add`
--
ALTER TABLE `add`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `add_attribute_types`
--
ALTER TABLE `add_attribute_types`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `add_attribute_values`
--
ALTER TABLE `add_attribute_values`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `add_images`
--
ALTER TABLE `add_images`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `add_statuses`
--
ALTER TABLE `add_statuses`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `add_types`
--
ALTER TABLE `add_types`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `agents`
--
ALTER TABLE `agents`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `appointments_statuses`
--
ALTER TABLE `appointments_statuses`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `notes`
--
ALTER TABLE `notes`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `add`
--
ALTER TABLE `add`
  ADD CONSTRAINT `FK_add_addstatuses` FOREIGN KEY (`status`) REFERENCES `add_statuses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_add_addtypes` FOREIGN KEY (`type`) REFERENCES `add_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_add_agents` FOREIGN KEY (`agentId`) REFERENCES `agents` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `add_attribute_values`
--
ALTER TABLE `add_attribute_values`
  ADD CONSTRAINT `FK_add_attribute_values_add` FOREIGN KEY (`addId`) REFERENCES `add` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_add_attribute_values_add_attributetypes` FOREIGN KEY (`addAttributeTypeId`) REFERENCES `add_attribute_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `add_images`
--
ALTER TABLE `add_images`
  ADD CONSTRAINT `FK_addImages_add` FOREIGN KEY (`addId`) REFERENCES `add` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `FK_appointments_add` FOREIGN KEY (`addId`) REFERENCES `add` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_appointments_agents` FOREIGN KEY (`agentId`) REFERENCES `agents` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_appointments_appointments` FOREIGN KEY (`status`) REFERENCES `appointments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
