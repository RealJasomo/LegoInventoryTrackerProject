USE [LegoInventoryTracker]
GO

/****** Object:  StoredProcedure [dbo].[login_User]    Script Date: 2/11/2021 11:32:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-----------------------
--
-- Gets hashed password from User with username
--
-----------------------
-- Demo:
-- 
-- DECLARE @Status SMALLINT
-- EXEC @Status = [insert_User] @Username = ferderl1
-- SELECT Status = @Status
-- 
-----------------------
-- Revision History
-- Created - 1/26/2021 - Jason Cramer

CREATE PROCEDURE [dbo].[login_User]
(
	@Username dbo.Username
)
AS
----- Validate Parameters -----
-- Ensure the @Username is not NULL
IF @Username IS NULL
BEGIN
	RAISERROR('The @Username is null. It must not be null', 14, 1);
	RETURN 1;
END
-- Ensure a user with Username @Username does exist in the table
IF (SELECT Count(Username) FROM [User] WHERE Username = @Username) = 0
BEGIN
	RAISERROR('User does not exists in the User table', 14, 1);
	RETURN 2;
END
----- End Validate Parameters -----

----- Table Manipulation -----
-- Inserts the requested data into the User table
declare @hash_pass as NVARCHAR(70);
SELECT @hash_pass=Password from [User]
WHERE Username = @Username
----- End Table Manipulation -----
SELECT @hash_pass as [hashpassword];
GO

