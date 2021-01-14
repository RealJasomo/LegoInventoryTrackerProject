use LegoInventoryTracker
go
CREATE TABLE LegoModel
(	
	ID int,
	ImageURL dbo.ImageURL,
	Name varchar(80),
	SetID int,
	
	FOREIGN KEY (SetID) references dbo.LegoSet(ID),
	PRIMARY KEY (ID)
)