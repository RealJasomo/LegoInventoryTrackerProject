USE [LegoInventoryTracker]
GO

/****** Object:  StoredProcedure [dbo].[bricksNeededForModel]    Script Date: 2/11/2021 11:27:30 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[bricksNeededForModel] 
@userName varchar(20), @wantedModelID int


AS

SELECT LegoBrick, Quantity FROM OwnsIndividualBrick WHERE Username = @userName
EXCEPT
SELECT LegoBrick, Quantity FROM ModelContains WHERE Model = @wantedModelID
GO

