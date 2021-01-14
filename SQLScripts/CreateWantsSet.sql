USE LegoInventoryTracker
GO

CREATE TABLE [WantsSet]
(
	Username Username,
	LegoSet int,
	Quantity int,
	PRIMARY KEY(Username, LegoSet),
	FOREIGN KEY(Username) REFERENCES [User](Username),
	FOREIGN KEY(LegoSet) REFERENCES LegoSet(ID)
)