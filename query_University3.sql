-- Roselin Dwi Septiani --

CREATE DATABASE University3

USE University3

CREATE TABLE Student(
	STUD_ID CHAR(5) PRIMARY KEY,
	STUD_FNAME VARCHAR(30) NOT NULL,
	STUD_LNAME VARCHAR(30) NOT NULL,
	STUD_STREET VARCHAR(50) NOT NULL,
	STUD_CITY VARCHAR(30) NOT NULL,

	CONSTRAINT CheckSTUD_ID CHECK (STUD_ID LIKE 'ST[0-9][0-9][0-9]')
)

CREATE TABLE Prof(
	PROF_ID CHAR(6) PRIMARY KEY,
	PROF_FNAME VARCHAR(30) NOT NULL,
	PROF_LNAME VARCHAR (30) NOT NULL,

	CONSTRAINT CheckProf_ID CHECK (PROF_ID LIKE 'PR[0-9][0-9][0-9]')
)

CREATE TABLE Class(
	CLASS_ID CHAR(8) PRIMARY KEY,
	CLASS_NAME VARCHAR(30) NOT NULL,
	PROF_ID CHAR(6),

	CONSTRAINT CheckClassID CHECK (CLASS_ID LIKE 'CLS[0-9][0-9]'),
	FOREIGN KEY (PROF_ID) REFERENCES Prof ON UPDATE CASCADE ON DELETE CASCADE
)

CREATE TABLE Enroll(
	STUD_ID CHAR(5) NOT NULL,
	CLASS_ID CHAR(8) NOT NULL,
	GRADE INT NOT NULL,

	CONSTRAINT CheckGrade CHECK (GRADE BETWEEN 0 AND 100),
	FOREIGN KEY (STUD_ID) REFERENCES Student ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (CLASS_ID) REFERENCES Class ON UPDATE CASCADE ON DELETE CASCADE
)

CREATE TABLE Room(
	ROOM_ID CHAR(5) PRIMARY KEY,
	ROOM_LOC VARCHAR(30) NOT NULL,
	ROOM_CAP INT NOT NULL,
	CLASS_ID CHAR(8) NOT NULL,

	CONSTRAINT CheckRoomID CHECK (ROOM_ID LIKE 'RM[0-9][0-9][0-9]'),
	FOREIGN KEY (CLASS_ID) REFERENCES Class ON UPDATE CASCADE ON DELETE CASCADE 
)
	
INSERT INTO Student VALUES
	('ST001','Roselin','Dwi','Bintang Street','Jakarta'),
	('ST002','Hanson','Budhi','Bulan Street','Jakarta'),
	('ST003','Daniel','Tjan','Pelangi Street','tangerang'),
	('ST004','Albert','Christian','Sky Street','Tangerang'),
	('ST005','Selin','Lynn','Sunshine Street','Jakarta')

INSERT INTO Prof VALUES
	('PR001','Michael','Kevin'),
	('PR002','Kevin','Albert'),
	('PR003','Lynn','Dwi'),
	('PR004','Septiani','Dwi'),
	('PR005','Roselin','Septiani')

INSERT INTO Class VALUES
	('CLS01','Sunshine','PR001'),
	('CLS02','Sky','PR002'),
	('CLS03','Rainbow','PR003'),
	('CLS04','Clouds','PR001'),
	('CLS05','Stars','PR002')

INSERT INTO Enroll VALUES
	('ST001','CLS02',90),
	('ST002','CLS01',95),
	('ST002','CLS03',85),
	('ST004','CLS05',80),
	('ST005','CLS04',90)

INSERT INTO Room VALUES
	('RM001','Floor 1A',70,'CLS02'),
	('RM002','Floor 2A',40,'CLS01'),
	('RM003','Floor 3A',30,'CLS03'),
	('RM004','Floor 4A',80,'CLS05'),
	('RM005','Floor 5A',20,'CLS04')

