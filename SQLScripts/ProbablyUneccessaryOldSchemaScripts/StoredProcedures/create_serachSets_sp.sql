USE [LegoInventoryTracker]
GO

/****** Object:  StoredProcedure [dbo].[searchSets]    Script Date: 2/11/2021 11:33:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[searchSets] @targetName varchar(80) AS



SELECT * FROM LegoSet WHERE Name LIKE '%'+@targetName+'%'
GO

