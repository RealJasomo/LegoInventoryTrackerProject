USE [LegoInventoryTracker]
GO

/****** Object:  StoredProcedure [dbo].[getOwnedSets]    Script Date: 2/11/2021 11:29:27 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[getOwnedSets] 
@userName varchar(20)
AS
-- Validate User --
IF @userName IS NULL
BEGIN
    RAISERROR('The username is null. It must not be null', 14,1);
    RETURN 1;
END
-- check that user exist --
IF (SELECT Count(Username) FROM [User] WHERE Username=@userName) <> 1
BEGIN
    RAISERROR('The user does not exist', 14,1);
    RETURN 1;
END

SELECT ID, ImageURL, [Name], Quantity FROM
OwnsSet JOIN LegoSet on LegoSet = ID
WHERE Username = @userName 
GO

