SELECT *
FROM [User]
WHERE Username = 'validationUser'
GO

DECLARE @Status SMALLINT
EXEC @Status = [insert_User] @Username = validationUser, @Password = Password123, @FirstName = Luke, @LastName = Ferderer
SELECT Status = @Status

SELECT *
FROM [User]
GO

DECLARE @Status SMALLINT
EXEC @Status = [update_User] @Username = validationUser, @Password = V3ryS3cur3Pa22w0rd, @FirstName = Luke, @LastName = Ferderer
SELECT Status = @Status

SELECT *
FROM [User]
GO

DECLARE @Status SMALLINT
EXEC @Status = [delete_User] validationUser
SELECT Status = @Status
GO

SELECT *
FROM [User]
GO