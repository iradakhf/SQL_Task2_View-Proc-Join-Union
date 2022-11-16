Create Database TechStoreDb

Use TechStoreDb

Create Table Brands
(
 Id int identity primary key,
 Name nvarchar(255)

)

-----Notebook ve Brand Arasinda Mentiqe Uygun Relation Qurun.----
Create Table NoteBooks
(
Id int identity primary key,
Name nvarchar(255) not null,
Price money,
BrandId int foreign key references Brands(Id)
)

-----Phones ve Brand Arasinda Mentiqe Uygun Relation Qurun.--------
Create Table Phones
(
Id int identity primary key,
Name nvarchar(255) not null,
Price money,
BrandId int foreign key references Brands(Id)

)


INSERT INTO Brands
VALUES
('Apple'),
('Hp'),
('Samsung'),
('Xiaomi'),
('Huawei'),
('Asus'),
('Dell')



INSERT INTO Notebooks
VALUES
('250 G5', 943, 2),
('250 G6', 1158, 2),
('250 G7', 1251, 2),
('Air', 2363, 1),
('Pro 13', 2975, 1),
('Pro 15', 3439, 1),
('ROG', 2928, 6),
('ROG PRO', 3968, 6),
('VIVOBOOK 15', 1536, 6),
('VIVOBOOK 14', 1325, 6),
('Mate X', 1600, 5),
('Mate X PRO', 1900, 5),
('Mate XL PRO', 1864, 5),
('Mate XXL PRO', 1253, 5),
('Mi Notebook Air', 1753, 4),
('Mi Notebook Pro', 2153, 4),
('Lustrous Grey', 4681, 4),
('Galaxy Book', 1874, 3),
('Galaxy Book PRO', 3274, 3),
('Galaxy Book AIR', 2574, 3),
('Galaxy Book AIR PRO', 3367, 3)



INSERT INTO Phones
VALUES
('13', 2463, 1),
('13 Pro', 3075, 1),
('13 Pro Max', 3339, 1),
('Mate Pad', 1600, 5),
('Mate Xs', 1900, 5),
('Nova 9 SE', 1864, 5),
('P50E', 1853, 5),	
('Poco 5', 1753, 4),
('Poco 4', 2153, 4),
('Poco 6', 4681, 4),
('A11', 275, 3),
('A21', 285, 3),
('A31', 374, 3),
('A41', 467, 3),
('A51', 567, 3),
('A61', 667, 3),
('A71', 767, 3),
('A81', 867, 3),
('A91', 967, 3)


----Notebooks Adini, Brandin Adini BrandName kimi ve Qiymetini Cixardan Query.---

Select n.Name, n.Price, b.Name 'Brand Name' From NoteBooks n
Join Brands b on n.BrandId=b.Id


-----------Phones Adini, Brandin Adini BrandName kimi ve Qiymetini Cixardan Query.---

Select p.Name, p.Price, b.Name 'Brand Name' From Phones p
Join Brands b on p.BrandId=b.Id

---Brand Adinin Terkibinde s Olan Butun Notebooklari Cixardan Query.--
Select NoteBooks.Name 'Notebook Name' From NoteBooks
JoiN Brands on NoteBooks.BrandId=Brands.Id where Brands.Name like '%s%'

-----2nd-----with brand name----
Select NoteBooks.Name 'Notebook Name', Brands.Name 'Brand Name' From NoteBooks
JoiN Brands on NoteBooks.BrandId=Brands.Id where Brands.Name like '%s%'

----Qiymeti 2000 ve 5000 arasi ve ya 5000 den yuksek Notebooklari Cixardan Query.----
Select NoteBooks.Name, NoteBooks.Price From NoteBooks where Price Between 2000 and 5000 or Price>5000

----Qiymeti 1000 ve 1500 arasi ve ya 1500 den yuksek Phonelari Cixardan Query.----
Select Phones.Name, Phones.Price From Phones where Price Between 1000 and 1500 or Price>1500

----Her Branda Aid Nece dene Notebook Varsa Brandin Adini Ve Yaninda Sayini Cixardan Query.---
Select Brands.Name 'Brand Name', Count(*) 'NoteBook Count' From Brands
Join Notebooks on Brands.Id = NoteBooks.BrandId group by Brands.Name

