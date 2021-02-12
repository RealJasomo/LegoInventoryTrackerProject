USE [LegoInventoryTracker]
GO

/****** Object:  StoredProcedure [dbo].[insert_WantsSet]    Script Date: 2/11/2021 11:32:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[insert_WantsSet]
(
	@Username dbo.Username,
	@LegoSet varchar(20),
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
-- Ensure the @@LegoSet is not NULL
IF @LegoSet IS NULL
BEGIN
	RAISERROR('The @LegoSet is null. It must not be null', 14, 1);
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
-- Ensure a set with ID @LegoSetID exists in the LegoSet table
IF (SELECT Count(ID) FROM [LegoSet] WHERE ID = @LegoSet) = 0
BEGIN
	RAISERROR('A set with the ID @SetBrick does not exist in the LegoSet table', 14, 1);
	RETURN 6;
END
-- Ensure an entry with Username @Username and LegoBrick @LegoBrick does not exist in the table
IF (SELECT Count(Username) FROM [WantsSet] WHERE Username = @Username AND LegoSet = @LegoSet) <> 0
BEGIN
	RAISERROR('An entry with Username @Username and LegoSet @LegoSet already exists in the table', 14, 1);
	RETURN 7;
END
----- End Validate Parameters -----

----- Table Manipulation -----
-- Inserts the requested data into the LegoBrick table
INSERT INTO [WantsSet]
([Username], [LegoSet], [Quantity])
VALUES ( @Username, @LegoSet, @Quantity)
----- End Table Manipulation -----
RETURN 0;
GO

