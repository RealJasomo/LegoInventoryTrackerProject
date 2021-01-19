USE LegoInventoryTracker
GO

-----------------------
--
-- Upates the values of an entry in the LegoSet table using its ID value to select which row.
-- ImageURL and Name can be updated and are optional.
--
-----------------------
-- Demo:
-- 
-- DECLARE @Status SMALLINT
-- EXEC @Status = [update_LegoSet] @ID = '11111', @ImageURL = 'https://upload.wikimedia.org/wikipedia/en/9/95/Test_image.jpg', @Name = 'validationSet2'
-- SELECT Status = @Status
-- 
-----------------------
-- Revision History
-- Created - 1/19/2021 - Luke Ferderer

CREATE PROCEDURE [update_LegoSet]
(
	@ID int,
	@ImageURL ImageURL = NULL,
	@Name VarChar(80) = NULL
)
AS
----- Validate Parameters -----
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

----- Optional Parameter Checks -----
-- If @ImageURL is NULL, set it to the ImageURL value currently in the table for the requested entry
IF @ImageURL IS NULL
BEGIN
	SET @ImageURL = (SELECT ImageURL FROM [LegoSet] WHERE ID = @ID)
END
-- If @Name is NULL, set it to the Name value currently in the table for the requested entry
IF @Name IS NULL
BEGIN
	SET @Name = (SELECT Name FROM [LegoSet] WHERE ID = @ID)
END
----- End Optional Parameter Checks -----

----- Table Manipulation -----
-- Update Order Detail values
UPDATE [LegoSet]
SET [ImageURL] = @ImageURL, [Name] = @Name
WHERE ([ID] = @ID)
----- End Table Manipulation -----

Return 0;