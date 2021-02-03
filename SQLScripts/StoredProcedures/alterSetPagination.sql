USE [LegoInventoryTracker]
GO

--if if name is provided, do for the user.  Otherwise, do all models
ALTER procedure [dbo].[getPaginatedSets] 
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


