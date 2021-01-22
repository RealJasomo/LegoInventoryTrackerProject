use LegoInventoryTracker
go

CREATE TABLE [User](
	Username dbo.Username,
	Password text,
	FirstName nvarchar(30),
	LastName nvarchar(30),
	PRIMARY KEY (Username)
)

ALTER TABLE [User]
ALTER COLUMN Password nvarchar(30) NOT NULL;

ALTER TABLE [User]
ALTER COLUMN Password nvarchar(70) NOT NULL