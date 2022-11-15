-- Roselin Dwi Septiani --

USE RamenShop

--1
CREATE TABLE Branch(
	BranchID CHAR(5) PRIMARY KEY, 
	BranchAddress VARCHAR(50) NOT NULL,
	BranchPhone VARCHAR(15) NOT NULL,
	BranchOwner VARCHAR(50) NOT NULL,

	CONSTRAINT CheckBranchID CHECK (BranchID LIKE 'BR[0-9][0-9][0-9]'),
	CONSTRAINT CheckBranchAddress CHECK (BranchAddress LIKE'%Street')
)

--2
ALTER TABLE Staff
	ADD StaffPhone VARCHAR(15)

ALTER TABLE Staff
	ADD CONSTRAINT CheckStaffPhone CHECK (StaffPhone LIKE '+62%')

--3
INSERT INTO Staff VALUES
	('ST006','Martin Gunawan','Male','05-17-1989','martin-9809@yopmail.com',NULL)

--4
SELECT StaffID, StaffName, StaffGender FROM Staff
WHERE MONTH (StaffDOB) = 5;

--5
UPDATE Ramen
SET RamenPrice += 10000
FROM Ramen, TransactionDetail
WHERE Ramen.RamenID = TransactionDetail.RamenID
AND RIGHT (TransactionID, 3) % 2 = 0

SELECT * FROM Ramen

