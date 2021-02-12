USE [LegoInventoryTracker]
GO

/****** Object:  StoredProcedure [dbo].[insert_Contains]    Script Date: 2/11/2021 11:30:36 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-----------------------
--
-- Inserts a row into the Contains table with values as selected
--
-----------------------
-- Demo:
-- 
-- DECLARE @Status SMALLINT
-- EXEC @Status = [insert_Contains] @SetID = '11111', @LegoBrick = '1234567/8900', @Quantity = 10
-- SELECT Status = @Status
-- 
-----------------------
-- Revision History
-- Created - 2/5/2021 - Luke Ferderer

CREATE PROCEDURE [dbo].[insert_Contains]
(
	@SetID varchar(20),
	@LegoBrick dbo.BrickID,
	@Quantity int
)
AS
----- Validate Parameters -----
-- Ensure the @SetID is not NULL
IF @SetID IS NULL
BEGIN
	RAISERROR('The @Set is null. It must not be null', 14, 1);
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
-- Ensure a set with ID @SetID does exist in the LegoSet table
IF (SELECT Count(ID) FROM [LegoSet] WHERE ID = @SetID) = 0
BEGIN
	RAISERROR('A set with the ID @SetID does not exist in the LegoSet table', 14, 1);
	RETURN 4;
END
-- Ensure a brick with ID @LegoBrickID exists in the LegoBrick table
IF (SELECT Count(ID) FROM [LegoBrick] WHERE ID = @LegoBrick) = 0
BEGIN
	RAISERROR('A brick with the ID @LegoBrick does not exist in the LegoBrick table', 14, 1);
	RETURN 5;
END
-- Ensure an entry with Username @Username and LegoBrick @LegoBrick does not exist in the table
IF (SELECT Count(LegoSet) FROM [Contains] WHERE LegoSet = @SetID AND LegoBrick = @LegoBrick) <> 0
BEGIN
	RAISERROR('An entry with SetID @SetID and LegoBrick @LegoBrick already exists in the table', 14, 1);
	RETURN 6;
END
----- End Validate Parameters -----

----- Table Manipulation -----
-- Inserts the requested data into the LegoBrick table
INSERT INTO [Contains]
([LegoSet], [LegoBrick], [Quantity])
VALUES ( @SetID, @LegoBrick, @Quantity)
----- End Table Manipulation -----
RETURN 0;
GO