-- 1. The example to show the differences between Inner Join and Outer Join
-- a. Inner Join 
SELECT 
	[Student Name] = st.STUD_FNAME + ' ' + st.STUD_LNAME,
	[Class Name] = cl.CLASS_NAME,
	[Student's Grade] = en.GRADE
FROM Student st
INNER JOIN Enroll en 
ON st.STUD_ID = en.STUD_ID
INNER JOIN Class cl 
ON cl.CLASS_ID = en.CLASS_ID
-- In this query, Daniel isn't showed because Daniel don't take any class.

-- b. Outer Join 
SELECT 
	[Student Name] = st.STUD_FNAME + ' ' + st.STUD_LNAME,
	[Class Name] = cl.CLASS_NAME,
	[Student's Grade] = en.GRADE
FROM Student st
LEFT JOIN Enroll en 
ON st.STUD_ID = en.STUD_ID
LEFT JOIN Class cl 
ON cl.CLASS_ID = en.CLASS_ID
-- In this query, Daniel is showed even Daniel don't take any class.	

-- 2. Syntax to using Inner Join to show Student ID, Last Name of Student, Last Name of Prof, whose grade is greater than 84
SELECT 
	[Student ID] = st.STUD_ID,
	[Last Name of Student] = st.STUD_LNAME,
	[Last Name of Prof] = pr.PROF_LNAME
FROM Student st
INNER JOIN Enroll en 
ON st.STUD_ID = en.STUD_ID
INNER JOIN Class cl 
ON en.CLASS_ID = cl.CLASS_ID
INNER JOIN Prof pr
ON cl.PROF_ID = pr.PROF_ID
WHERE en.GRADE > 84

-- 3. Syntax using Outer Join to show
-- a. Student name that never and ever enrolled class
-- Student ever enrolled class
SELECT [Student Name] = STUD_FNAME + ' ' + STUD_LNAME
FROM Student
WHERE STUD_ID IN (
	SELECT STUD_ID
	FROM Student
	INTERSECT
	SELECT STUD_ID
	FROM Enroll
)
ORDER BY [Student Name]

-- Student never enrolled class
SELECT [Student Name] = STUD_FNAME + ' ' + STUD_LNAME
FROM Student
WHERE STUD_ID IN (
	SELECT STUD_ID
	FROM Student
	EXCEPT
	SELECT STUD_ID
	FROM Enroll
)
ORDER BY [Student Name]

-- Count the number of enrolled class 
SELECT 
	[Student Name] = st.STUD_FNAME + ' ' + st.STUD_LNAME,
	[Enrolled] = 'Enroll' + ' ' + CAST(COUNT(en.CLASS_ID) AS VARCHAR) + ' ' + 'Class'
FROM Student st
LEFT JOIN Enroll en
ON en.STUD_ID = st.STUD_ID 
LEFT JOIN Class cl
ON en.CLASS_ID = cl.CLASS_ID 
GROUP BY st.STUD_FNAME, st.STUD_LNAME

-- b. Prof name that never and ever taught a class
-- Prof ever taught class
SELECT [Prof Name] = PROF_FNAME + ' ' + PROF_LNAME
FROM Prof
WHERE PROF_ID IN (
	SELECT PROF_ID
	FROM Prof
	INTERSECT
	SELECT PROF_ID
	FROM Class
)
ORDER BY [Prof Name]

-- Prof never taught class
SELECT [Prof Name] = PROF_FNAME + ' ' + PROF_LNAME
FROM Prof
WHERE PROF_ID IN (
	SELECT PROF_ID
	FROM Prof
	EXCEPT
	SELECT PROF_ID
	FROM Class
)
ORDER BY [Prof Name]

-- Count the number of class that has taught by Prof
SELECT
	[Prof Name] = pr.PROF_FNAME + ' ' + pr.PROF_LNAME,
	[Taught] = 'Taught' + ' ' + CAST(COUNT(cl.CLASS_ID) AS VARCHAR) + ' ' + 'Class'
FROM Prof pr
LEFT JOIN Class cl
ON pr.PROF_ID = cl.PROF_ID
GROUP BY pr.PROF_FNAME, pr.PROF_LNAME

-- 4. Prof ID who has taught minimum 1 class, using:
-- a. JOIN
SELECT DISTINCT pf.PROF_ID
FROM Prof pf 
JOIN Class cl
ON pf.PROF_ID = cl.PROF_ID
ORDER BY pf.PROF_ID 

-- b. IN
SELECT Prof.PROF_ID
FROM Prof 
WHERE PROF_ID IN (
	SELECT PROF_ID
	FROM Class
)

-- c. EXISTS
SELECT Prof.PROF_ID
FROM Prof 
WHERE EXISTS (
	SELECT *
	FROM Class
	WHERE Prof.PROF_ID = Class.PROF_ID
)

-- d. INTERSECT
SELECT PROF_ID
FROM Prof
INTERSECT 
SELECT PROF_ID
FROM Class

-- 5. Student ID who never enrolled any classes, using:
-- a. NOT IN
SELECT STUD_ID
FROM Student
WHERE STUD_ID NOT IN (
	SELECT STUD_ID
	FROM Enroll
)

-- b. NOT EXISTS
SELECT STUD_ID
FROM Student
WHERE NOT EXISTS (
	SELECT *
	FROM Enroll
	WHERE Student.STUD_ID = Enroll.STUD_ID
)

-- c. EXCEPT
SELECT STUD_ID
FROM Student
EXCEPT
SELECT STUD_ID
FROM Enroll