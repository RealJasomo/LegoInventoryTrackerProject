USE LegoInventoryTracker
GO

-----------------------
--
-- Deletes an entry from the User table using its Username as an input
--
-----------------------
-- Demo:
-- DECLARE @Status SMALLINT
-- EXEC @Status = [delete_User] ferderl1
-- SELECT Status = @Status
-----------------------
-- Revision History
-- Created - 1/19/2021 - Luke Ferderer

ALTER PROCEDURE [dbo].[delete_User]
(@Username [Username])
AS
----- Validate Parameters -----
-- Ensure there exists an entry in the User table which has a Username of @Username
IF (SELECT Count(Username) FROM [User] WHERE Username = @Username) = 0
BEGIN
	RAISERROR('A user with Username @Username does not exist in User table', 14, 1);
	RETURN 1;
END
----- End Validate Parameters -----

----- Table Manipulation -----
BEGIN TRY
	-- The requested column is deleted from the User table
	DELETE [User]
	WHERE ( [Username] = @Username)
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
