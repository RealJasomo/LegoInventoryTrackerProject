USE [LegoInventoryTracker]
GO


-----------------------
--
-- Deletes an entry from the LegoSet wants table using its ID value as input.
--
-----------------------
-----------------------
-- Revision History
-- Created - 2/12/2021 - Jason Cramer

CREATE PROCEDURE [dbo].[delete_WantsSet]
(	
	@Username dbo.Username,
	@LegoSet varchar(20)
)
AS
----- Validate Parameters -----
-- Ensure the @ID is not NULL
IF @Username IS NULL
BEGIN
	RAISERROR('The @Username is null. It must not be null', 14, 1);
	RETURN 1;
END
-- Ensure the @LegoSet is not NULL
IF @LegoSet IS NULL
BEGIN
	RAISERROR('The @LegoSet is null. It must not be null', 14, 1);
	RETURN 2;
END
-- Ensure an entry with Username @Username and LegoBrick @LegoBrick exists in the table
IF (SELECT Count(Username) FROM [WantsSet] WHERE Username = @Username AND LegoSet = @LegoSet) = 0
BEGIN
	RAISERROR('An entry with Username @Username and LegoSet @LegoSet does not exist in the table', 14, 1);
	RETURN 5;
END
----- End Validate Parameters -----

----- Table Manipulation -----
BEGIN TRY
	-- The requested column is deleted from the Order Details table
	DELETE [WantsSet]
	WHERE (Username = @Username AND LegoSet = @LegoSet)
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