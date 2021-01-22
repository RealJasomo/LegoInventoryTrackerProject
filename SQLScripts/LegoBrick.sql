USE LegoInventoryTracker
GO

CREATE TABLE LegoBrick(
ID [BrickID],
ImageURL [ImageURL],
Name varchar(80),
Color varchar(30),
Primary Key(ID)
)
GO