USE LegoInventoryTracker
GO

CREATE TABLE [OwnsSet]
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

ALTER TABLE OwnsSet
ALTER COLUMN Quantity int NOT NULL
GO

ALTER TABLE OwnsSet
ADD CHECK (Quantity>0)
GO

sp_help OwnsSet