-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 27, 2023 at 10:41 PM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bif2webscriptinguser`
--

-- --------------------------------------------------------

--
-- Table structure for table `appointment`
--

CREATE TABLE `appointment` (
  `id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `eventId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `appointment`
--

INSERT INTO `appointment` (`id`, `date`, `eventId`) VALUES
(1, '0000-00-00 00:00:00', 20),
(2, '0000-00-00 00:00:00', 20),
(3, '2001-12-31 11:34:00', 21),
(4, '2002-04-20 10:34:00', 21);

-- --------------------------------------------------------

--
-- Table structure for table `comment`
--

CREATE TABLE `comment` (
  `id` int(11) NOT NULL,
  `comment` varchar(150) NOT NULL,
  `eventId` int(11) NOT NULL,
  `userId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `event`
--

CREATE TABLE `event` (
  `id` int(11) NOT NULL,
  `eventName` varchar(60) NOT NULL DEFAULT 'event',
  `creator` varchar(20) NOT NULL,
  `place` varchar(100) NOT NULL,
  `description` varchar(200) NOT NULL,
  `dueDate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `event`
--

INSERT INTO `event` (`id`, `eventName`, `creator`, `place`, `description`, `dueDate`) VALUES
(11, 'asdf', 'qwer', 'Wien', 'hshdgd', '2000-12-23 11:34:00'),
(12, 'test', 'test', 'wien', 'test', '2023-04-28 10:34:00'),
(13, 'ASDFG', 'ASD', 'wien', 'test', '2023-04-28 10:34:00'),
(14, 'qwer', 'qwer', 'Pernitz', 'asdfgh', '2000-02-12 11:34:00'),
(15, 'qwer', 'qwer', 'Pernitz', 'asdfgh', '2000-02-12 11:34:00'),
(16, 'yxcv', 'yxcv', 'AT', 'Hallo', '2000-12-23 11:34:00'),
(17, 'klklklö', 'klklklö', 'adfg', 'asdffg', '1999-12-23 11:34:00'),
(18, 'app', 'app', 'm', 'zzgzg', '2005-12-31 11:34:00'),
(19, 'akospdjihf', 'oiqepfuw', 'qwerjilh', 'asfafnsl', '2000-12-23 11:34:00'),
(20, 'akospdjihf', 'oiqepfuw', 'qwerjilh', 'asfafnsl', '2000-12-23 11:34:00'),
(21, 'akospdjihf', 'oiqepfuw', 'qwerjilh', 'asfafnsl', '2000-12-23 11:34:00');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `uservote`
--

CREATE TABLE `uservote` (
  `id` int(11) NOT NULL,
  `available` int(1) NOT NULL DEFAULT 0,
  `appointmentId` int(11) NOT NULL,
  `userId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointment`
--
ALTER TABLE `appointment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `eventId` (`eventId`);

--
-- Indexes for table `comment`
--
ALTER TABLE `comment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `eventId` (`eventId`),
  ADD KEY `userId` (`userId`);

--
-- Indexes for table `event`
--
ALTER TABLE `event`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `uservote`
--
ALTER TABLE `uservote`
  ADD PRIMARY KEY (`id`),
  ADD KEY `appointmentId` (`appointmentId`),
  ADD KEY `userId` (`userId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointment`
--
ALTER TABLE `appointment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `comment`
--
ALTER TABLE `comment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `event`
--
ALTER TABLE `event`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `uservote`
--
ALTER TABLE `uservote`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointment`
--
ALTER TABLE `appointment`
  ADD CONSTRAINT `appointment_ibfk_1` FOREIGN KEY (`eventId`) REFERENCES `event` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `comment`
--
ALTER TABLE `comment`
  ADD CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`eventId`) REFERENCES `event` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `uservote`
--
ALTER TABLE `uservote`
  ADD CONSTRAINT `uservote_ibfk_1` FOREIGN KEY (`appointmentId`) REFERENCES `appointment` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `uservote_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
