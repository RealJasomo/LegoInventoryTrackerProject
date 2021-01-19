USE LegoInventoryTracker
GO

-----------------------
--
-- Upates the values of an entry in the OwnsIndividualBrick table using its Username and LegoBrick values to select which row.
-- Quantity and QuantityInUse can all be updated and are optional.
--
-----------------------
-- Demo:
-- 
-- DECLARE @Status SMALLINT
-- EXEC @Status = [update_OwnsIndividualBrick]  @Username = validationUser, @LegoBrick = '1234567/8900', @Quantity = 15, @QuantityInUse = 6
-- SELECT Status = @Status
-- 
-----------------------
-- Revision History
-- Created - 1/19/2021 - Luke Ferderer

ALTER PROCEDURE [update_OwnsIndividualBrick]
(
	@Username dbo.Username,
	@LegoBrick dbo.BrickID,
	@Quantity int = NULL,
	@QuantityInUse int = NULL
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
IF @Quantity IS NOT NULL AND @Quantity < 0
BEGIN
	RAISERROR('The @Quantity is less than 0. It must not be less than 0', 14, 1);
	RETURN 3;
END
-- Ensure the @QuantityInUse is not NULL
IF @QuantityInUse IS NOT NULL AND @QuantityInUse < 0
BEGIN
	RAISERROR('The @QuantityInUse is less than 0. It must not be less than 0', 14, 1);
	RETURN 4;
END
-- Ensure an entry with Username @Username and LegoBrick @LegoBrick exists in the table
IF (SELECT Count(Username) FROM [OwnsIndividualBrick] WHERE Username = @Username AND LegoBrick = @LegoBrick) = 0
BEGIN
	RAISERROR('An entry with Username @Username and LegoBrick @LegoBrick does not exist in the table', 14, 1);
	RETURN 5;
END
----- End Validate Parameters -----

----- Optional Parameter Checks -----
-- If @ImageURL is NULL, set it to the ImageURL value currently in the table for the requested entry
IF @Quantity IS NULL
BEGIN
	SET @Quantity = (SELECT Quantity FROM [OwnsIndividualBrick] WHERE Username = @Username AND LegoBrick = @LegoBrick)
END
-- If @Name is NULL, set it to the Name value currently in the table for the requested entry
IF @QuantityInUse IS NULL
BEGIN
	SET @QuantityInUse = (SELECT @QuantityInUse FROM [OwnsIndividualBrick] WHERE Username = @Username AND LegoBrick = @LegoBrick)
END
-- Ensure QuantityInUse is less or equal to Quantity
IF (@QuantityInUse > @Quantity)
BEGIN
	RAISERROR('@QuantityInUse is > @Quantity. This must not be the case', 14, 1);
	RETURN 6;
END
----- End Optional Parameter Checks -----

----- Table Manipulation -----
-- Update Order Detail values
UPDATE [OwnsIndividualBrick]
SET [Quantity] = @Quantity, [QuantityInUse] = @QuantityInUse
WHERE (Username = @Username AND LegoBrick = @LegoBrick)
----- End Table Manipulation -----

Return 0;