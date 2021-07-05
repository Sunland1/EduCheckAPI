-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: mysql-sunland.alwaysdata.net
-- Generation Time: Jul 05, 2021 at 10:31 AM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 7.4.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sunland_educhecktest`
--
CREATE DATABASE IF NOT EXISTS `sunland_educhecktest` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `sunland_educhecktest`;

-- --------------------------------------------------------

--
-- Table structure for table `class`
--

CREATE TABLE `class` (
  `id_class` int(11) NOT NULL,
  `sector` varchar(3) NOT NULL,
  `name` varchar(55) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `class`
--

INSERT INTO `class` (`id_class`, `sector`, `name`) VALUES
(2, 'COL', 'TESTFINAL'),
(4, 'LYC', 'BTS1'),
(5, 'COL', 'TEST78'),
(6, 'COL', 'TR45'),
(7, 'COL', 'BTS5'),
(22, 'UFA', 'NDRC1'),
(24, 'COL', 'BTS'),
(25, 'COL', 'TEST'),
(26, 'UFA', 'MCO1');

-- --------------------------------------------------------

--
-- Table structure for table `sector`
--

CREATE TABLE `sector` (
  `sector` varchar(3) NOT NULL,
  `name` varchar(35) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sector`
--

INSERT INTO `sector` (`sector`, `name`) VALUES
('COL', 'COLLEGE'),
('LYC', 'LYCEE'),
('UFA', 'BTS');

-- --------------------------------------------------------

--
-- Table structure for table `subject`
--

