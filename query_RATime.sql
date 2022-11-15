-- Roselin Dwi Septiani --

USE RAtime

--1
CREATE TABLE MsTopping(
	ToppingId CHAR(5) PRIMARY KEY,
	ToppingName VARCHAR(20) NOT NULL,
	ToppingPrice INT,

	CONSTRAINT CheckToppingId CHECK (ToppingId LIKE 'TO[0-9][0-9][0-9]'),
	CONSTRAINT CheckToppingName CHECK (LEN(ToppingName) >= 5)
)

--2
BEGIN TRAN
ALTER TABLE MsCustomer 
ADD CustomerEmail VARCHAR(20) CHECK (CustomerEmail LIKE '%@%')
ROLLBACK

SELECT * FROM MsCustomer

--3
INSERT INTO MsStaff VALUES
	('ST008','Reynard Jason','Male','085654412159',3300000)

--4
BEGIN TRAN
UPDATE MsStaff
SET StaffSalary += 150000
FROM MsStaff, TrTransactionHeader
WHERE MsStaff.StaffId = TrTransactionHeader.StaffId
AND MONTH(TransactionDate) = '08'
ROLLBACK

SELECT * FROM TrTransactionHeader

SELECT * FROM MsStaff

--5
SELECT StaffName, StaffSalary
FROM MsStaff
WHERE StaffName LIKE '% % %'


