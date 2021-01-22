USE LegoInventoryTracker
GO

CREATE TABLE [WantsBrick]
(
	Username Username,
	LegoBrick BrickID,
	Quantity int,
	PRIMARY KEY(Username, LegoBrick),
	FOREIGN KEY(Username) REFERENCES [User](Username)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	FOREIGN KEY(LegoBrick) REFERENCES LegoBrick(ID)
		ON UPDATE CASCADE
)
GO

ALTER TABLE WantsBrick
ALTER COLUMN Quantity int NOT NULL
GO

ALTER TABLE WantsBrick
ADD CHECK(Quantity>0)
GO

sp_help WantsBrick