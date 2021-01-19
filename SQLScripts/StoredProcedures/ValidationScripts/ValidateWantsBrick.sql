USE LegoInventoryTracker
GO

--Insert brick to test with
DECLARE @Status SMALLINT
EXEC @Status = [insert_LegoBrick] @ID = '1234567/8900', @ImageURL = 'https://upload.wikimedia.org/wikipedia/en/9/95/Test_image.jpg', @Name = 'validationBrick', @Color = 'Blue'
SELECT Status = @Status
GO

--Insert user to test with
DECLARE @Status SMALLINT
EXEC @Status = [insert_User] @Username = validationUser, @Password = Password123, @FirstName = Luke, @LastName = Ferderer
SELECT Status = @Status

SELECT *
FROM [WantsBrick]
WHERE Username = 'validationUser' AND LegoBrick = '1234567/8900'
GO

DECLARE @Status SMALLINT
EXEC @Status = [insert_WantsBrick] @Username = validationUser, @LegoBrick = '1234567/8900', @Quantity = 10
SELECT Status = @Status

SELECT *
FROM [WantsBrick]
WHERE Username = 'validationUser' AND LegoBrick = '1234567/8900'
GO

DECLARE @Status SMALLINT
EXEC @Status = [update_WantsBrick]  @Username = validationUser, @LegoBrick = '1234567/8900', @Quantity = 15
SELECT Status = @Status

SELECT *
FROM [WantsBrick]
WHERE Username = 'validationUser' AND LegoBrick = '1234567/8900'
GO

DECLARE @Status SMALLINT
EXEC @Status = [delete_WantsBrick] @Username = validationUser, @LegoBrick = '1234567/8900'
SELECT Status = @Status
GO

SELECT *
FROM [WantsBrick]
WHERE Username = 'validationUser' AND LegoBrick = '1234567/8900'
GO

-- Delete testing brick
DECLARE @Status SMALLINT
EXEC @Status = [delete_LegoBrick] @ID = '1234567/8900'
SELECT Status = @Status
GO

-- Delete testing user
DECLARE @Status SMALLINT
EXEC @Status = [delete_User] validationUser
SELECT Status = @Status
GO