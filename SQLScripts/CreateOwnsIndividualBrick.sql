USE LegoInventoryTracker
GO

CREATE TABLE [OwnsIndividualBrick]
(
	Username Username,
	LegoBrick BrickID,
	Quantity int,
	QuantityInUse int,
	PRIMARY KEY(Username, LegoBrick),
	FOREIGN KEY(Username) REFERENCES [User](Username),
	FOREIGN KEY(LegoBrick) REFERENCES LegoBrick(ID)
)