use LegoInventoryTracker
go
CREATE TABLE LegoModel
(	
	ID int,
	ImageURL dbo.ImageURL,
	Name varchar(80),
	SetID int,
	
	FOREIGN KEY (SetID) references dbo.LegoSet(ID)
		ON UPDATE CASCADE,
	PRIMARY KEY (ID)
)
GO

ALTER TABLE LegoModel
ADD FOREIGN KEY (SetID) references dbo.LegoSet(ID)
	ON UPDATE CASCADE
GO

sp_help LegoModel