USE [LegoInventoryTracker]
GO

/****** Object:  StoredProcedure [dbo].[ModelContents]    Script Date: 2/11/2021 11:32:50 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[ModelContents] 
@modelID int

AS
SELECT LegoBrick, Quantity FROM ModelContains WHERE Model = @modelID
GO

