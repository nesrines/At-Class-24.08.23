CREATE DATABASE ElectronicsDb
USE ElectronicsDb

CREATE TABLE Brands
(
	Id int PRIMARY KEY IDENTITY,
	Name nvarchar(50) NOT NULL
)

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
SELECT n.Name, b.Name 'BrandName', Price
FROM Notebooks n
JOIN Brands b ON b.Id = n.BrandId

--4) Phones Adini, Brandin Adini BrandName kimi ve Qiymetini Cixardan Query.
SELECT p.Name, b.Name 'BrandName', Price
FROM Phones p
JOIN Brands b ON b.Id = p.BrandId

--5) Brand Adinin Terkibinde s Olan Butun Notebooklari Cixardan Query.
SELECT * FROM Notebooks