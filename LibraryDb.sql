CREATE DATABASE LibraryDb
USE LibraryDb

CREATE TABLE Authors
(
	Id int PRIMARY KEY IDENTITY,
	Name nvarchar(50) NOT NULL,
	Surname nvarchar(50)
)

CREATE TABLE Books
(
	Id int PRIMARY KEY IDENTITY,
	Name nvarchar(100) NOT NULL CHECK(LEN(Name) >= 2),
	PageCount smallint NOT NULL CHECK(PageCount >= 10),
	AuthorId int FOREIGN KEY REFERENCES Authors(Id)
)

--Id, Name, PageCount ve AuthorFullName columnlarinin valuelarini qaytaran bir view yaradin
CREATE VIEW usv_GetAllBookData AS
SELECT b.Id, b.Name, PageCount, (a.Name + ' ' + Surname) 'AuthorFullName'
FROM Books b
JOIN Authors a
ON b.AuthorId = a.Id

--Gonderilmis axtaris deyerene gore hemin axtaris deyeri name ve ya authorFullNamelerinde olan
--Book-lari Id, Name, PageCount, AuthorFullName columnlari seklinde gostern procedure yazin
CREATE PROCEDURE usp_GetBooksByAuthorOrTitle
@name nvarchar(100)
AS
BEGIN
	SELECT * FROM usv_GetAllBookData
	WHERE AuthorFullName = @name OR Name = @name
END

--Authors tableinin insert ucun procedure yaradin
CREATE PROCEDURE usp_InsertIntoAuthors (@name nvarchar(50), @surname nvarchar(50))
AS
BEGIN
	INSERT INTO Authors(Name, Surname) VALUES(@name, @surname)
END

--Authors tableinin update ucun procedure yaradin
CREATE PROCEDURE usp_UpdateAuthors (@id int, @name nvarchar(50), @surname nvarchar(50))
AS
BEGIN
	UPDATE Authors
	SET Name = @name, Surname = @surname
	WHERE Id = @id
END

--Authors tableinin delete ucun procedure yaradin
CREATE PROCEDURE usp_DeleteFromAuthors (@id int)
AS
BEGIN
	DELETE FROM Authors WHERE Id = @id
END

--Authors-lari Id, FullName, BooksCount, MaxPageCount seklinde qaytaran view yaradirsiniz
CREATE VIEW usv_GetAllAuthorData AS
SELECT a.Id, (a.Name + ' ' + Surname) 'FullName', COUNT(*) 'BooksCount', MAX(PageCount) 'MaxPageCount' FROM Authors a
JOIN Books b
ON b.AuthorId = a.Id
GROUP BY a.Id, a.Name, Surname