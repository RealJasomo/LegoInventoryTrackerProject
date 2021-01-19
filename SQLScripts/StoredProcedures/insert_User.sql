USE LegoInventoryTracker
GO

-----------------------
--
-- Inserts a row into the Users table with values as selected
-- FirstName and LastName are optional.
--
-----------------------
-- Demo:
-- 
-- DECLARE @Status SMALLINT
-- EXEC @Status = [insert_User] @Username = ferderl1, @Password = V3ryS3cur3Pa22w0rd, @FirstName = Luke, @LastName = Ferderer
-- SELECT Status = @Status
-- 
-----------------------
-- Revision History
-- Created - 1/19/2021 - Luke Ferderer

ALTER PROCEDURE [insert_User]
(
	@Username dbo.Username,
	@Password nvarchar(30),
	@FirstName nvarchar(30) = NULL,
	@LastName nvarchar(30) = NULL
)
AS
----- Validate Parameters -----
-- Ensure the @Username is not NULL
IF @Username IS NULL
BEGIN
	RAISERROR('The @Username is null. It must not be null', 14, 1);
	RETURN 1;
END
-- Ensure a user with Username @Username does not exist in the table
IF (SELECT Count(Username) FROM [User] WHERE Username = @Username) <> 0
BEGIN
	RAISERROR('A user with the Username @Username already exists in the User table', 14, 1);
	RETURN 2;
END
-- Ensure the @Password is not NULL
IF @Password IS NULL
BEGIN
	RAISERROR('The @Password is null. It must not be null', 14, 1);
	RETURN 3;
END
----- End Validate Parameters -----

----- Table Manipulation -----
-- Inserts the requested data into the User table
INSERT INTO [User]
( [Username], [Password], [FirstName], [LastName])
VALUES ( @Username, @Password, @FirstName, @LastName)
----- End Table Manipulation -----
RETURN 0;