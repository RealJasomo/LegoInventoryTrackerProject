USE [LegoInventoryTracker]
GO

/****** Object:  StoredProcedure [dbo].[delete_LegoSet]    Script Date: 2/11/2021 11:28:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-----------------------
--
-- Deletes an entry from the LegoSet table using its ID value as input.
--
-----------------------
-- Demo:
-- DECLARE @Status SMALLINT
-- EXEC @Status = [delete_LegoSet] @ID = '11111'
-- SELECT Status = @Status
-----------------------
-- Revision History
-- Created - 1/19/2021 - Luke Ferderer

CREATE PROCEDURE [dbo].[delete_LegoSet]
(@ID int)
AS
----- Validate Parameters -----
-- Ensure the @ID is not NULL
IF @ID IS NULL
BEGIN
	RAISERROR('The @ID is null. It must not be null', 14, 1);
	RETURN 1;
END
-- Ensure a set with ID @ID exists in the table
IF (SELECT Count(ID) FROM [LegoSet] WHERE ID = @ID) = 0
BEGIN
	RAISERROR('A set with the ID @ID does not exists in the LegoSet table', 14, 1);
	RETURN 2;
END
----- End Validate Parameters -----

----- Table Manipulation -----
BEGIN TRY
	-- The requested column is deleted from the Order Details table
	DELETE [LegoSet]
	WHERE ([ID] = @ID)
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

