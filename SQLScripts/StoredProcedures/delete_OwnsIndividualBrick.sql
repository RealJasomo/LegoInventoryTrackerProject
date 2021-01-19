USE LegoInventoryTracker
GO

-----------------------
--
-- Deletes an entry from the LegoBrick table using its ID value as input.
--
-----------------------
-- Demo:
-- DECLARE @Status SMALLINT
-- EXEC @Status = [delete_OwnsIndividualBrick] @Username = validationUser, @LegoBrick = '1234567/8900'
-- SELECT Status = @Status
-----------------------
-- Revision History
-- Created - 1/19/2021 - Luke Ferderer

CREATE PROCEDURE [dbo].[delete_OwnsIndividualBrick]
(	
	@Username dbo.Username,
	@LegoBrick dbo.BrickID
)
AS
----- Validate Parameters -----
-- Ensure the @ID is not NULL
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
-- Ensure an entry with Username @Username and LegoBrick @LegoBrick exists in the table
IF (SELECT Count(Username) FROM [OwnsIndividualBrick] WHERE Username = @Username AND LegoBrick = @LegoBrick) = 0
BEGIN
	RAISERROR('An entry with Username @Username and LegoBrick @LegoBrick does not exist in the table', 14, 1);
	RETURN 5;
END
----- End Validate Parameters -----

----- Table Manipulation -----
BEGIN TRY
	-- The requested column is deleted from the Order Details table
	DELETE [OwnsIndividualBrick]
	WHERE (Username = @Username AND LegoBrick = @LegoBrick)
END TRY
BEGIN CATCH
	-- Error check the previous DELETE operation
	DECLARE @ErrorMessage nvarchar(4000);
	SET @ErrorMessage = ERROR_MESSAGE();
	RAISERROR('DELETE failed. Error code returned. Error message: %s', 14, 1, @ErrorMessage);
	RETURN ERROR_NUMBER();
END CATCH
----- End Table Manipulation -----

RETURN 0