----Her Branda Aid Nece dene Phone Varsa Brandin Adini Ve Yaninda Sayini Cixardan Query.----
Select Brands.Name 'Brand Name', Count(*) 'Phone Count' From Brands
Join Phones on Brands.Id = Phones.BrandId group by Brands.Name

--Hem Phone Hem de Notebookda Ortaq Olan Name ve BrandId Datalarni Bir Cedvelde Cixardan Query.--
Select Name,BrandId From NoteBooks 
Union 
Select Name, BrandId from Phones 



------Phone ve Notebook da Id, Name, Price, ve BrandId Olan Butun Datalari Cixardan Query.---
  Select * from NoteBooks 
  Union all
  Select * from Phones 

  ------Phone ve Notebook da Id, Name, Price, ve Brandin Adini BrandName kimi Olan Butun Datalari Cixardan Query.----
  
  Select n.Id, n.Name, n.Price, b.Name 'BrandName' from NoteBooks n
  join Brands b on n.BrandId = b.Id
  Union
  Select p.Id, p.Name, p.Price, b.Name 'BrandName' from Phones p
  join Brands b on p.BrandId = b.Id




------Phone ve Notebook da Id, Name, Price, ve Brandin Adini BrandName----
---kimi Olan Butun Datalarin Icinden Price 1000-den Boyuk Olan Datalari Cixardan Query.----

Select * from 
(
  Select n.Id, n.Name, n.Price, b.Name 'BrandName' from NoteBooks n
  join Brands b on n.BrandId = b.Id
  Union
  Select p.Id, p.Name, p.Price, b.Name 'BrandName' from Phones p
  join Brands b on p.BrandId = b.Id

) UforNotbooksAndPhones where Price>1000



---14) Phones Tabelenden Data Cixardacaqsiniz Amma Nece Olacaq Brandin Adi 
---(BrandName kimi), Hemin Brandda Olan Telefonlarin Pricenin Cemi (TotalPrice Kimi) 
---ve Hemin Branda Nece dene Telefon Varsa Sayini (ProductCount Kimi) Olan Datalari Cixardan Query.Misal
--BrandName:        TotalPrice:        ProductCount:
--Apple               6750                    3
--Samsung            3500                     4
--Redmi              800                      1

Select Brands.Name 'BrandName', Sum(p.Price) 'TotalPrice', Count(*) 'ProductCount' from Phones p
join Brands on p.BrandId=Brands.Id
Group By Brands.Name


-----15) Notebooks Tabelenden Data Cixardacaqsiniz Amma Nece Olacaq Brandin Adi 
---(BrandName kimi), Hemin Brandda Olan notebooks Pricenin Cemi (TotalPrice Kimi) ,
---Hemin Branda Nece dene notebook Varsa Sayini (ProductCount Kimi) Olacaq ve 
---Sayi 3-ve 3-den Cox Olan Datalari Cixardan Query.Misal
---BrandName:        TotalPrice:        ProductCount:
---Apple                    6750                3
---Samsung                  3500                4

Select Brands.Name 'BrandName', Sum(n.Price) 'TotalPrice', Count(*) 'ProductCount' from NoteBooks n
join Brands on n.BrandId=Brands.Id
Group By Brands.Name having
(
 Select Count(*) 'ProductCount' from NoteBooks n

)>=3


----Kitabxana database-i qurursunuz---
Create Database Kitabxana

use Kitabxana


---Books (Id, Name, PageCount)--
---Books-un Name columu minimum 2 simvol maksimum 100 simvol deyer ala bileceyi serti olsun.--
---Books-un PageCount columu minimum 10 deyerini ala bileceyi serti olsun.----

----Authors (Id, Name, Surname)--
Create Table Authors
(
Id int identity primary key,
Name nvarchar(100) Check(Len(Name)>=2),
Surname nvarchar(300)

)

Create Table Books
(
Id int identity primary key,
Name nvarchar(100) Check(Len(Name)>=2),
PageCount int Check(PageCount>=10),
AuthorId int foreign key references Authors(Id)
)


----Books ve Authors table-larinizin mentiqi uygun elaqesi olsun.--

