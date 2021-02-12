USE [LegoInventoryTracker]
GO

/****** Object:  StoredProcedure [dbo].[delete_WantsBrick]    Script Date: 2/11/2021 11:28:55 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-----------------------
--
-- Deletes an entry from the WantsBrick table using its Username and BrickID as inputs.
--
-----------------------
-- Demo:
-- DECLARE @Status SMALLINT
-- EXEC @Status = [delete_WantsBrick] @Username = validationUser, @LegoBrick = '1234567/8900'
-- SELECT Status = @Status
-----------------------
-- Revision History
-- Created - 1/19/2021 - Luke Ferderer

CREATE PROCEDURE [dbo].[delete_WantsBrick]
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
IF (SELECT Count(Username) FROM [WantsBrick] WHERE Username = @Username AND LegoBrick = @LegoBrick) = 0
BEGIN
	RAISERROR('An entry with Username @Username and LegoBrick @LegoBrick does not exist in the table', 14, 1);
	RETURN 5;
END
----- End Validate Parameters -----

----- Table Manipulation -----
BEGIN TRY
	-- The requested column is deleted from the Order Details table
	DELETE [WantsBrick]
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
GO

