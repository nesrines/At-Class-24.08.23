CREATE DATABASE ElectronicsDb
USE ElectronicsDb

CREATE TABLE Brands
(
	Id int PRIMARY KEY IDENTITY,
	Name nvarchar(50) NOT NULL
)

INSERT INTO Brands VALUES
	('Acer'), ('Apple'), ('Asus'),
	('Hewlett Packard'), ('Huawei'),
	('Lenovo'), ('Microsoft'), ('MSI'),
	('Nokia'), ('Samsung'), ('Xiaomi')

--1) Notebook ve Brand Arasinda Mentiqe Uygun Relation Qurun.
CREATE TABLE Notebooks
(
	Id int PRIMARY KEY IDENTITY,
	Name nvarchar(100) NOT NULL,
	Price decimal(7,2) NOT NULL,
	BrandId int FOREIGN KEY REFERENCES Brands(Id)
)

--2) Phones ve Brand Arasinda Mentiqe Uygun Relation Qurun.
CREATE TABLE Phones
(
	Id int PRIMARY KEY IDENTITY,
	Name nvarchar(100) NOT NULL,
	Price decimal(7,2) NOT NULL,
	BrandId int FOREIGN KEY REFERENCES Brands(Id)
)

--3) Notebooks Adini, Brandin Adini BrandName kimi ve Qiymetini Cixardan Query.
SELECT n.Name, b.Name BrandName, Price
FROM Notebooks n
JOIN Brands b ON BrandId = b.Id

--4) Phones Adini, Brandin Adini BrandName kimi ve Qiymetini Cixardan Query.
SELECT p.Name, b.Name BrandName, Price
FROM Phones p
JOIN Brands b ON BrandId = b.Id

--5) Brand Adinin Terkibinde s Olan Butun Notebooklari Cixardan Query.
SELECT n.Id, n.Name, b.Name BrandName, Price
FROM Notebooks n
JOIN Brands b ON BrandId = b.Id
WHERE b.Name LIKE '%s%'

--6) Qiymeti 2000 ve 5000 arasi ve ya 5000 den yuksek Notebooklari Cixardan Query.
SELECT n.Name, b.Name BrandName, Price
FROM Notebooks n
JOIN Brands b ON BrandId = b.Id
WHERE Price BETWEEN 2000 AND 5000
	OR Price > 5000

--7) Qiymeti 1000 ve 1500 arasi ve ya 1500 den yuksek Phonelari Cixardan Query.
SELECT p.Name, b.Name BrandName, Price
FROM Phones p
JOIN Brands b ON BrandId = b.Id
WHERE Price BETWEEN 1000 AND 1500
	OR Price > 1500

--8) Her Branda Aid Nece dene Notebook Varsa Brandin Adini Ve Yaninda Sayini Cixardan Query.
SELECT b.Name, COUNT(*) ProductCount
FROM Brands b
JOIN Notebooks ON b.Id = BrandId
GROUP BY b.Name

--9) Her Branda Aid Nece dene Phone Varsa Brandin Adini Ve Yaninda Sayini Cixardan Query.
SELECT b.Name, COUNT(*) ProductCount
FROM Brands b
JOIN Phones ON b.Id = BrandId
GROUP BY b.Name

--10) Hem Phone, Hem de Notebookda Ortaq Olan Name ve BrandId Datalarini Bir Cedvelde Cixardan Query.
SELECT Name, BrandId FROM Notebooks
INTERSECT
SELECT Name, BrandId FROM Phones

--11) Phone ve Notebook da Id, Name, Price, ve BrandId Olan Butun Datalari Cixardan Query.
SELECT Id, Name, Price, BrandId FROM Notebooks
UNION ALL
SELECT Id, Name, Price, BrandId FROM Phones

--12) Phone ve Notebook da Id, Name, Price, ve Brandin Adini BrandName kimi Olan Butun Datalari Cixardan Query.
SELECT n.Id, n.Name, Price, b.Name BrandName
FROM Notebooks n JOIN Brands b ON BrandId = b.Id
UNION ALL
SELECT p.Id, p.Name, Price, b.Name BrandName
FROM Phones p JOIN Brands b ON BrandId = b.Id

--13) Phone ve Notebook da Id, Name, Price, ve Brandin Adini BrandName kimi Olan Butun Datalarin Icinden Price 1000-den Boyuk Olan Datalari Cixardan Query.
SELECT n.Id, n.Name, Price, b.Name BrandName
FROM Notebooks n JOIN Brands b ON BrandId = b.Id
WHERE Price > 1000
UNION ALL
SELECT p.Id, p.Name, Price, b.Name BrandName
FROM Phones p JOIN Brands b ON BrandId = b.Id
WHERE Price > 1000

--14) Phones Tablenden Data Cixardacaqsiniz Amma Nece Olacaq: BrandName, TotalPrice Kimi, ProductCount
SELECT
	b.Name AS [BrandName],
	SUM(Price) AS [TotalPrice],
	COUNT(*) AS [ProductCount]
FROM Phones
JOIN Brands b
ON BrandId = b.Id
GROUP BY b.Name

--15) Notebooks Tablenden Data Cixardacaqsiniz Amma Nece Olacaq: BrandName, TotalPrice Kimi, ProductCount ve Sayi 3-ve 3-den Cox Olan Datalari Cixardin
SELECT
	b.Name AS [BrandName],
	SUM(Price) AS [TotalPrice],
	COUNT(*) AS [ProductCount]
FROM Notebooks
JOIN Brands b
ON BrandId = b.Id
GROUP BY b.Name
HAVING COUNT(*) >= 3