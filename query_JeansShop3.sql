-- Roselin Dwi Septiani --

CREATE DATABASE JeansShop3

USE JeansShop3

CREATE TABLE Customer(
	CustomerID CHAR(5) PRIMARY KEY,
	CustomerName VARCHAR(30) NOT NULL,
	CustomerDOB DATE,
	CustomerGender VARCHAR(6) NOT NULL,
	CustomerPhoneNumber INT,
	CustomerEmail VARCHAR(50) NOT NULL, 

	CONSTRAINT CheckCustomerID CHECK (CustomerID LIKE 'CU[0-9][0-9][0-9]'),
	CONSTRAINT CheckCustomerName CHECK (LEN(CustomerName) >= 3),
	CONSTRAINT CheckCustomerGender CHECK (CustomerGender IN ('MALE', 'FEMALE')),
)

CREATE TABLE Staff(	
	StaffID CHAR(5) PRIMARY KEY,
	StaffName VARCHAR(30) NOT NULL,
	StaffDOB DATE,
	StaffGender VARCHAR(6) NOT NULL, 
	StaffPosition VARCHAR(25) NOT NULL,
	StaffSalary INT,

	CONSTRAINT CheckStaffID CHECK (StaffID LIKE 'ST[0-9][0-9][0-9]'),
	CONSTRAINT CheckStaffName CHECK (LEN(StaffName) >= 3),
	CONSTRAINT CheckStaffGender CHECK (StaffGender IN ('MALE', 'FEMALE')),
)

CREATE TABLE Vendor(
	VendorID CHAR(5) PRIMARY KEY,
	VendorName VARCHAR(30) NOT NULL,
	VendorEmail VARCHAR(50) NOT NULL,
	VendorAddress VARCHAR(50) NOT NULL,

	CONSTRAINT CheckVendorID CHECK (VendorID LIKE 'VN[0-9][0-9][0-9]'),
	CONSTRAINT CheckVendorName CHECK (LEN(VendorName) >= 3),
)

CREATE TABLE Jeans(
	JeansID CHAR(5) PRIMARY KEY,
	JeansName VARCHAR(30) NOT NULL,
	JeansPrice INT,
	JeansStock INT, 

	CONSTRAINT CheckJeansID CHECK (JeansID LIKE 'JN[0-9][0-9][0-9]'),
	CONSTRAINT CheckJeansName CHECK (LEN(JeansName) >= 3),
)

CREATE TABLE Material(
	MaterialID CHAR(5) PRIMARY KEY,
	MaterialName VARCHAR(30) NOT NULL,
	MaterialPrice INT,
	MaterialStock INT,

	CONSTRAINT CheckMaterialID CHECK (MaterialID LIKE 'MT[0-9][0-9][0-9]'),
	CONSTRAINT CheckMaterialName CHECK (LEN(MaterialName) >= 3),
)

CREATE TABLE SalesTransaction(
	SalesID CHAR(5) PRIMARY KEY,
	StaffID CHAR(5) NOT NULL,
	CustomerID CHAR(5) NOT NULL,
	SalesTransactionDate DATE,

	CONSTRAINT CheckSalesID CHECK (SalesID LIKE 'SL[0-9][0-9][0-9]'),
	FOREIGN KEY (StaffID) REFERENCES Staff ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (CustomerID) REFERENCES Customer ON UPDATE CASCADE ON DELETE CASCADE
)

CREATE TABLE PurchaseTransaction(
	PurchaseID CHAR(5) PRIMARY KEY,
	StaffID CHAR(5) NOT NULL,
	VendorID CHAR(5) NOT NULL,
	PurchaseTransactionDate DATE,

	CONSTRAINT CheckpurchaseID CHECK (PurchaseID LIKE 'PC[0-9][0-9][0-9]'),
	FOREIGN KEY (StaffID) REFERENCES Staff ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (VendorID) REFERENCES Vendor ON UPDATE CASCADE ON DELETE CASCADE
)

CREATE TABLE DetailSalesTransaction(
	SalesID CHAR(5) NOT NULL,
	JeansID CHAR(5) NOT NULL,
	Quantity INT,

	FOREIGN KEY (SalesID) REFERENCES SalesTransaction ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (JeansID) REFERENCES Jeans ON UPDATE CASCADE ON DELETE CASCADE
)

CREATE TABLE DetailPurchaseTransaction(
	PurchaseID CHAR(5) NOT NULL,
	MaterialID CHAR(5) NOT NULL,
	Quantity INT,

	FOREIGN KEY (PurchaseID) REFERENCES PurchaseTransaction ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (MaterialID) REFERENCES Material ON UPDATE CASCADE ON DELETE CASCADE
)

CREATE TABLE DetailJeans(
	JeansID CHAR(5) NOT NULL,
	MaterialID CHAR(5) NOT NULL,

	FOREIGN KEY (JeansID) REFERENCES Jeans ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (MaterialID) REFERENCES Material ON UPDATE CASCADE ON DELETE CASCADE
)

INSERT INTO Customer VALUES 
	('CU001','Roselin','2002-09-08','Female','1234567890','roselin.dwi@gmail.com'),
	('CU002','Hanson','2002-10-26','Male','1234567891','hanson.budhi@gmail.com'),
	('CU003','Daniel','2002-12-30','Male','1234567892','daniel025@gmail.com'),
	('CU004','Kevin','2002-02-27','Male','1234567893','kevin026@gmail.com'),
	('CU005','Selin','2002-08-09','Female','1234567894','selin.lin@gmail.com')

