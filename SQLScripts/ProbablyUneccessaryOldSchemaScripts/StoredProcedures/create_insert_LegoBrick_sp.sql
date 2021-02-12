USE [LegoInventoryTracker]
GO

/****** Object:  StoredProcedure [dbo].[insert_LegoBrick]    Script Date: 2/11/2021 11:30:46 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-----------------------
--
-- Inserts a row into the LegoBrick table with values as selected
-- ImageURL, Name, and Color are optional.
--
-----------------------
-- Demo:
-- 
-- DECLARE @Status SMALLINT
-- EXEC @Status = [insert_LegoBrick] @ID = '1234567/8900', @ImageURL = 'https://upload.wikimedia.org/wikipedia/en/9/95/Test_image.jpg', @Name = 'validationBrick', @Color = 'Blue'
-- SELECT Status = @Status
-- 
-----------------------
-- Revision History
-- Created - 1/19/2021 - Luke Ferderer

CREATE PROCEDURE [dbo].[insert_LegoBrick]
(
	@ID [BrickID],
	@ImageURL ImageURL = NULL,
	@Name VarChar(80) = NULL,
	@Color VarChar(30) = NULL
)
AS
----- Validate Parameters -----
-- Ensure the @ID is not NULL
IF @ID IS NULL
BEGIN
	RAISERROR('The @ID is null. It must not be null', 14, 1);
	RETURN 1;
END
-- Ensure a brick with ID @ID does not exist in the table
IF (SELECT Count(ID) FROM [LegoBrick] WHERE ID = @ID) <> 0
BEGIN
	RAISERROR('A brick with the ID @ID already exists in the LegoBrick table', 14, 1);
	RETURN 2;
END
----- End Validate Parameters -----

----- Table Manipulation -----
-- Inserts the requested data into the LegoBrick table
INSERT INTO [LegoBrick]
([ID], [ImageURL], [Name], [Color])
VALUES ( @ID, @ImageURL, @Name, @Color)
----- End Table Manipulation -----
RETURN 0;
GO

