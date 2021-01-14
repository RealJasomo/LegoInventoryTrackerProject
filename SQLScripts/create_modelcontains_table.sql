use LegoInventoryTracker
go

CREATE TABLE [ModelContains]
(
	Model int,
	LegoBrick dbo.BrickID,
	Quantity int,
	FOREIGN KEY (Model) references [LegoModel](ID),
	FOREIGN KEY (LegoBrick) references [LegoBrick](ID)
)