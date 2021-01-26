use LegoInventoryTracker
go
DROP TABLE [User]
CREATE TABLE [User](
	Username dbo.Username,
	Password text,
	FirstName nvarchar(30),
	LastName nvarchar(30),
	PRIMARY KEY (Username),
	CONSTRAINT CK_Username CHECK (LEN(Username) > 0)
)

ALTER TABLE [User]
ALTER COLUMN Password nvarchar(30) NOT NULL;

ALTER TABLE [User]
ALTER COLUMN Password nvarchar(70) NOT NULL