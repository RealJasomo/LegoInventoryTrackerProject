USE LegoInventoryTracker
GO

CREATE TABLE [OwnsBrick]
(
	Username Username,
	LegoBrick BrickID,
	Quantity int,
	QuantityInUse int,
	PRIMARY KEY(Username, LegoBrick),
	FOREIGN KEY(Username) REFERENCES [User](Username),
	FOREIGN KEY(LegoBrick) REFERENCES LegoBrick(ID)
)