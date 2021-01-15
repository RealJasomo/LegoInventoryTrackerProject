use LegoInventoryTracker
go

CREATE TABLE [ModelContains]
(
	Model int,
	LegoBrick dbo.BrickID,
	Quantity int,
	PRIMARY KEY (Model, LegoBrick, Quantity),
	FOREIGN KEY (Model) references [LegoModel](ID),
	FOREIGN KEY (LegoBrick) references [LegoBrick](ID)
)