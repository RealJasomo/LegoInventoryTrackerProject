USE [LegoInventoryTracker]
GO

--if if name is provided, do for the user.  Otherwise, do all models
ALTER procedure [dbo].[getPaginatedModels] 
@targetPage int, 
@itemsPerPage int
AS

--credit to: https://stackoverflow.com/questions/19164698/how-to-select-a-row-based-on-its-row-number

Select ID, ImageURL, [Name], SetID From 
(Select Row_Number() Over (Order By ID) As RowNum, * From LegoModel) t2
Where RowNum > (@targetPage - 1)*@itemsPerPage AND RowNum <= (@targetPage - 1)*@itemsPerPage + @itemsPerPage

