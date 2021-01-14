USE LegoInventoryTracker
GO

CREATE TABLE [Wants]
(
	Username Username,
	LegoBrick BrickID,
	Quantity int,
	PRIMARY KEY(Username, LegoBrick),
	FOREIGN KEY(Username) REFERENCES [User](Username),
	FOREIGN KEY(LegoBrick) REFERENCES LegoBrick(ID)
)