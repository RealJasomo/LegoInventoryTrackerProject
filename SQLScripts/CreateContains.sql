USE LegoInventoryTracker
GO

CREATE TABLE [Contains]
(
	LegoSet int,
	LegoBrick BrickID,
	Quantity int,
	PRIMARY KEY(LegoSet, LegoBrick),
	FOREIGN KEY(LegoSet) REFERENCES LegoSet(ID),
	FOREIGN KEY(LegoBrick) REFERENCES LegoBrick(ID)
)