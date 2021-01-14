use LegoInventoryTracker
go

CREATE TABLE [User](
	Username dbo.Username,
	Password text,
	FirstName nvarchar(30),
	LastName nvarchar(30),
	PRIMARY KEY (Username)
)