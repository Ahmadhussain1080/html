
------------------------------------Table for Books----------------------------------------

Create Table Books (
	BookName varchar(255),
	Price Int,
	Category varchar(255),
	ShelfNumber varchar(5),
	BookID varchar(5),
	BookAvailability varchar(100),
	Primary Key (BookID)
);

------------------------------------Table for Users----------------------------------------

Create Table Users (
	UserName varchar(50),
	UserID varchar(5)
	Primary Key (UserID)
);

------------------------------------Table for BooksIssued----------------------------------------

Create Table BooksIssued (
	BookID varchar(5),
	UserID varchar(5),
	Primary Key (BookID),
	Foreign Key (UserID) References Users(UserID) On Delete Cascade,
	Foreign Key (BookID) References Books(BookID) On Delete Cascade
);

------------------------------------Sample Data for Books----------------------------------------

Insert Into Books Values ('The Witcher', 15, 'Fantasy Novel', '22A', '1', 'Available');
Insert Into Books Values ('Sword of Destiny', 25, 'Fantasy Novel', '82C', '2', 'Available');
Insert Into Books Values ('The Last Wish', 20, 'Fantasy Novel', '90N', '3', 'Available');
Insert Into Books Values ('Blood of Elves', 25, 'Fantasy Novel', '20V', '4', 'Available');
Select * From Books;

------------------------------------Sample Data for Users----------------------------------------

Insert Into Users Values ('Muhammad Hassan', '1');
Insert Into Users Values ('Adil Latif', '2');
Insert Into Users Values ('Awais Chaudry', '3');
Insert Into Users Values ('Muhammad Ibrahim', '4');
Select * From Users;

------------------------------------Sample Data for BooksIssued----------------------------------------

Insert Into BooksIssued Values ('1','1');
Insert Into BooksIssued Values ('2','1');
Insert Into BooksIssued Values ('3','4');
Insert Into BooksIssued Values ('4','3');
Select * From BooksIssued;
--Drop Table BooksIssued;
--Drop Table Users;
--Drop Table Books;
--drop procedure GetBook;
--drop procedure GetBooks;
--drop procedure GetUser;
--drop procedure IssueBook;
--drop procedure DeleteBook;
--drop procedure DeleteUser;
--Drop Procedure AddUser;

------------------------------------Fetching All Books Names----------------------------------------

Go;
Create Procedure GetBooks
As
Select BookName From Books
Go;
Exec GetBooks;

------------------------------------Fetching Book Data by Name or BookID----------------------------------------

Go;
CREATE PROCEDURE GetBook
	@Input varchar(255)
As
Select * From Books
Where BookName = @Input or BookID = @Input
Go;
Exec GetBook @Input = 'The Witcher';

------------------------------------Fetching User Data by Name or UserID----------------------------------------



GO;
CREATE PROCEDURE GetUser
	@Bookinput varchar(255)
As
SELECT Users.UserName, BooksIssued.BookID FROM Users
INNER JOIN BooksIssued ON BooksIssued.UserID = Users.UserID
Where Users.UserName = @Bookinput or Users.UserID = @Bookinput
Go;
EXEC GetUser @Bookinput = '1';

------------------------------------Issue Book----------------------------------------

GO;
CREATE PROCEDURE IssueBook
	@UserID VARCHAR(50), @BookID VARCHAR(255)
AS
If Not Exists (Select * From BooksIssued Where BooksIssued.BookID = @BookID)
	Begin
		Insert Into BooksIssued 
		Values (@BookID,@UserID);
		Update Books
		Set BookAvailability = 'Issued'
		Where Books.BookID = @BookID;
	End;
GO;
EXEC IssueBook @UserID = '1', @BookID = '5';

------------------------------------Return Book----------------------------------------

GO;
CREATE PROCEDURE ReturnBook
	@BookInput VARCHAR(255)
AS
Delete From BooksIssued
Where BooksIssued.BookID = @BookInput;
Update Books
Set BookAvailability = 'Available'
Where Books.BookID = @BookInput or Books.BookName = @BookInput;
GO;
EXEC ReturnBook @BookInput = '5'

------------------------------------Delete Book----------------------------------------

Go;
CREATE PROCEDURE DeleteBook
	@BookInput varchar(255)
AS
Delete From Books
Where Books.BookID = @BookInput or Books.BookName = @BookInput;
Go;
EXEC DeleteBook @BookInput = '5';

------------------------------------Delete User----------------------------------------

Go;
CREATE PROCEDURE DeleteUser
	@UserInput varchar(255)
AS
If Not Exists (Select * From BooksIssued Where BooksIssued.UserID = @UserInput)
	Begin
		Delete From Users
		Where Users.UserID = @UserInput or Users.UserName = @UserInput;
	End;
Go;
EXEC DeleteUser @UserInput = '1';

------------------------------------Add User----------------------------------------

Go;
Create Procedure AddUser
	@UserName varchar(255), @UserID varchar(5)
As
Insert Into Users
Values (@UserName,@UserID);
Go;
EXEC AddUser @UserName = 'Taimoor Pal', @UserID = '4';

------------------------------------Add Book----------------------------------------

Go;
Create Procedure AddBook
	@BookName varchar(255), @Price Int, @Category varchar(255), @ShelfNumber varchar(5), @BookID varchar(5), @BookAvailability varchar(100)
As
Insert Into Books
Values (@BookName, @Price, @Category, @ShelfNumber, @BookID, @BookAvailability);
Go;
EXEC AddBook @BookName = 'Taimoor Pal', @BookID = '4';