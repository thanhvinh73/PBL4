-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 04, 2024 at 08:18 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pbl4_presentation_controller`
--

-- --------------------------------------------------------

--
-- Table structure for table `camera_url`
--

CREATE TABLE `camera_url` (
  `id` varchar(100) NOT NULL,
  `url` varchar(1000) NOT NULL,
  `create_at` int(11) NOT NULL,
  `status` varchar(100) NOT NULL,
  `ssid` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `label_order`
--

CREATE TABLE `label_order` (
  `userId` varchar(100) NOT NULL,
  `label_order` int(11) NOT NULL,
  `label` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `label_order`
--

INSERT INTO `label_order` (`userId`, `label_order`, `label`) VALUES
('8b6de08d-8491-49a8-b33f-4cb5b925bf0c', 0, 'FORWARD'),
('8b6de08d-8491-49a8-b33f-4cb5b925bf0c', 1, 'BACKWARD'),
('8b6de08d-8491-49a8-b33f-4cb5b925bf0c', 2, 'START'),
('8b6de08d-8491-49a8-b33f-4cb5b925bf0c', 3, 'STOP');

-- --------------------------------------------------------

--
-- Table structure for table `token_block_list`
--

CREATE TABLE `token_block_list` (
  `id` varchar(255) NOT NULL,
  `jti` varchar(255) NOT NULL,
  `create_at` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` varchar(100) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(300) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `role` varchar(100) DEFAULT NULL,
  `name` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `name`) VALUES
('8b6de08d-8491-49a8-b33f-4cb5b925bf0c', 'nam123', 'scrypt:32768:8:1$BqGXyDYwpt6wWqAL$09a0173595292eb4a757e5acc3d270d12846e7255b46c9a099d82313f6c86e96dca6f37b1b005b1d8a624f551b2618cfabfb043c7a68d6074bd8b55ed16747c8', 'nam123@gmail.com', 'USER', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `camera_url`
--
ALTER TABLE `camera_url`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `label_order`
--
ALTER TABLE `label_order`
  ADD KEY `FK_user_id` (`userId`);

--
-- Indexes for table `token_block_list`
--
ALTER TABLE `token_block_list`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `label_order`
--
ALTER TABLE `label_order`
  ADD CONSTRAINT `FK_user_id` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