---Id, Name, PageCount ve AuthorFullName columnlarinin valuelarini qaytaran bir view yaradin---
Create View usv_BooksWithAuthors
As
Select 
b.Id, 
b.Name 'Book Name', 
b.PageCount 'Page Count',
a.Name+ ' ' + a.Surname 'AuthorFullName' 
from 
Books b
Join Authors a on b.AuthorId = a.Id

---Gonderilmis axtaris deyirene gore hemin axtaris deyeri name ve ya authorFullNamelerinde----
---olan Book-lari Id, Name, PageCount, AuthorFullName columnlari seklinde gostern procedure yazin----
Create Procedure usp_GetBookNameOrItsAuthorFullName @name nvarchar(100), @authorFullName nvarchar(300)
As
Select 
b.Id, 
b.Name 'Book Name', 
b.PageCount 'Page Count',
(a.Name+ ' ' + a.Surname) 'AuthorFullName' 
from 
Books b
Join Authors a on b.AuthorId = a.Id
where b.Name= @name or (a.Name + ' '+ a.Surname) = @authorFullName

exec usp_GetBookNameOrItsAuthorFullName 'book-1', 'jijio'


---Authors tableinin insert, update ve deleti ucun (her biri ucun ayrica) procedure yaradin--
Create Table AuthorsArchieve
(
Id int not null,
Name nvarchar(100),
Surname nvarchar(100),
Status nvarchar(100),
Date datetime2
)

Create Trigger AuthorInsertedDataCopy
on Authors
after insert
as
begin

   declare @Id int
   declare @Name nvarchar(100)
   declare @Surname nvarchar(100)
   declare @Status nvarchar(100)
   declare @Date datetime2

   Select  @Id=Id from inserted
   Select  @Name=Name from inserted
   Select  @Surname=Surname from inserted
   Select  @Status='Inserted' from inserted
   Select  @Date=GETDATE() from inserted


   Insert into AuthorsArchieve(Id,Name,Surname,Status, Date)
   values
   (@Id, @Name, @Surname, @Status , @Date)
end
----Deleted--
Create Trigger AuthorDeletedDataCopy
on Authors
after delete
as
begin

   declare @Id int
   declare @Name nvarchar(100)
   declare @Surname nvarchar(100)
   declare @Status nvarchar(100)
   declare @Date datetime2

   Select  @Id=Id from deleted
   Select  @Name=Name from deleted
   Select  @Surname=Surname from deleted
   Select  @Status='Deleted' from deleted
   Select  @Date=GETDATE() from deleted

    Delete from AuthorsArchieve
  where
  Id=@Id AND Name=@Name AND Surname=@Surname
  
   Insert into AuthorsArchieve(Id,Name,Surname,Status, Date)
   values
   (@Id, @Name, @Surname, @Status , @Date)
end




----update--------
--Create Trigger AuthorUpdatedDataCopy
--on Authors
--after update
--AS
--begin

--  declare @IdU int,
-- @NameU nvarchar(100),
-- @SurnameU nvarchar(100),
--   @StatusU nvarchar(100),
--    @DateU datetime2

--   Select  @IdU=Id from inserted
--   Select  @NameU=Name from inserted
--   Select  @SurnameU=Surname from inserted
--   Select  @StatusU='Updated' from inserted
--   Select  @DateU=GETDATE() from inserted
   

--   end


---Authors-lari Id,FullName,BooksCount,MaxPageCount seklinde qaytaran view yaradirsiniz
--Id-author id-si, FullName - Name ve Surname birlesmesi, 
--BooksCount - Hemin authorun elaqeli oldugu kitablarin sayi,
---MaxPageCount - hemin authorun elaqeli oldugu kitablarin icerisindeki max pagecount deyeri


Select a.FullName, test2.BooksCount 'Book Count', test2.MaxPageCount 'Max Page Count'
from
(Select aut.Id, aut.Name +' '+ aut.Surname 'FullName' from Authors aut
) a
join 
(Select b.AuthorId, Count(*) 'BooksCount', MAX(b.PageCount) 'MaxPageCount' From Books b
Join Authors a on a.Id = b.AuthorId
Group By b.AuthorId ) test2 on test2.AuthorId= a.Id

