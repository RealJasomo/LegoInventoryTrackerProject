USE [LegoInventoryTracker]
GO

ALTER procedure [dbo].[getPaginatedBricks] 
@targetPage int, 
@itemsPerPage int

AS
if @targetPage * @itemsPerPage > (SELECT COUNT(ID) FROM LegoBrick)
BEGIN
Print 'Page does not exist'
return 1
END

--credit to: https://stackoverflow.com/questions/19164698/how-to-select-a-row-based-on-its-row-number
--for selecting by row number
 
Select ID, ImageURL, [Name], Color From 
(Select Row_Number() Over (Order By ID) As RowNum, * From LegoBrick) t2
Where RowNum > (@targetPage - 1)*@itemsPerPage AND RowNum <= (@targetPage - 1)*@itemsPerPage + @itemsPerPage


