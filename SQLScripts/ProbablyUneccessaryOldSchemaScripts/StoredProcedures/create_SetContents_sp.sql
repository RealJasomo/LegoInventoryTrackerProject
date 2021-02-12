USE [LegoInventoryTracker]
GO

/****** Object:  StoredProcedure [dbo].[SetContents]    Script Date: 2/11/2021 11:33:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[SetContents] 
@SetID varchar(20)
AS
IF (SELECT COUNT(LegoBrick) FROM [Contains] WHERE LegoSet = @SetID) <= 0
BEGIN
PRINT 'Set does not exit'
return 1
END
SELECT LegoBrick, Quantity FROM [Contains] WHERE LegoSet = @SetID
GO

