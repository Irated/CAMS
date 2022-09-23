-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Mar 29, 2022 at 01:43 PM
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
-- Database: `project`
--

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `leaderboard`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `leaderboard` ()  NO SQL
select q.quizname,s.score,s.totalscore,st.name,s.mail from score s,student st,quiz q where s.mail=st.mail and q.quizid=s.quizid order by score DESC$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `dept`
--

DROP TABLE IF EXISTS `dept`;
CREATE TABLE IF NOT EXISTS `dept` (
  `dept_id` int(11) NOT NULL,
  `dept_name` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dept`
--

INSERT INTO `dept` (`dept_id`, `dept_name`) VALUES
(1, 'CSE'),
(2, 'ISE'),
(3, 'ECE'),
(4, 'ME');

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
CREATE TABLE IF NOT EXISTS `questions` (
  `qs` varchar(200) NOT NULL,
  `op1` varchar(100) NOT NULL,
  `op2` varchar(100) NOT NULL,
  `op3` varchar(100) NOT NULL,
  `answer` varchar(100) NOT NULL,
  `quizid` int(11) NOT NULL,
  UNIQUE KEY `qs` (`qs`),
  KEY `quizid` (`quizid`),
  KEY `quizid_2` (`quizid`),
  KEY `quizid_3` (`quizid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`qs`, `op1`, `op2`, `op3`, `answer`, `quizid`) VALUES
('What is DBMS?', 'DBMS is a collection of queries', 'DBMS is a high-level language', 'DBMS is a programming language', 'DBMS stores, modifies and retrieves data', 9),
('What is the full form of DBMS?', 'Data of Binary Management System', 'Database Management Service', 'Data Backup Management System\r\n', 'Database Management System', 9),
('Who created the first DBMS?', 'Edgar Frank Codd', 'Charles Bachman', 'Charles Babbage', 'Sharon B. Codd', 9);

-- --------------------------------------------------------

--
-- Table structure for table `quiz`
--

