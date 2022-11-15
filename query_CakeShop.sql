-- Roselin Dwi Septiani --

USE CakeShop

--1
CREATE TABLE PastryChef(
	PastryChefID CHAR(10) PRIMARY KEY,
	PastryChefName VARCHAR(50) NOT NULL,
	PastryChefEmail VARCHAR(50) NOT NULL, 
	PastryChefSalary INT NOT NULL,

	CONSTRAINT CheckPastryChefID CHECK (PastryChefID LIKE 'PC[0-9][0-9][0-9]'),
	CONSTRAINT CheckPastryChefEmail CHECK (PastryChefEmail LIKE '%@yahoo.com' OR PastryChefEmail LIKE '%@gmail.com')
)

--2
ALTER TABLE Staff
	ADD StaffPhone VARCHAR(15)

ALTER TABLE Staff
	ADD CONSTRAINT CheckStaffPhone CHECK (StaffPhone LIKE '+44%')

--3
INSERT INTO Customer VALUES
	('IA011','Emma Watson','Gryffindow Street No.6','02123123753','1990-04-15','Female')

--4
SELECT CakeID, CakeToppingID, CakeName, CakePrice, CakeStock FROM Cake
WHERE LEN(CakeName)  > 13

--5
UPDATE Staff 
SET StaffSalary += 1100000
FROM Staff, HeaderTransaction
WHERE Staff.StaffID = HeaderTransaction.StaffID
AND CustomerID = 'IA001'

SELECT * FROM Staff
