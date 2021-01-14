use LegoInventoryTracker
go


CREATE TABLE Builds
(
	Model int,
	Username dbo.Username,
	Quantity int,
	FOREIGN KEY (Model) references [LegoModel](ID),
	FOREIGN KEY (Username) references [User](Username)
)