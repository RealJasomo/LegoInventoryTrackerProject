USE LegoInventoryTracker
GO

CREATE TYPE Username
FROM varchar(20) NOT NULL;
GO

CREATE TYPE BrickID
FROM varchar(20)
GO

CREATE TYPE ImageURL
FROM varchar(100)
GO

EXEC sp_unbindrule 'BrickID'
DROP RULE numericCheck
GO


CREATE RULE numericCheck
AS
SELECT value from STRING_SPLIT(@id,'/')
ISNUMERIC() = 1

EXEC sp_bindrule 'numericCheck', 'BrickID'



CREATE TABLE BrickTest
(
	test BrickID
)
GO

INSERT INTO BrickTest(test) VALUES('1/4')
DELETE FROM BrickTest

DROP TABLE BrickTest