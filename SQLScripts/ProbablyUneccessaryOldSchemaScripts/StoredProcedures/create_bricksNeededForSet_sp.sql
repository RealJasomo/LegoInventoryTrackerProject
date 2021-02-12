USE [LegoInventoryTracker]
GO

/****** Object:  StoredProcedure [dbo].[bricksNeededForSet]    Script Date: 2/11/2021 11:27:46 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[bricksNeededForSet] 
@userName varchar(20), @setID varchar(20)

AS

SELECT LegoBrick, Quantity FROM [Contains] WHERE LegoSet = @setID
EXCEPT
SELECT LegoBrick, Quantity FROM OwnsIndividualBrick WHERE Username = @userName

GO

