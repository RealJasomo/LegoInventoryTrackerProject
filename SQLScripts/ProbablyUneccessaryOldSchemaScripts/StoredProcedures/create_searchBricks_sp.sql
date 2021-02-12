USE [LegoInventoryTracker]
GO

/****** Object:  StoredProcedure [dbo].[searchBricks]    Script Date: 2/11/2021 11:33:00 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[searchBricks] @targetName varchar(80) AS



SELECT * FROM LegoBrick WHERE Name LIKE '%'+@targetName+'%'
GO

