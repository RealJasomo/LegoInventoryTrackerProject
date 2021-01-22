USE LegoInventoryTracker
GO

CREATE TABLE [OwnsIndividualBrick]
(
	Username Username,
	LegoBrick BrickID,
	Quantity int,
	QuantityInUse int,
	PRIMARY KEY(Username, LegoBrick),
	FOREIGN KEY(Username) REFERENCES [User](Username)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	FOREIGN KEY(LegoBrick) REFERENCES LegoBrick(ID)
		ON UPDATE CASCADE
)
GO

ALTER TABLE [OwnsIndividualBrick]
ADD CHECK(Quantity>0)
GO

ALTER TABLE [OwnsIndividualBrick]
ADD CHECK(QuantityInUse>=0)
GO

ALTER TABLE [OwnsIndividualBrick]
ADD CHECK(QuantityInUse <= Quantity)
GO

ALTER TABLE OwnsIndividualBrick
ALTER COLUMN Quantity int NOT NULL
GO

ALTER TABLE OwnsIndividualBrick
ALTER COLUMN QuantityInUse int NOT NULL
GO

sp_help [OwnsIndividualBrick]