DROP TABLE IF EXISTS `quiz`;
CREATE TABLE IF NOT EXISTS `quiz` (
  `quizid` int(11) NOT NULL AUTO_INCREMENT,
  `quizname` varchar(20) NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp(),
  `mail` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`quizid`),
  KEY `mail` (`mail`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `quiz`
--

INSERT INTO `quiz` (`quizid`, `quizname`, `date_created`, `mail`) VALUES
(9, 'DBMS', '2022-01-29 14:49:02', 'rachanams.rvitm@rvei.edu.in'),
(11, 'CN', '2022-02-07 03:57:52', 'rachanams.rvitm@rvei.edu.in');

--
-- Triggers `quiz`
--
DROP TRIGGER IF EXISTS `ondeleteqs`;
DELIMITER $$
CREATE TRIGGER `ondeleteqs` AFTER DELETE ON `quiz` FOR EACH ROW delete from questions where questions.quizid=old.quizid
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `score`
--

DROP TABLE IF EXISTS `score`;
CREATE TABLE IF NOT EXISTS `score` (
  `slno` int(11) NOT NULL AUTO_INCREMENT,
  `score` int(11) NOT NULL,
  `quizid` int(11) NOT NULL,
  `mail` varchar(50) DEFAULT NULL,
  `totalscore` int(11) DEFAULT NULL,
  `remark` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`slno`),
  KEY `quizid` (`quizid`),
  KEY `mail` (`mail`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `score`
--

INSERT INTO `score` (`slno`, `score`, `quizid`, `mail`, `totalscore`, `remark`) VALUES
(17, 3, 9, 'balrajsingh_cs19.rvitm@rvei.edu.in', 3, 'good'),
(18, 3, 9, 'ardhanush_cs19.rvitm@rvei.edu.in', 3, 'good'),
(19, 1, 9, 'adarshkumar_cs19.rvitm@rvei.edu.in', 3, 'good'),
(20, 1, 9, 'akshaygupta_cs19.rvitm@rvei.edu.in', 3, 'good');

--
-- Triggers `score`
--
DROP TRIGGER IF EXISTS `remarks`;
DELIMITER $$
CREATE TRIGGER `remarks` BEFORE INSERT ON `score` FOR EACH ROW set NEW.remark = if(NEW.score = 0, 'bad', 'good')
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
CREATE TABLE IF NOT EXISTS `staff` (
  `staffid` varchar(10) NOT NULL,
  `name` varchar(20) NOT NULL,
  `mail` varchar(50) NOT NULL,
  `phno` varchar(10) NOT NULL,
  `gender` varchar(1) NOT NULL,
  `DOB` varchar(10) NOT NULL,
  `pw` varchar(200) NOT NULL,
  `dept` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`mail`),
  UNIQUE KEY `mail` (`mail`,`phno`),
  UNIQUE KEY `staffid` (`staffid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`staffid`, `name`, `mail`, `phno`, `gender`, `DOB`, `pw`, `dept`) VALUES
('102', 'Dr. Deepak N A', 'deepakna.rvitm@rvei.edu.in', '9807564312', 'M', '1993-05-22', 'rvMIwg2n338ug', 'CSE'),
('101', 'Rachana M S', 'rachanams.rvitm@rvei.edu.in', '7809124356', 'F', '1998-11-11', 'rv4hRapjEl2Lk', 'CSE');

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
CREATE TABLE IF NOT EXISTS `student` (
  `usn` varchar(10) NOT NULL,
  `name` varchar(20) NOT NULL,
  `mail` varchar(50) NOT NULL,
  `phno` varchar(10) NOT NULL,
  `gender` varchar(1) NOT NULL,
  `DOB` varchar(10) NOT NULL,
  `pw` varchar(200) NOT NULL,
  `dept` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`mail`),
  UNIQUE KEY `mail` (`mail`),
  UNIQUE KEY `phno` (`phno`),
  UNIQUE KEY `usn` (`usn`),
  KEY `dept` (`dept`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`usn`, `name`, `mail`, `phno`, `gender`, `DOB`, `pw`, `dept`) VALUES
('1RF19CS002', 'Achintya A A', 'achintyaaa_cs19.rvitm@rvei.edu.in', '9087654321', 'M', '2001-02-02', 'rvuTlhP9JUh76', 'CSE'),
('1RF19CS003', 'Adarsh Kumar', 'adarshkumar_cs19.rvitm@rvei.edu.in', '8901234567', 'M', '2000-03-03', 'rvmb0Za6riWfg', 'CSE'),
('1RF19CS004', 'Adith Kadam R', 'adithkadamr_cs19.rvitm@rvei.edu.in', '7899064321', 'M', '2001-04-04', 'rvyK2mBdP.hQc', 'CSE'),
('1RF19CS005', 'Aditi S', 'aditis_cs19.rvitm@rvei.edu.in', '678905432', 'F', '2001-05-05', 'rv/JvBU9MZt6Q', 'CSE'),
('1RF19CS006', 'Akshay Gupta', 'akshaygupta_cs19.rvitm@rvei.edu.in', '9087612345', 'M', '2001-06-06', 'rvsKnbTNFO.aI', 'CSE'),
('1RF19CS007', 'Anika Prem', 'anikaprem_cs19.rvitm@rvei.edu.in', '9870612345', 'F', '2001-07-07', 'rvtSdF0agfcok', 'CSE'),
('1RF19CS008', 'Anshi Sinha', 'anshisinha_cs19.rvitm@rvei.edu.in', '9087645123', 'F', '2001-08-08', 'rvYg5eGOje.Us', 'CSE'),
('1RF19CS001', 'A R Dhanush', 'ardhanush_cs19.rvitm@rvei.edu.in', '9876543201', 'M', '2001-01-01', 'rvyEGGf8pRiP6', 'CSE'),
('1RF19CS009', 'Autri Acharyya', 'autriacharyya_cs19.rvitm@rvei.edu.in', '9876051423', 'M', '2000-09-09', 'rvMI8FILtHoWw', 'CSE'),
('1RF19CS010', 'Balraj Singh', 'balrajsingh_cs19.rvitm@rvei.edu.in', '8790563412', 'M', '2001-10-10', 'rvyEGGf8pRiP6', 'CSE');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `quiz`
--
ALTER TABLE `quiz`
  ADD CONSTRAINT `quiz_ibfk_1` FOREIGN KEY (`mail`) REFERENCES `staff` (`mail`) ON DELETE CASCADE;

--
-- Constraints for table `score`
--
ALTER TABLE `score`
  ADD CONSTRAINT `score_ibfk_1` FOREIGN KEY (`quizid`) REFERENCES `quiz` (`quizid`) ON DELETE CASCADE,
  ADD CONSTRAINT `score_ibfk_2` FOREIGN KEY (`mail`) REFERENCES `student` (`mail`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
