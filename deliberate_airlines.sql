-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jan 08, 2020 at 11:43 AM
-- Server version: 10.4.10-MariaDB
-- PHP Version: 7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `deliberate_airlines`
--

-- --------------------------------------------------------

--
-- Table structure for table `aircrafts`
--

DROP TABLE IF EXISTS `aircrafts`;
CREATE TABLE IF NOT EXISTS `aircrafts` (
  `aircraft_id` int(11) NOT NULL AUTO_INCREMENT,
  `aircraft_name` text DEFAULT NULL,
  `cruising_range` double DEFAULT NULL,
  PRIMARY KEY (`aircraft_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `aircrafts`
--

INSERT INTO `aircrafts` (`aircraft_id`, `aircraft_name`, `cruising_range`) VALUES
(1, 'Deliberate23', 2300),
(2, 'Deliberate787', 5300),
(3, 'Deliberate898', 5000),
(4, 'AeroDeli24', 4000),
(5, 'RadioGaga13', 4300);

-- --------------------------------------------------------

--
-- Table structure for table `certified`
--

DROP TABLE IF EXISTS `certified`;
CREATE TABLE IF NOT EXISTS `certified` (
  `e_id` int(11) NOT NULL,
  `aircraft_id` int(11) NOT NULL,
  PRIMARY KEY (`e_id`,`aircraft_id`),
  KEY `aircraft_id` (`aircraft_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `certified`
--

INSERT INTO `certified` (`e_id`, `aircraft_id`) VALUES
(1, 1),
(3, 1),
(3, 2),
(3, 3);

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
CREATE TABLE IF NOT EXISTS `employees` (
  `e_id` int(11) NOT NULL AUTO_INCREMENT,
  `e_name` text DEFAULT NULL,
  `salary` double DEFAULT NULL,
  PRIMARY KEY (`e_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`e_id`, `e_name`, `salary`) VALUES
(1, 'Rishabh Jaiswal', 10000000),
(2, 'Tom Brady', 80000),
(3, 'Steve Austin', 90000);

-- --------------------------------------------------------

--
-- Table structure for table `flights`
--

DROP TABLE IF EXISTS `flights`;
CREATE TABLE IF NOT EXISTS `flights` (
  `flight_no` int(11) NOT NULL AUTO_INCREMENT,
  `from_place` text DEFAULT NULL,
  `to_place` text DEFAULT NULL,
  `dist` double NOT NULL,
  `dept_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `arr_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `price` double DEFAULT NULL,
  `aircraft_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`flight_no`),
  KEY `aircraft_id` (`aircraft_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `flights`
--

INSERT INTO `flights` (`flight_no`, `from_place`, `to_place`, `dist`, `dept_time`, `arr_time`, `price`, `aircraft_id`) VALUES
(1, 'India', 'Melbourne', 2100, '2020-01-08 10:42:52', '2020-01-08 18:30:00', 51000, 1),
(2, 'India', 'London', 900, '2020-01-08 10:42:54', '2020-01-09 18:30:00', 41000, 1),
(3, 'India', 'Canada', 1400, '2020-01-08 10:44:57', '2020-01-08 18:30:00', 61000, 2),
(4, 'Canada', 'India', 1600, '2020-01-08 11:19:42', '2020-01-09 18:30:00', 57000, 2),
(5, 'India', 'Germany', 700, '2020-01-08 11:20:38', '2020-01-08 18:30:00', 21000, 3);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
