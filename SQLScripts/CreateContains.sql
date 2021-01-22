USE LegoInventoryTracker
GO

CREATE TABLE [Contains]
(
	LegoSet int,
	LegoBrick BrickID,
	Quantity int,
	PRIMARY KEY(LegoSet, LegoBrick),
	FOREIGN KEY(LegoSet) REFERENCES LegoSet(ID)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	FOREIGN KEY(LegoBrick) REFERENCES LegoBrick(ID)
		ON UPDATE CASCADE
)
GO

ALTER TABLE [Contains]
ALTER COLUMN Quantity int NOT NULL
GO

ALTER TABLE [Contains]
ADD CHECK(Quantity>0)
GO

sp_help [Contains]