use LegoInventoryTracker
go

CREATE TABLE [ModelContains]
(
	Model int,
	LegoBrick dbo.BrickID,
	Quantity int,
	PRIMARY KEY (Model, LegoBrick, Quantity),
	FOREIGN KEY (Model) references [LegoModel](ID)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	FOREIGN KEY (LegoBrick) references [LegoBrick](ID)
		ON UPDATE CASCADE
)

GO

ALTER TABLE [ModelContains]
ADD CHECK(Quantity > 0)
GO

sp_help [ModelContains]