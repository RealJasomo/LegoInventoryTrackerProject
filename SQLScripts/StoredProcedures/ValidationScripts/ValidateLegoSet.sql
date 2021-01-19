USE LegoInventoryTracker
GO

SELECT *
FROM [LegoSet]
WHERE ID = '11111' -- Not a real SetID
GO

DECLARE @Status SMALLINT
EXEC @Status = [insert_LegoSet] @ID = '11111', @ImageURL = 'https://upload.wikimedia.org/wikipedia/en/9/95/Test_image.jpg', @Name = 'validationSet'
SELECT Status = @Status

SELECT *
FROM [LegoSet]
WHERE ID = '11111'
GO

DECLARE @Status SMALLINT
EXEC @Status = [update_LegoSet] @ID = '11111', @ImageURL = 'https://upload.wikimedia.org/wikipedia/en/9/95/Test_image.jpg', @Name = 'validationSet2'
SELECT Status = @Status

SELECT *
FROM [LegoSet]
WHERE ID = '11111'
GO

DECLARE @Status SMALLINT
EXEC @Status = [delete_LegoSet] @ID = '11111'
SELECT Status = @Status
GO

SELECT *
FROM [LegoSet]
WHERE ID = '11111'
GO