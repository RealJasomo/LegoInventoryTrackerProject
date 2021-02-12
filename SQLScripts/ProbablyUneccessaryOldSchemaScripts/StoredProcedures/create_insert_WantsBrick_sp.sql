USE [LegoInventoryTracker]
GO

/****** Object:  StoredProcedure [dbo].[insert_WantsBrick]    Script Date: 2/11/2021 11:32:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-----------------------
--
-- Inserts a row into the WantsBrick table with values as selected
--
-----------------------
-- Demo:
-- 
-- DECLARE @Status SMALLINT
-- EXEC @Status = [insert_WantsBrick] @Username = validationUser, @LegoBrick = '1234567/8900', @Quantity = 10
-- SELECT Status = @Status
-- 
-----------------------
-- Revision History
-- Created - 1/19/2021 - Luke Ferderer

CREATE PROCEDURE [dbo].[insert_WantsBrick]
(
	@Username dbo.Username,
	@LegoBrick dbo.BrickID,
	@Quantity int
)
AS
----- Validate Parameters -----
-- Ensure the @Username is not NULL
IF @Username IS NULL
BEGIN
	RAISERROR('The @Username is null. It must not be null', 14, 1);
	RETURN 1;
END
-- Ensure the @LegoBrick is not NULL
IF @LegoBrick IS NULL
BEGIN
	RAISERROR('The @LegoBrick is null. It must not be null', 14, 1);
	RETURN 2;
END
-- Ensure the @Quantity is not NULL or negative
IF @Quantity IS NULL OR @Quantity < 0
BEGIN
	RAISERROR('The @Quantity is null or less than 0. It must not be null or less than 0', 14, 1);
	RETURN 3;
END
-- Ensure a user with Username @Username does exist in the User table
IF (SELECT Count(Username) FROM [User] WHERE Username = @Username) = 0
BEGIN
	RAISERROR('A user with the username @Username does not exist in the User table', 14, 1);
	RETURN 5;
END
-- Ensure a brick with ID @LegoBrickID exists in the LegoBrick table
IF (SELECT Count(ID) FROM [LegoBrick] WHERE ID = @LegoBrick) = 0
BEGIN
	RAISERROR('A brick with the ID @LegoBrick does not exist in the LegoBrick table', 14, 1);
	RETURN 6;
END
-- Ensure an entry with Username @Username and LegoBrick @LegoBrick does not exist in the table
IF (SELECT Count(Username) FROM [WantsBrick] WHERE Username = @Username AND LegoBrick = @LegoBrick) <> 0
BEGIN
	RAISERROR('An entry with Username @Username and LegoBrick @LegoBrick already exists in the table', 14, 1);
	RETURN 7;
END
----- End Validate Parameters -----

----- Table Manipulation -----
-- Inserts the requested data into the LegoBrick table
INSERT INTO [WantsBrick]
([Username], [LegoBrick], [Quantity])
VALUES ( @Username, @LegoBrick, @Quantity)
----- End Table Manipulation -----
RETURN 0;
GO

