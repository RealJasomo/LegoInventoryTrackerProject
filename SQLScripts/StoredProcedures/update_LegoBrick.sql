USE LegoInventoryTracker
GO

-----------------------
--
-- Upates the values of an entry in the LegoBrick table using its ID value to select which row.
-- ImageURL, Name, and Color can all be updated and all are optional.
--
-----------------------
-- Demo:
-- 
-- DECLARE @Status SMALLINT
-- EXEC @Status = [update_LegoBrick] @ID = '1234567/8900', @ImageURL = 'https://upload.wikimedia.org/wikipedia/en/9/95/Test_image.jpg', @Name = 'validationBrick', @Color = 'Red'
-- SELECT Status = @Status
-- 
-----------------------
-- Revision History
-- Created - 1/19/2021 - Luke Ferderer

CREATE PROCEDURE [update_LegoBrick]
(
	@ID [BrickID],
	@ImageURL ImageURL = NULL,
	@Name VarChar(80) = NULL,
	@Color VarChar(30) = NULL
)
AS
----- Validate Parameters -----
IF @ID IS NULL
BEGIN
	RAISERROR('The @ID is null. It must not be null', 14, 1);
	RETURN 1;
END
-- Ensure a brick with ID @ID does exist in the table
IF (SELECT Count(ID) FROM [LegoBrick] WHERE ID = @ID) = 0
BEGIN
	RAISERROR('A brick with the ID @ID does not exists in the LegoBrick table', 14, 1);
	RETURN 2;
END
----- End Validate Parameters -----

----- Optional Parameter Checks -----
-- If @ImageURL is NULL, set it to the ImageURL value currently in the table for the requested entry
IF @ImageURL IS NULL
BEGIN
	SET @ImageURL = (SELECT ImageURL FROM [LegoBrick] WHERE ID = @ID)
END
-- If @Name is NULL, set it to the Name value currently in the table for the requested entry
IF @Name IS NULL
BEGIN
	SET @Name = (SELECT Name FROM [LegoBrick] WHERE ID = @ID)
END
-- If @Color is NULL, set it to the Name value currently in the table for the requested entry
IF @Color IS NULL
BEGIN
	SET @Color = (SELECT Name FROM [LegoBrick] WHERE ID = @ID)
END
----- End Optional Parameter Checks -----

----- Table Manipulation -----
-- Update Order Detail values
UPDATE [LegoBrick]
SET [ImageURL] = @ImageURL, [Name] = @Name,
[Color] = @Color
WHERE ([ID] = @ID)
----- End Table Manipulation -----

Return 0;