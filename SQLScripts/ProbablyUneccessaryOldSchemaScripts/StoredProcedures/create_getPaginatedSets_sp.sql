USE [LegoInventoryTracker]
GO

/****** Object:  StoredProcedure [dbo].[getPaginatedSets]    Script Date: 2/11/2021 11:30:06 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--if if name is provided, do for the user.  Otherwise, do all models
CREATE procedure [dbo].[getPaginatedSets] 
@targetPage int, 
@itemsPerPage int
AS
if @targetPage * @itemsPerPage > (SELECT COUNT(ID) FROM LegoSet)
BEGIN
Print 'Page does not exist'
return 1
end
--credit to: https://stackoverflow.com/questions/19164698/how-to-select-a-row-based-on-its-row-number

Select ID, [Name], ImageURL From 
(Select Row_Number() Over (Order By ID) As RowNum, * From LegoSet) t2
Where RowNum > (@targetPage - 1)*@itemsPerPage AND RowNum <= (@targetPage - 1)*@itemsPerPage + @itemsPerPage


GO

