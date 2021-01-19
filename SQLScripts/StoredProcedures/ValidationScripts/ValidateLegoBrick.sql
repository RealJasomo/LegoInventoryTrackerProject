USE LegoInventoryTracker
GO

SELECT *
FROM [LegoBrick]
WHERE ID = '1234567/8900' -- Not a real BrickID
GO

DECLARE @Status SMALLINT
EXEC @Status = [insert_LegoBrick] @ID = '1234567/8900', @ImageURL = 'https://upload.wikimedia.org/wikipedia/en/9/95/Test_image.jpg', @Name = 'validationBrick', @Color = 'Blue'
SELECT Status = @Status

SELECT *
FROM [LegoBrick]
GO

DECLARE @Status SMALLINT
EXEC @Status = [update_LegoBrick] @ID = '1234567/8900', @ImageURL = 'https://upload.wikimedia.org/wikipedia/en/9/95/Test_image.jpg', @Color = 'Red'
SELECT Status = @Status

SELECT *
FROM [LegoBrick]
GO

DECLARE @Status SMALLINT
EXEC @Status = [delete_LegoBrick] @ID = '1234567/8900'
SELECT Status = @Status
GO

SELECT *
FROM [LegoBrick]
GO