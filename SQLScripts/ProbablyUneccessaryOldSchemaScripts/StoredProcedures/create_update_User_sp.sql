USE [LegoInventoryTracker]
GO

/****** Object:  StoredProcedure [dbo].[update_User]    Script Date: 2/11/2021 11:34:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-----------------------
--
-- Upates the values of an entry in the User table using its Username value to select which row.
-- Password can be updated.
--
-----------------------
-- Demo:
-- 
-- DECLARE @Status SMALLINT
-- EXEC @Status = [insert_User] @Username = ferderl1, @Password = V3ryS3cur3Pa22w0rd
-- SELECT Status = @Status
-- 
-----------------------
-- Revision History
-- Created - 1/19/2021 - Luke Ferderer
-- Reoved FirstName and LastName - 1/22/2021 - Luke Ferderer

CREATE PROCEDURE [dbo].[update_User]
(
	@Username dbo.Username,
	@Password nvarchar(70)
)
AS
----- Validate Parameters -----
-- Ensure the @Username is not NULL
IF @Username IS NULL
BEGIN
	RAISERROR('The @Username is null. It must not be null', 14, 1);
	RETURN 1;
END
-- Ensure the @Password is not NULL
IF @Password IS NULL
BEGIN
	RAISERROR('The @Password is null. It must not be null', 14, 1);
	RETURN 2;
END
-- Ensure there exists an entry in the User table which has a Username of @Username
IF (SELECT Count(Username) FROM [User] WHERE Username = @Username) = 0
BEGIN
	RAISERROR('A user with Username @Username does not exist in User table', 14, 1);
	RETURN 3;
END
----- End Validate Parameters -----

----- Optional Parameter Checks -----
-- If @Password is NULL, set it to the Password value currently in the table for the user with Username @Username
IF (@Password IS NULL)
BEGIN
	SET @Password = (SELECT Password FROM [User] WHERE Username = @Username)
END
----- End Optional Parameter Checks -----

----- Table Manipulation -----
-- Update User values
UPDATE [User]
SET [Password] = @Password
WHERE ( [Username] = @Username)
----- End Table Manipulation -----

Return 0;
GO