CREATE TABLE `subject` (
  `ref_code` varchar(55) NOT NULL,
  `sector` varchar(3) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `subject`
--

INSERT INTO `subject` (`ref_code`, `sector`, `name`) VALUES
('L123', 'COL', 'Informatique'),
('L1234', 'LYC', 'Histoire'),
('L389', 'LYC', 'Géographie'),
('L600', 'UFA', 'SI&BDD'),
('L900', 'COL', 'Géographie');

-- --------------------------------------------------------

--
-- Table structure for table `table_fiche`
--

CREATE TABLE `table_fiche` (
  `id_class` int(11) NOT NULL,
  `ref_code` varchar(55) NOT NULL,
  `heure` double NOT NULL,
  `heure_double` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `table_fiche`
--

INSERT INTO `table_fiche` (`id_class`, `ref_code`, `heure`, `heure_double`) VALUES
(2, 'L123', 4, 0.4),
(25, 'L123', 5, 0),
(22, 'L600', 1, 1),
(26, 'L600', 1, 0),
(2, 'L900', 2, 0),
(25, 'L900', 7, 1);

-- --------------------------------------------------------

--
-- Table structure for table `table_fiche_affecter`
--

CREATE TABLE `table_fiche_affecter` (
  `id_class` int(11) NOT NULL,
  `id_teacher` int(11) NOT NULL,
  `ref_code` varchar(255) NOT NULL,
  `heure_affecter` double NOT NULL,
  `heure_double_affecter` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `table_fiche_affecter`
--

INSERT INTO `table_fiche_affecter` (`id_class`, `id_teacher`, `ref_code`, `heure_affecter`, `heure_double_affecter`) VALUES
(2, 7, 'L123', 4, 5);

-- --------------------------------------------------------

--
-- Table structure for table `teacher`
--

CREATE TABLE `teacher` (
  `id_teacher` int(11) NOT NULL,
  `civility` varchar(4) NOT NULL,
  `name` varchar(255) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `graduation` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `teacher`
--

INSERT INTO `teacher` (`id_teacher`, `civility`, `name`, `firstname`, `graduation`) VALUES
(3, 'M', 'Horville', 'Alexandre', '15:00:00'),
(5, 'M', 'Hello', 'Alexandre', '18:00:00'),
(6, 'M', 'Nouille', 'Fichue', '15:00:00'),
(7, 'M', 'Horville', 'Alexandre', '15:00:00'),
(8, 'M', 'Gérard', 'Depardieux', '15:00:00'),
(10, 'M', 'Lorentz', 'Olivier', '15:00:00'),
(11, 'M', 'Test', 'Test', '15:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `teacher_class_p`
--

CREATE TABLE `teacher_class_p` (
  `id_teacher` int(11) NOT NULL,
  `id_class` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `teacher_class_p`
--

INSERT INTO `teacher_class_p` (`id_teacher`, `id_class`) VALUES
(5, 7),
(5, 25),
(10, 22),
(10, 26);

-- --------------------------------------------------------

--
-- Table structure for table `teach_sector`
--

CREATE TABLE `teach_sector` (
  `id_teacher` int(11) NOT NULL,
  `sector` varchar(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `teach_sector`
--

INSERT INTO `teach_sector` (`id_teacher`, `sector`) VALUES
(5, 'COL'),
(6, 'COL'),
(7, 'COL'),
(8, 'COL'),
(10, 'UFA'),
(11, 'LYC');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id_usr` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `pwd` varchar(255) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id_usr`, `username`, `pwd`, `firstname`, `name`) VALUES
(1, 'ftest', '$2b$10$jiBFo0CoiqLBgBkbXQjb7O72gJuxSx2n617I/YwXwmILS/XYEilSy', 'alexandre', 'ftest'),
(2, 'sunland', '$2b$10$xulmFqIRLLS3GBjbWNSfv.wbypVTIo0hzYGE/XG/PvmKRb/h6LF6O', 'Alexandre', 'Horville');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `class`
--
ALTER TABLE `class`
  ADD PRIMARY KEY (`id_class`),
  ADD KEY `class_sector_sector_fk` (`sector`);

--
-- Indexes for table `sector`
--
ALTER TABLE `sector`
  ADD PRIMARY KEY (`sector`);

--
-- Indexes for table `subject`
--
ALTER TABLE `subject`
  ADD PRIMARY KEY (`ref_code`),
  ADD KEY `subject_sector_sector_fk` (`sector`);

--
-- Indexes for table `table_fiche`
--
ALTER TABLE `table_fiche`
  ADD PRIMARY KEY (`ref_code`,`id_class`),
  ADD KEY `table_fiche_affecter_class_id_class_fk` (`id_class`);

--
-- Indexes for table `table_fiche_affecter`
--
ALTER TABLE `table_fiche_affecter`
  ADD PRIMARY KEY (`id_class`),
  ADD KEY `table_fiche_affecter_subject_ref_code_fk_2` (`ref_code`),
  ADD KEY `table_fiche_affecter_teacher_id_teacher_fk` (`id_teacher`);

--
-- Indexes for table `teacher`
--
ALTER TABLE `teacher`
  ADD PRIMARY KEY (`id_teacher`);

--
-- Indexes for table `teacher_class_p`
--
ALTER TABLE `teacher_class_p`
  ADD PRIMARY KEY (`id_teacher`,`id_class`),
  ADD KEY `teacher_class_p_class_id_class_fk` (`id_class`);

--
-- Indexes for table `teach_sector`
--
ALTER TABLE `teach_sector`
  ADD PRIMARY KEY (`id_teacher`,`sector`),
  ADD KEY `teache_sector_sector_sector_fk` (`sector`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_usr`),
  ADD UNIQUE KEY `user_username_uindex` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `class`
--
ALTER TABLE `class`
  MODIFY `id_class` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `teacher`
--
ALTER TABLE `teacher`
  MODIFY `id_teacher` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id_usr` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `class`
--
ALTER TABLE `class`
  ADD CONSTRAINT `class_sector_sector_fk` FOREIGN KEY (`sector`) REFERENCES `sector` (`sector`);

--
-- Constraints for table `subject`
--
ALTER TABLE `subject`
  ADD CONSTRAINT `subject_sector_sector_fk` FOREIGN KEY (`sector`) REFERENCES `sector` (`sector`);

--
-- Constraints for table `table_fiche`
--
ALTER TABLE `table_fiche`
  ADD CONSTRAINT `table_fiche_affecter_class_id_class_fk` FOREIGN KEY (`id_class`) REFERENCES `class` (`id_class`) ON DELETE CASCADE,
  ADD CONSTRAINT `table_fiche_affecter_subject_ref_code_fk` FOREIGN KEY (`ref_code`) REFERENCES `subject` (`ref_code`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `table_fiche_affecter`
--
ALTER TABLE `table_fiche_affecter`
  ADD CONSTRAINT `table_fiche_affecter_subject_ref_code_fk_2` FOREIGN KEY (`ref_code`) REFERENCES `subject` (`ref_code`),
  ADD CONSTRAINT `table_fiche_affecter_table_fiche_id_class_fk` FOREIGN KEY (`id_class`) REFERENCES `table_fiche` (`id_class`),
  ADD CONSTRAINT `table_fiche_affecter_teacher_id_teacher_fk` FOREIGN KEY (`id_teacher`) REFERENCES `teacher` (`id_teacher`);

--
-- Constraints for table `teacher_class_p`
--
ALTER TABLE `teacher_class_p`
  ADD CONSTRAINT `teacher_class_p_class_id_class_fk` FOREIGN KEY (`id_class`) REFERENCES `class` (`id_class`) ON DELETE CASCADE,
  ADD CONSTRAINT `teacher_class_p_teacher_id_teacher_fk` FOREIGN KEY (`id_teacher`) REFERENCES `teacher` (`id_teacher`) ON DELETE CASCADE;

--
-- Constraints for table `teach_sector`
--
ALTER TABLE `teach_sector`
  ADD CONSTRAINT `teache_sector_sector_sector_fk` FOREIGN KEY (`sector`) REFERENCES `sector` (`sector`) ON DELETE CASCADE,
  ADD CONSTRAINT `teache_sector_teacher_id_teacher_fk` FOREIGN KEY (`id_teacher`) REFERENCES `teacher` (`id_teacher`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
