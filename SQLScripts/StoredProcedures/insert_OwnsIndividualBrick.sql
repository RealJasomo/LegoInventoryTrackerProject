USE LegoInventoryTracker
GO

-----------------------
--
-- Inserts a row into the OwnsIndividualBrick table with values as selected
--
-----------------------
-- Demo:
-- 
-- DECLARE @Status SMALLINT
-- EXEC @Status = [insert_OwnsIndividualBrick] @Username = validationUser, @LegoBrick = '1234567/8900', @Quantity = 10, @QuantityInUse = 5
-- SELECT Status = @Status
-- 
-----------------------
-- Revision History
-- Created - 1/19/2021 - Luke Ferderer

ALTER PROCEDURE [insert_OwnsIndividualBrick]
(
	@Username dbo.Username,
	@LegoBrick dbo.BrickID,
	@Quantity int,
	@QuantityInUse int
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
-- Ensure the @QuantityInUse is not NULL or negative
IF @QuantityInUse IS NULL OR @QuantityInUse < 0
BEGIN
	RAISERROR('The @QuantityInUse is null or less than 0. It must not be null or less than 0', 14, 1);
	RETURN 4;
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
IF (SELECT Count(Username) FROM [OwnsIndividualBrick] WHERE Username = @Username AND LegoBrick = @LegoBrick) <> 0
BEGIN
	RAISERROR('An entry with Username @Username and LegoBrick @LegoBrick already exists in the table', 14, 1);
	RETURN 7;
END
-- Ensure QuantityInUse is less or equal to Quantity
IF (@QuantityInUse > @Quantity)
BEGIN
	RAISERROR('@QuantityInUse is > @Quantity. This must not be the case', 14, 1);
	RETURN 8;
END
----- End Validate Parameters -----

----- Table Manipulation -----
-- Inserts the requested data into the LegoBrick table
INSERT INTO [OwnsIndividualBrick]
([Username], [LegoBrick], [Quantity], [QuantityInUse])
VALUES ( @Username, @LegoBrick, @Quantity, @QuantityInUse)
----- End Table Manipulation -----
RETURN 0;