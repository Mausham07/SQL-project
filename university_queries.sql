-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema university_data
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema university_data
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `university_data` DEFAULT CHARACTER SET utf8 ;
USE `university_data` ;

-- -----------------------------------------------------
-- Table `university_data`.`college`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university_data`.`college` (
  `college_id` INT NOT NULL,
  `college` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`college_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `university_data`.`department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university_data`.`department` (
  `department_id` INT NOT NULL,
  `department` VARCHAR(45) NOT NULL,
  `college_id` INT NOT NULL,
  PRIMARY KEY (`department_id`),
  INDEX `fk_department_college1_idx` (`college_id` ASC) VISIBLE,
  CONSTRAINT `fk_department_college1`
    FOREIGN KEY (`college_id`)
    REFERENCES `university_data`.`college` (`college_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `university_data`.`course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university_data`.`course` (
  `course_id` INT NOT NULL,
  `course` VARCHAR(10) NOT NULL,
  `course_title` VARCHAR(35) NOT NULL,
  `credit` INT NOT NULL,
  `department_id` INT NOT NULL,
  PRIMARY KEY (`course_id`),
  INDEX `fk_course_department1_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `fk_course_department1`
    FOREIGN KEY (`department_id`)
    REFERENCES `university_data`.`department` (`department_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `university_data`.`faculty`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university_data`.`faculty` (
  `faculty_id` INT NOT NULL,
  `fname` VARCHAR(25) NOT NULL,
  `lname` VARCHAR(25) NOT NULL,
  `department_id` INT NOT NULL,
  PRIMARY KEY (`faculty_id`),
  INDEX `fk_faculty_department1_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `fk_faculty_department1`
    FOREIGN KEY (`department_id`)
    REFERENCES `university_data`.`department` (`department_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `university_data`.`term`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university_data`.`term` (
  `term_id` INT NOT NULL,
  `term` VARCHAR(20) NOT NULL,
  `year` YEAR NOT NULL,
  PRIMARY KEY (`term_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `university_data`.`section`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university_data`.`section` (
  `section_id` INT NOT NULL,
  `section_num` INT NOT NULL,
  `capacity` INT NOT NULL,
  `faculty_id` INT NOT NULL,
  `term_id` INT NOT NULL,
  `course_id` INT NOT NULL,
  PRIMARY KEY (`section_id`),
  INDEX `fk_section_faculty1_idx` (`faculty_id` ASC) VISIBLE,
  INDEX `fk_section_term1_idx` (`term_id` ASC) VISIBLE,
  INDEX `fk_section_course1_idx` (`course_id` ASC) VISIBLE,
  CONSTRAINT `fk_section_course1`
    FOREIGN KEY (`course_id`)
    REFERENCES `university_data`.`course` (`course_id`),
  CONSTRAINT `fk_section_faculty1`
    FOREIGN KEY (`faculty_id`)
    REFERENCES `university_data`.`faculty` (`faculty_id`),
  CONSTRAINT `fk_section_term1`
    FOREIGN KEY (`term_id`)
    REFERENCES `university_data`.`term` (`term_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `university_data`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university_data`.`student` (
  `student_id` INT NOT NULL,
  `fname` VARCHAR(25) NOT NULL,
  `lname` VARCHAR(25) NOT NULL,
  `gender` CHAR(1) NULL DEFAULT NULL,
  `city` VARCHAR(30) NOT NULL,
  `state` CHAR(2) NOT NULL,
  `dob` DATE NOT NULL,
  PRIMARY KEY (`student_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `university_data`.`enrollment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university_data`.`enrollment` (
  `section_id` INT NOT NULL,
  `student_id` INT NOT NULL,
  PRIMARY KEY (`section_id`, `student_id`),
  INDEX `fk_section_has_student_student1_idx` (`student_id` ASC) VISIBLE,
  INDEX `fk_section_has_student_section1_idx` (`section_id` ASC) VISIBLE,
  CONSTRAINT `fk_section_has_student_section1`
    FOREIGN KEY (`section_id`)
    REFERENCES `university_data`.`section` (`section_id`),
  CONSTRAINT `fk_section_has_student_student1`
    FOREIGN KEY (`student_id`)
    REFERENCES `university_data`.`student` (`student_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- Project 1 --
-- INSERT STATEMENTS --

-- here we are putting data for college table 

INSERT INTO college VALUES
(1, 'College of Physical Science and Engineering'),
(2, 'College of Business and Communication'),
(3, 'College of Language and Letters');



-- here we are putting data in department table

INSERT INTO department VALUES
(1, 'Computer Information Technology', 1),
(2, 'Economics', 2),
(3, 'Humanities and Philosophy', 3);



-- here we are inserting data in course table 

INSERT INTO course VALUES
(1, 'CIT 111', 'Intro to Databases', 3, 1),
(2, 'ECON 388', 'Econometrics', 4, 2),
(3, 'ECON 150', 'Micro Economics', 3, 2),
(4, 'HUM 376', 'Classical Heritage', 2, 3);



-- here we are inserting data in faculty table

INSERT INTO faculty VALUES
(1, 'Marty', 'Morring', 1),
(2, 'Nate', 'Norris', 2),
(3, 'Ben', 'Barrus', 2),
(4, 'John', 'Jensen', 3),
(5, 'Bill', 'Barney', 1);



-- here we are inserting data in student table

INSERT INTO student VALUES
(1, 'Paul', 'Miller', 'M', 'Dallas', 'TX', '1996-02-22'),
(2, 'Katie', 'Smith', 'F', 'Provo', 'UT', '1995-07-22'),
(3, 'Kelly', 'Jones', 'F', 'Provo', 'UT', '1998-06-22'),
(4, 'Devon', 'Merril', 'M', 'Mesa', 'AZ', '2000-07-22'),
(5, 'Mandy', 'Murdock', 'F', 'Topeka', 'KS', '1996-11-22'),
(6, 'Alece', 'Adams', 'F', 'Rigby', 'ID', '1997-05-22'),
(7, 'Bryce', 'Carlson', 'M', 'Bozeman', 'MT', '1997-11-22'),
(8, 'Preston', 'Larsen', 'M', 'Decatur', 'TN', '1996-09-22'),
(9, 'Julia', 'Madsen', 'F', 'Rexburg', 'ID', '1998-09-22'),
(10, 'Susan', 'Sorensen', 'F', 'Mesa', 'AZ', '1998-08-09');

-- here we are inserting data in terms table

INSERT INTO term VALUES
(1, 'Winter', 2018),
(2, 'Fall', 2019);

-- here we are inserting data in section table

INSERT INTO section VALUES
(1, 1, 30, 1, 2, 1),
(2, 1, 50, 2, 2, 3),
(3, 2, 50, 2, 2, 3),
(4, 1, 35, 3, 2, 2),
(5, 1, 30, 4, 2, 4),
(6, 2, 30, 1, 1, 1),
(7, 3, 35, 5, 1, 1),
(8, 1, 50, 2, 1, 3),
(9, 2, 50, 2, 1, 3),
(10, 1, 30, 4 , 1, 4);


-- here we are inserting values in enrollment table

INSERT INTO enrollment VALUES
(7, 6),
(6, 7),
(8, 7),
(10, 7),
(5, 4),
(9, 9),
(4, 2),
(4, 3),
(4, 5),
(5, 5),
(1, 1),
(3, 1),
(9, 8),
(6, 10);




-- Project Part 2 --

USE university_data;

-- Query 1 --
-- This code will show students, and their birthdays, of students born in September. --
-- It format the date and sort by student last name. --

SELECT fname AS 'first_name', lname AS 'last_name', DATE_FORMAT(dob, "%M %e, %Y") AS 'Sept Birthdays'
FROM student
WHERE MONTH(dob)= 09
ORDER BY lname;



-- Query 2 --
-- This code shows the student's age in year and days, as of Jan. 5, 2017
-- sorted from oldest to youngest.

SELECT lname AS 'last_name', fname AS 'first_name', FLOOR(DATEDIFF("2017-01-05", dob)/365) AS 'Years', MOD(DATEDIFF("2017-01-05", dob), 365) AS 'Days',
CONCAT(FLOOR(DATEDIFF("2017-01-05", dob)/365), ' - Yrs, ', MOD(DATEDIFF("2017-01-05", dob), 365), ' - Days') AS 'Years and Days'
FROM student
ORDER BY DATEDIFF("2017-01-05", dob) DESC ;



-- Query 3 --
-- This code shows the student name taught by John Jensen, sorted by last name.

SELECT st.fname AS 'first_name', st.lname AS 'last_name'
FROM student st
	JOIN enrollment en ON en.student_id = st.student_id
    JOIN section sec ON sec.section_id = en.section_id
WHERE faculty_id = 4
ORDER BY lname;



-- Query 4 --
-- This code shows the instructors Bryce will have in Winter 2018, sorted by faculty's last name

SELECT fc.fname AS 'faculty_fname', fc.lname AS 'faculty_lname'
FROM faculty fc
	JOIN section sec ON fc.faculty_id = sec.faculty_id
    JOIN enrollment en ON en.section_id = sec.section_id
WHERE term_id = 1 AND student_id = 7
ORDER BY lname;



-- Query 5 --
-- This code shows students that take Econometrics in Fall 2019, sorted by last name.

SELECT st.fname AS 'first_name', st.lname AS 'last_name'
FROM student st
	JOIN enrollment en ON en.student_id = st.student_id
    JOIN section sec ON sec.section_id = en.section_id
WHERE course_id = 2
ORDER BY lname;



-- Query 6 --
-- This code shows the report of Bryce Carlson's courses for Winter, sorted by the course name

SELECT SUBSTRING_INDEX(course, ' ', 1) AS 'department_code', RIGHT(course, 3) AS 'course_num', course_title
FROM course cr
	JOIN section sec ON sec.course_id = cr.course_id
    JOIN enrollment en ON en.section_id = sec.section_id
WHERE student_id = 7 AND term_id = 1
ORDER BY course_title;



-- Query 7 --
-- This code shows the number of students enrolled for Fall 2019.

SELECT tr.term, tr.year, COUNT(student_id) AS 'Enrollment'
FROM term tr
	JOIN section sec ON sec.term_id = tr.term_id
    JOIN enrollment en ON en.section_id = sec.section_id
WHERE term = 'FALL' AND year = 2019
GROUP BY term;




-- Query 8 --
-- This code shows number of courses in each college, sorted by college name

SELECT college, COUNT(course_id) AS 'Number of Courses'
FROM  college col
	JOIN department dp ON dp.college_id = col.college_id
    JOIN course cr ON cr.department_id = dp.department_id
GROUP BY college
ORDER BY college;



-- Query 9 --
-- This code will show faculty's name with total number of students each professor can teach in Winter 2018

SELECT fname AS 'faculty_fname', lname AS 'faculty_lname', SUM(capacity) AS 'Teaching Capacity'
FROM faculty fc
	JOIN section sec ON sec.faculty_id = fc.faculty_id
WHERE term_id = 1
GROUP BY fname, lname
ORDER BY SUM(capacity);


-- Query 10 --
-- This code shows the students total credit load for Fall 2019, only students who have credit load grater than 3, 
-- sorted by credit load in descending order

-- SELECT lname AS 'last_name', fname AS 'first_name', 

SELECT st.lname AS 'last_name', st.fname AS 'first_name', SUM(credit) AS 'Credits'
FROM student st
	JOIN enrollment en ON st.student_id = en.student_id
    JOIN section sec ON sec.section_id = en.section_id
    JOIN course cr ON cr.course_id = sec.course_id
WHERE term_id = 2
GROUP BY fname, lname
HAVING SUM(credit) > 3
ORDER BY SUM(credit) DESC;


