use LegoInventoryTracker
go

CREATE TABLE Builds
(
	Model int,
	Username dbo.Username,
	Quantity int,
	PRIMARY KEY (Model, Username),
	FOREIGN KEY (Model) references [LegoModel](ID)
		ON UPDATE CASCADE,
	FOREIGN KEY (Username) references [User](Username)
		ON UPDATE CASCADE
		ON DELETE CASCADE
)
GO

ALTER TABLE Builds
ALTER COLUMN Quantity int NOT NULL
GO

ALTER TABLE Builds
ADD CHECK(Quantity>0)
GO

sp_help Builds