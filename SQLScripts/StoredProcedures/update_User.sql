USE LegoInventoryTracker
GO

-----------------------
--
-- Upates the values of an entry in the User table using its Username value to select which row.
-- Password, FirstName, and Lastname can all be updated and all are optional.
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

ALTER PROCEDURE [update_User]
(
	@Username dbo.Username,
	@Password nvarchar(70) = NULL,
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
-- Ensure there exists an entry in the User table which has a Username of @Username
IF (SELECT Count(Username) FROM [User] WHERE Username = @Username) = 0
BEGIN
	RAISERROR('A user with Username @Username does not exist in User table', 14, 1);
	RETURN 2;
END
----- End Validate Parameters -----

----- Optional Parameter Checks -----
-- If @Password is NULL, set it to the Password value currently in the table for the user with Username @Username
IF (@Password IS NULL)
BEGIN
	SET @Password = (SELECT Password FROM [User] WHERE Username = @Username)
END
-- If @FirstName is NULL, set it to the FirstName value currently in the table for the user with Username @Username
IF (@Password IS NULL)
BEGIN
	SET @FirstName = (SELECT FirstName FROM [User] WHERE Username = @Username)
END
-- If @LastName is NULL, set it to the LastName value currently in the table for the user with Username @Username
IF (@Password IS NULL)
BEGIN
	SET @LastName = (SELECT [LastName] FROM [User] WHERE Username = @Username)
END
----- End Optional Parameter Checks -----

----- Table Manipulation -----
-- Update User values
UPDATE [User]
SET [Password] = @Password, [FirstName] = @FirstName, [LastName] = @LastName
WHERE ( [Username] = @Username)
----- End Table Manipulation -----

Return 0;