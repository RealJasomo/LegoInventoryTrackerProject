USE LegoInventoryTracker
GO

-----------------------
--
-- Inserts a row into the LegoSet table with values as selected
-- ImageURL and Name are optional.
--
-----------------------
-- Demo:
-- 
-- DECLARE @Status SMALLINT
-- EXEC @Status = [insert_LegoSet] @ID = '11111', @ImageURL = 'https://upload.wikimedia.org/wikipedia/en/9/95/Test_image.jpg', @Name = 'validationSet'
-- SELECT Status = @Status
-- 
-----------------------
-- Revision History
-- Created - 1/19/2021 - Luke Ferderer

ALTER PROCEDURE [insert_LegoSet]
(
	@ID int,
	@ImageURL ImageURL = NULL,
	@Name VarChar(80) = NULL
)
AS
----- Validate Parameters -----
-- Ensure the @ID is not NULL
IF @ID IS NULL
BEGIN
	RAISERROR('The @ID is null. It must not be null', 14, 1);
	RETURN 1;
END
-- Ensure a set with ID @ID does not exist in the table
IF (SELECT Count(ID) FROM [LegoSet] WHERE ID = @ID) <> 0
BEGIN
	RAISERROR('A set with the ID @ID already exists in the LegoSet table', 14, 1);
	RETURN 2;
END
----- End Validate Parameters -----

----- Table Manipulation -----
-- Inserts the requested data into the LegoSet table
INSERT INTO [LegoSet]
([ID], [ImageURL], [Name])
VALUES ( @ID, @ImageURL, @Name)
----- End Table Manipulation -----
RETURN 0;