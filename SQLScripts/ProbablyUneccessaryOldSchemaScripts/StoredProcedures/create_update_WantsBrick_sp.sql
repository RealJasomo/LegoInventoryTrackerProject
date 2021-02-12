USE [LegoInventoryTracker]
GO

/****** Object:  StoredProcedure [dbo].[update_WantsBrick]    Script Date: 2/11/2021 11:34:29 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-----------------------
--
-- Upates the values of an entry in the WantsBrick table using its Username and LegoBrick values to select which row.
-- Quantity can be updated.
--
-----------------------
-- Demo:
-- 
-- DECLARE @Status SMALLINT
-- EXEC @Status = [update_WantsBrick]  @Username = validationUser, @LegoBrick = '1234567/8900', @Quantity = 15
-- SELECT Status = @Status
-- 
-----------------------
-- Revision History
-- Created - 1/19/2021 - Luke Ferderer

CREATE PROCEDURE [dbo].[update_WantsBrick]
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
-- Ensure the @Quantity is not negative
IF @Quantity IS NULL OR @Quantity < 0
BEGIN
	RAISERROR('The @Quantity is null or less than 0. It must not be null or less than 0', 14, 1);
	RETURN 3;
END
-- Ensure an entry with Username @Username and LegoBrick @LegoBrick exists in the table
IF (SELECT Count(Username) FROM [WantsBrick] WHERE Username = @Username AND LegoBrick = @LegoBrick) = 0
BEGIN
	RAISERROR('An entry with Username @Username and LegoBrick @LegoBrick does not exist in the table', 14, 1);
	RETURN 5;
END
----- End Validate Parameters -----

----- Table Manipulation -----
-- Update Order Detail values
UPDATE [WantsBrick]
SET [Quantity] = @Quantity
WHERE (Username = @Username AND LegoBrick = @LegoBrick)
----- End Table Manipulation -----

Return 0;
GO