INSERT INTO Staff VALUES
	('ST001','Kezia','1999-08-09','Female','Staff',3500000),
	('ST002','Albert','1998-12-30','Male','Manager',4500000),
	('ST003','Vania','1997-11-22','Female','Staff',4000000),
	('ST004','James','1994-02-25','Male','Manager',5000000),
	('ST005','Joshua','1995-05-30','Male','Manager',4600000)

INSERT INTO Vendor VALUES
	('VN001','Benang bagus','benangbagus@gmail.com','Jalan Batu No 14'),
	('VN002','Kain bagus','kainbagus@gmail.com','Jalan Bulan No 20'),
	('VN003','Kancing bagus','kancingbagus@gmail.com','Jalan Bintang No 25'),
	('VN004','Kain berwarna 1','kainberwarna1@gmail.com','Jalan Pelangi No 20'),
	('VN005','Kain berwarna 2','kainberwarna2@gmail.com','Jalan Sky No 20')

INSERT INTO Jeans VALUES
	('JN001','Skinny Jeans',120000,20),
	('JN002','Blue Jeans',110000,30),
	('JN003','Green Jeans',130000,15),
	('JN004','Pink Jeans',125000,35),
	('JN005','Purple Jeans',150000,50)

INSERT INTO Material VALUES
	('MT001','Kain Pink',55000,15),
	('MT002','Kain Blue',60000,10),
	('MT003','Kain Green',65000,12),
	('MT004','Kain Purple',40000,21),
	('MT005','Kain Basic',45000,34)

INSERT INTO DetailJeans VALUES
	('JN001','MT005'),
	('JN002','MT002'),
	('JN003','MT003'),
	('JN004','MT001'),
	('JN005','MT004')

INSERT INTO SalesTransaction VALUES
	('SL001','ST004','CU002','2021-03-16'),
	('SL002','ST004','CU001','2021-03-17'),
	('SL003','ST005','CU003','2021-03-17'),
	('SL004','ST001','CU005','2021-03-18'),
	('SL005','ST002','CU004','2021-03-19'),
	('SL006','ST005','CU001','2021-04-01'),
	('SL007','ST004','CU002','2021-04-02'),
	('SL008','ST005','CU004','2021-04-03')

INSERT INTO DetailSalesTransaction VALUES
	('SL001','JN002',2),
	('SL002','JN003',3),
	('SL003','JN001',1),
	('SL004','JN004',5),
	('SL005','JN003',4)

INSERT INTO PurchaseTransaction VALUES
	('PC001','ST005','VN001','2021-03-16'),
	('PC002','ST005','VN002','2021-03-17'),
	('PC003','ST002','VN001','2021-03-17'),
	('PC004','ST003','VN004','2021-03-18'),
	('PC005','ST001','VN003','2021-03-19')

INSERT INTO DetailPurchaseTransaction VALUES
	('PC001','MT004',5),
	('PC002','MT004',10),
	('PC003','MT005',4),
	('PC004','MT005',2),
	('PC005','MT002',4)

--1. INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL OUTER
--INNER JOIN
SELECT VendorName,
	Count(MaterialID) AS CountMaterialID, 
	SUM(Quantity) AS SumQuantity
FROM Vendor v, PurchaseTransaction pt, DetailPurchaseTransaction dpt
WHERE v.VendorID = pt.VendorID
AND dpt.PurchaseID = pt.PurchaseID
GROUP BY VendorName
ORDER BY VendorName

--OUTER JOIN
--LEFT JOIN
SELECT st.SalesID, st.SalesTransactionDate, sf.StaffID, sf.StaffName
FROM Staff sf LEFT JOIN SalesTransaction st
ON sf.StaffID = st.StaffID

--RIGHT JOIN
SELECT st.SalesID, st.SalesTransactionDate, sf.StaffID, sf.StaffName
FROM Staff sf RIGHT JOIN SalesTransaction st
ON sf.StaffID = st.StaffID

--FULL OUTER
SELECT st.SalesID, st.SalesTransactionDate, sf.StaffID, sf.StaffName
FROM Staff sf FULL OUTER JOIN SalesTransaction st
ON sf.StaffID = st.StaffID

--2. UNION, INTERSECT, EXCEPT
-- UNION
SELECT StaffID
FROM Staff
UNION
SELECT StaffID
FROM SalesTransaction

--INTERSECT
SELECT StaffID
FROM Staff
INTERSECT
SELECT StaffID
FROM SalesTransaction

--EXCEPT
SELECT StaffID
FROM Staff
EXCEPT
SELECT StaffID
FROM SalesTransaction

--3. ALTERNATIVE JOIN 
--CASE:Show Sales ID, Sales Transaction Date, Customer Name, Staff Name
--Join 1
SELECT st.SalesID AS 'Sales ID',
	   st.SalesTransactionDate AS 'Date',
	   c.CustomerName AS  'Customer Name',
	   s.StaffName AS 'Served By'
FROM Customer c, SalesTransaction st, Staff s
WHERE c.CustomerID = st.CustomerID
AND st.StaffID = s.StaffID

--Join 2
SELECT st.SalesID AS 'Sales ID',
	   st.SalesTransactionDate AS 'Date',
	   c.CustomerName AS  'Customer Name',
	   s.StaffName AS 'Served By'
FROM Customer c JOIN SalesTransaction st ON c.CustomerID = st.CustomerID
				JOIN  Staff s ON s.StaffID = st.StaffID

--Join 3
SELECT st.SalesID AS 'Sales ID',
	   st.SalesTransactionDate AS 'Date',
	   c.CustomerName AS  'Customer Name',
	   s.StaffName AS 'Served By'
FROM Customer JOIN SalesTransaction USING CustomerID
			  JOIN Staff USING StaffID