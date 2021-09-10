-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: mysql-sunland.alwaysdata.net
-- Generation Time: Sep 10, 2021 at 04:11 PM
-- Server version: 10.4.20-MariaDB
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
(44, 'UFA', 'MCO1'),
(47, 'UFA', 'MC02'),
(51, 'UFA', 'NDRC1'),
(52, 'UFA', 'NDRC2'),
(54, 'LYC', '1A'),
(55, 'LYC', '2A');

-- --------------------------------------------------------

--
-- Table structure for table `ponderate`
--

CREATE TABLE `ponderate` (
  `id_subject` int(11) NOT NULL,
  `isPonderate` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ponderate`
--

INSERT INTO `ponderate` (`id_subject`, `isPonderate`) VALUES
(10, 1),
(11, 1),
(13, 1),
(14, 1),
(15, 1),
(16, 1),
(17, 1),
(18, 1),
(33, 0),
(34, 1),
(35, 1),
(36, 1),
(37, 1),
(38, 1),
(40, 0),
(41, 0),
(42, 1),
(43, 1);

-- --------------------------------------------------------

--
-- Table structure for table `sector`
--

CREATE TABLE `sector` (
  `sector` varchar(3) NOT NULL,
  `name` varchar(35) NOT NULL,
  `DHG` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sector`
--

INSERT INTO `sector` (`sector`, `name`, `DHG`) VALUES
('COL', 'COLLEGE', 456),
('LYC', 'LYCEE', 335),
('UFA', 'BTS', 335);

-- --------------------------------------------------------

--
-- Table structure for table `subject`
--

CREATE TABLE `subject` (
  `id_subject` int(11) NOT NULL,
  `ref_code` varchar(255) NOT NULL,
  `subject_code` varchar(255) NOT NULL,
  `sector` varchar(5) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `subject`
--

INSERT INTO `subject` (`id_subject`, `ref_code`, `subject_code`, `sector`, `name`) VALUES
(10, 'AGL1', 'AGL1', 'UFA', 'ANGLAIS LV1'),
(11, 'CGEXP', 'CGEXP', 'UFA', 'CULT. GENER. EXPRESSION'),
(13, 'ENTRE', 'ENTRE', 'UFA', 'Option entrepreneuriat'),
(14, 'CEJM', 'CEJM', 'UFA', 'CEJM'),
(15, 'MAEQC', 'MAEQC', 'UFA', 'MANAG. EQUIP. COMMERC.'),
(16, 'DRCVC', 'DRCVC', 'UFA', 'DEV. REL. CLT. VENTE CONSEIL'),
(17, 'ADOCO', 'ADOCO', 'UFA', 'ANIM. DYNAM. OFFRE COMMERCIALE'),
(18, 'GESOP', 'GESOP', 'UFA', 'GESTION OPERATIONNELLE'),
(33, 'profref', 'prf', 'UFA', 'professeur référent'),
(34, 'L8013', 'BLOC 1', 'UFA', 'REL. CLIENT NEGO. VENTE'),
(35, 'L8013', 'BLOC 2', 'UFA', 'REL. CLIENT DIST. ET DIGIT.'),
(36, 'L8013', 'BLOC 3', 'UFA', 'REL. CLIENT DIST. ET ANIM. RESEAUX'),
(37, 'L8013', 'AT. PRO', 'UFA', 'ATELIER DE PROFESSIONNALISATION'),
(38, 'L8013', 'CEJM APPL', 'UFA', 'CEJM APPLIQUEE'),
(40, 'L0422', 'TOEIC', 'UFA', 'TOEIC'),
(41, 'L0202', 'VOLTAIRE', 'UFA', 'VOLTAIRE'),
(42, 'LTEST', 'TEST', 'LYC', 'TEST'),
(43, 'LTEST', 'TEST1', 'LYC', 'TEST1');

-- --------------------------------------------------------

--
-- Table structure for table `table_fiche`
--

CREATE TABLE `table_fiche` (
  `id_subject` int(11) NOT NULL,
  `id_class` int(11) NOT NULL,
  `nb_heure` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `table_fiche`
--

INSERT INTO `table_fiche` (`id_subject`, `id_class`, `nb_heure`) VALUES
(10, 44, 5),
(10, 47, 3),
(10, 51, 4),
(10, 52, 3),
(11, 44, 3),
(11, 47, 2),
(11, 51, 3),
(11, 52, 2),
(13, 44, 2),
(13, 47, 2),
(14, 44, 4),
(14, 47, 4),
(14, 51, 4),
(14, 52, 4),
(15, 44, 6),
(15, 47, 4),
(16, 44, 10),
(16, 47, 6),
(17, 44, 7),
(17, 47, 5),
(18, 44, 6),
(18, 47, 4),
(33, 44, 0.5),
(33, 47, 0.5),
(33, 51, 0.5),
(33, 52, 0.5),
(34, 51, 8),
(34, 52, 6),
(35, 51, 7),
(35, 52, 5),
(36, 51, 5),
(36, 52, 4),
(37, 51, 8),
(37, 52, 8),
(38, 51, 2),
(38, 52, 1),
(40, 51, 1),
(42, 54, 8),
(42, 55, 7),
(43, 54, 9),
(43, 55, 8);

-- --------------------------------------------------------

--
-- Table structure for table `table_fiche_affecter`
--

CREATE TABLE `table_fiche_affecter` (
  `id_class` int(11) NOT NULL,
  `id_subject` int(11) NOT NULL,
  `id_teacher` int(11) NOT NULL,
  `nb_heure_affecter` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `table_fiche_affecter`
--

INSERT INTO `table_fiche_affecter` (`id_class`, `id_subject`, `id_teacher`, `nb_heure_affecter`) VALUES
(44, 10, 13, 5),
(44, 11, 14, 3),
(44, 13, 15, 2),
(44, 14, 16, 4),
(44, 15, 16, 6),
(44, 16, 12, 10),
(44, 17, 17, 7),
(44, 18, 15, 6),
(44, 33, 12, 0.5),
(47, 10, 13, 3),
(47, 11, 14, 2),
(47, 13, 15, 2),
(47, 14, 16, 4),
(47, 15, 16, 4),
(47, 16, 12, 6),
(47, 17, 17, 5),
(47, 18, 15, 4),
(47, 33, 16, 0.5),
(51, 10, 13, 5),
(51, 11, 14, 3),
(51, 14, 39, 4),
(51, 33, 40, 0.5),
(51, 34, 38, 2),
(51, 34, 40, 6),
(51, 35, 38, 2),
(51, 35, 39, 1),
(51, 35, 40, 4),
(51, 36, 38, 3),
(51, 36, 41, 2),
(51, 37, 13, 1),
(51, 37, 14, 1),
(51, 37, 39, 3),
(51, 37, 40, 3),
(51, 38, 39, 2),
(51, 40, 13, 1),
(52, 10, 13, 3),
(52, 11, 14, 2),
(52, 14, 39, 4),
(52, 33, 38, 0.5),
(52, 34, 38, 6),
(52, 35, 38, 2),
(52, 35, 39, 1),
(52, 35, 40, 2),
(52, 36, 38, 2),
(52, 36, 41, 2),
(52, 37, 13, 1),
(52, 37, 14, 1),
(52, 37, 38, 3),
(52, 37, 41, 3),
(52, 38, 38, 1);

-- --------------------------------------------------------

--
-- Table structure for table `teacher`
--

CREATE TABLE `teacher` (
  `id_teacher` int(11) NOT NULL,
  `civility` varchar(4) NOT NULL,
  `name` varchar(255) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `graduation` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `teacher`
--

INSERT INTO `teacher` (`id_teacher`, `civility`, `name`, `firstname`, `graduation`) VALUES
(12, 'M', 'JEAN-BAPTISTE', 'RONALD', '18:00:00'),
(13, 'M', 'DJEDJE', 'FRANCK', '18:00:00'),
(14, 'M', 'TITLI', 'DENIS', '18:00:00'),
(15, 'M', 'ZAGZAG', 'BENJAMIN', '18:00:00'),
(16, 'M', 'FOUET', 'PIERRE-ALAIN', '18:00:00'),
(17, 'Mme', 'TERNISIEN', 'DELPHINE', '18:00:00'),
(38, 'MME', 'ARNAUD', 'Agnès', '18:00:00'),
(39, 'MME', 'MOCQUE', 'Justine', '18:00:00'),
(40, 'MME', 'SOUMMAR', 'Nadjet', '18:00:00'),
(41, 'MME', 'HAKIMI', 'Lina', '18:00:00'),
(42, 'MME', 'DU CREST', 'Cécile', '18:00:00'),
(45, 'M', 'Horville', 'Alexandre', '18:00:00');

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
(12, 44),
(12, 47),
(38, 52),
(40, 51),
(45, 54),
(45, 55);

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
(12, 'UFA'),
(13, 'LYC'),
(13, 'UFA'),
(14, 'UFA'),
(15, 'LYC'),
(15, 'UFA'),
(16, 'UFA'),
(17, 'UFA'),
(38, 'UFA'),
(39, 'UFA'),
(40, 'UFA'),
(41, 'UFA'),
(42, 'UFA'),
(45, 'LYC');

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
-- Indexes for table `ponderate`
--
ALTER TABLE `ponderate`
  ADD PRIMARY KEY (`id_subject`);

--
-- Indexes for table `sector`
--
ALTER TABLE `sector`
  ADD PRIMARY KEY (`sector`);

--
-- Indexes for table `subject`
--
ALTER TABLE `subject`
  ADD PRIMARY KEY (`id_subject`),
  ADD KEY `table_name_sector_sector_fk` (`sector`);

--
-- Indexes for table `table_fiche`
--
ALTER TABLE `table_fiche`
  ADD PRIMARY KEY (`id_subject`,`id_class`),
  ADD KEY `table_fiche_class_id_class_fk` (`id_class`);

--
-- Indexes for table `table_fiche_affecter`
--
ALTER TABLE `table_fiche_affecter`
  ADD PRIMARY KEY (`id_class`,`id_subject`,`id_teacher`),
  ADD KEY `table_fiche_affecter_subject_id_subject_fk` (`id_subject`),
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
  MODIFY `id_class` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `subject`
--
ALTER TABLE `subject`
  MODIFY `id_subject` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `teacher`
--
ALTER TABLE `teacher`
  MODIFY `id_teacher` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

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
-- Constraints for table `ponderate`
--
ALTER TABLE `ponderate`
  ADD CONSTRAINT `ponderate_subject_id_subject_fk` FOREIGN KEY (`id_subject`) REFERENCES `subject` (`id_subject`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `subject`
--
ALTER TABLE `subject`
  ADD CONSTRAINT `table_name_sector_sector_fk` FOREIGN KEY (`sector`) REFERENCES `sector` (`sector`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `table_fiche`
--
ALTER TABLE `table_fiche`
  ADD CONSTRAINT `table_fiche_class_id_class_fk` FOREIGN KEY (`id_class`) REFERENCES `class` (`id_class`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `table_fiche_subject_id_subject_fk` FOREIGN KEY (`id_subject`) REFERENCES `subject` (`id_subject`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `table_fiche_affecter`
--
ALTER TABLE `table_fiche_affecter`
  ADD CONSTRAINT `table_fiche_affecter_class_id_class_fk` FOREIGN KEY (`id_class`) REFERENCES `class` (`id_class`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `table_fiche_affecter_subject_id_subject_fk` FOREIGN KEY (`id_subject`) REFERENCES `subject` (`id_subject`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `table_fiche_affecter_teacher_id_teacher_fk` FOREIGN KEY (`id_teacher`) REFERENCES `teacher` (`id_teacher`) ON DELETE CASCADE ON UPDATE CASCADE;

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
