USE LegoInventoryTracker
GO

CREATE TABLE [WantsSet]
(
	Username Username,
	LegoSet int,
	Quantity int,
	PRIMARY KEY(Username, LegoSet),
	FOREIGN KEY(Username) REFERENCES [User](Username)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	FOREIGN KEY(LegoSet) REFERENCES LegoSet(ID)
		ON UPDATE CASCADE
)
GO

ALTER TABLE WantsSet
ADD CHECK(Quantity>0)
GO

ALTER TABLE WantsSet
ALTER COLUMN Quantity int NOT NULL
GO

sp_help WantsSet