USE [master]
GO
/****** Object:  Database [LegoInventoryTracker2]    Script Date: 2/18/2021 10:27:04 PM ******/
CREATE DATABASE [LegoInventoryTracker2]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'LegoInventoryTracker2Data', FILENAME = N'D:\Database\MSSQL15.MSSQLSERVER\MSSQL\DATA\LegoInventoryTracker2Data.mdf' , SIZE = 38912KB , MAXSIZE = 51200KB , FILEGROWTH = 15%)
 LOG ON 
( NAME = N'LegoInventoryTracker2Log', FILENAME = N'D:\Database\MSSQL15.MSSQLSERVER\MSSQL\DATA\LegoInventoryTracker2Log.ldf' , SIZE = 10112KB , MAXSIZE = 30720KB , FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [LegoInventoryTracker2] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LegoInventoryTracker2].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [LegoInventoryTracker2] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [LegoInventoryTracker2] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [LegoInventoryTracker2] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [LegoInventoryTracker2] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [LegoInventoryTracker2] SET ARITHABORT OFF 
GO
ALTER DATABASE [LegoInventoryTracker2] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [LegoInventoryTracker2] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [LegoInventoryTracker2] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [LegoInventoryTracker2] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [LegoInventoryTracker2] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [LegoInventoryTracker2] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [LegoInventoryTracker2] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [LegoInventoryTracker2] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [LegoInventoryTracker2] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [LegoInventoryTracker2] SET  ENABLE_BROKER 
GO
ALTER DATABASE [LegoInventoryTracker2] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [LegoInventoryTracker2] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [LegoInventoryTracker2] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [LegoInventoryTracker2] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [LegoInventoryTracker2] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [LegoInventoryTracker2] SET RECOVERY FULL 
GO
ALTER DATABASE [LegoInventoryTracker2] SET  MULTI_USER 
GO
ALTER DATABASE [LegoInventoryTracker2] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [LegoInventoryTracker2] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [LegoInventoryTracker2] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [LegoInventoryTracker2] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [LegoInventoryTracker2] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'LegoInventoryTracker2', N'ON'
GO
ALTER DATABASE [LegoInventoryTracker2] SET QUERY_STORE = OFF
GO
USE [LegoInventoryTracker2]
GO
CREATE ROLE db_executor
GO
GRANT EXECUTE TO db_executor
GO
/****** Object:  User [morrisjj]    Script Date: 2/18/2021 10:27:06 PM ******/
CREATE USER [morrisjj] FOR LOGIN [morrisjj] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [lego_application]    Script Date: 2/18/2021 10:27:06 PM ******/
CREATE USER [lego_application] FOR LOGIN [lego_application] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [cramerj1]    Script Date: 2/18/2021 10:27:06 PM ******/
CREATE USER [cramerj1] FOR LOGIN [cramerj1] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [morrisjj]
GO
ALTER ROLE [db_owner] ADD MEMBER [cramerj1]
GO
ALTER ROLE [db_datareader] ADD MEMBER [lego_application]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [lego_application]
GO
ALTER ROLE [db_executor] ADD MEMBER [lego_application]
GO
/****** Object:  UserDefinedDataType [dbo].[BrickID]    Script Date: 2/18/2021 10:27:06 PM ******/
CREATE TYPE [dbo].[BrickID] FROM [varchar](20) NOT NULL
GO
/****** Object:  UserDefinedDataType [dbo].[ImageURL]    Script Date: 2/18/2021 10:27:06 PM ******/
CREATE TYPE [dbo].[ImageURL] FROM [varchar](100) NULL
GO
/****** Object:  UserDefinedDataType [dbo].[Password]    Script Date: 2/18/2021 10:27:06 PM ******/
CREATE TYPE [dbo].[Password] FROM [varchar](30) NULL
GO
/****** Object:  UserDefinedDataType [dbo].[Username]    Script Date: 2/18/2021 10:27:06 PM ******/
CREATE TYPE [dbo].[Username] FROM [varchar](20) NOT NULL
GO
/****** Object:  Table [dbo].[Contains]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contains](
	[LegoSet] [varchar](20) NOT NULL,
	[LegoBrick] [dbo].[BrickID] NOT NULL,
	[Quantity] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LegoBrick]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LegoBrick](
	[ID] [dbo].[BrickID] NOT NULL,
	[ImageURL] [dbo].[ImageURL] NULL,
	[Name] [varchar](80) NOT NULL,
	[Color] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LegoSet]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LegoSet](
	[ImageURL] [dbo].[ImageURL] NULL,
	[ID] [varchar](20) NOT NULL,
	[Name] [varchar](80) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OwnsIndividualBrick]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OwnsIndividualBrick](
	[Username] [dbo].[Username] NOT NULL,
	[LegoBrick] [dbo].[BrickID] NOT NULL,
	[Quantity] [int] NOT NULL,
	[QuantityInUse] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Username] ASC,
	[LegoBrick] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OwnsSet]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OwnsSet](
	[Username] [dbo].[Username] NOT NULL,
	[LegoSet] [varchar](20) NOT NULL,
	[Quantity] [int] NOT NULL,
	[QuantityBuilt] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[LegoSet] ASC,
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Username] [dbo].[Username] NOT NULL,
	[Password] [nvarchar](70) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WantsBrick]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WantsBrick](
	[Username] [dbo].[Username] NOT NULL,
	[LegoBrick] [dbo].[BrickID] NOT NULL,
	[Quantity] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Username] ASC,
	[LegoBrick] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WantsSet]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WantsSet](
	[Username] [dbo].[Username] NOT NULL,
	[LegoSet] [varchar](20) NOT NULL,
	[Quantity] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[LegoSet] ASC,
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [BrickByName]    Script Date: 2/18/2021 10:27:06 PM ******/
CREATE NONCLUSTERED INDEX [BrickByName] ON [dbo].[LegoBrick]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [SetByName]    Script Date: 2/18/2021 10:27:06 PM ******/
CREATE NONCLUSTERED INDEX [SetByName] ON [dbo].[LegoSet]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OwnsSet] ADD  DEFAULT ((0)) FOR [QuantityBuilt]
GO
ALTER TABLE [dbo].[Contains]  WITH CHECK ADD FOREIGN KEY([LegoBrick])
REFERENCES [dbo].[LegoBrick] ([ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Contains]  WITH CHECK ADD FOREIGN KEY([LegoSet])
REFERENCES [dbo].[LegoSet] ([ID])
GO
ALTER TABLE [dbo].[OwnsIndividualBrick]  WITH CHECK ADD FOREIGN KEY([LegoBrick])
REFERENCES [dbo].[LegoBrick] ([ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[OwnsIndividualBrick]  WITH CHECK ADD FOREIGN KEY([Username])
REFERENCES [dbo].[User] ([Username])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OwnsSet]  WITH CHECK ADD FOREIGN KEY([LegoSet])
REFERENCES [dbo].[LegoSet] ([ID])
GO
ALTER TABLE [dbo].[OwnsSet]  WITH CHECK ADD FOREIGN KEY([Username])
REFERENCES [dbo].[User] ([Username])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[WantsBrick]  WITH CHECK ADD FOREIGN KEY([LegoBrick])
REFERENCES [dbo].[LegoBrick] ([ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[WantsBrick]  WITH CHECK ADD FOREIGN KEY([Username])
REFERENCES [dbo].[User] ([Username])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[WantsSet]  WITH CHECK ADD FOREIGN KEY([LegoSet])
REFERENCES [dbo].[LegoSet] ([ID])
GO
ALTER TABLE [dbo].[WantsSet]  WITH CHECK ADD FOREIGN KEY([Username])
REFERENCES [dbo].[User] ([Username])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Contains]  WITH CHECK ADD CHECK  (([LegoBrick] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9]' OR [LegoBrick] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9][0-9]' OR [LegoBrick] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9][0-9][0-9]' OR [LegoBrick] like '[0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9]' OR [LegoBrick] like '[0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9][0-9]' OR [LegoBrick] like '[0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9][0-9][0-9]' OR [LegoBrick] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9]' OR [LegoBrick] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9][0-9]' OR [LegoBrick] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[Contains]  WITH CHECK ADD CHECK  (([Quantity]>(0)))
GO
ALTER TABLE [dbo].[LegoBrick]  WITH CHECK ADD CHECK  (([ID] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9]' OR [ID] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9][0-9]' OR [ID] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9][0-9][0-9]' OR [ID] like '[0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9]' OR [ID] like '[0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9][0-9]' OR [ID] like '[0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9][0-9][0-9]' OR [ID] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9]' OR [ID] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9][0-9]' OR [ID] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[OwnsIndividualBrick]  WITH CHECK ADD CHECK  (([Quantity]>(0)))
GO
ALTER TABLE [dbo].[OwnsIndividualBrick]  WITH CHECK ADD CHECK  (([QuantityInUse]>=(0)))
GO
ALTER TABLE [dbo].[OwnsIndividualBrick]  WITH CHECK ADD CHECK  (([QuantityInUse]<=[Quantity]))
GO
ALTER TABLE [dbo].[OwnsSet]  WITH CHECK ADD CHECK  (([QuantityBuilt]>=(0) AND [QuantityBuilt]<=[Quantity]))
GO
ALTER TABLE [dbo].[OwnsSet]  WITH CHECK ADD CHECK  (([Quantity]>(0)))
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD CHECK  ((len([Username])>(0)))
GO
ALTER TABLE [dbo].[WantsBrick]  WITH CHECK ADD CHECK  (([Quantity]>(0)))
GO
ALTER TABLE [dbo].[WantsSet]  WITH CHECK ADD CHECK  (([Quantity]>(0)))
GO
/****** Object:  StoredProcedure [dbo].[bricksNeededForSet]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[bricksNeededForSet] 
@userName varchar(20), @setID varchar(20)

AS

SELECT LegoBrick.ID, LegoBrick.Name, LegoBrick.ImageURL, LegoBrick.Color, ISNULL(c.Quantity - (oib.Quantity - oib.QuantityInUse), c.Quantity) AS Quantity
FROM LegoBrick JOIN 
(
	SELECT LegoBrick, Quantity FROM [Contains] WHERE LegoSet = @setID
) as c ON legoBrick.ID = c.LegoBrick
LEFT JOIN
(
	SELECT * FROM OwnsIndividualBrick WHERE Username = @userName
) as oib ON oib.LegoBrick = c.LegoBrick
WHERE oib.Quantity IS NULL OR oib.Quantity - oib.QuantityInUse < c.Quantity
GO
/****** Object:  StoredProcedure [dbo].[delete_LegoBrick]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-----------------------
--
-- Deletes an entry from the LegoBrick table using its ID value as input.
--
-----------------------
-- Demo:
-- DECLARE @Status SMALLINT
-- EXEC @Status = [delete_LegoBrick] @ID = '1234567/8900'
-- SELECT Status = @Status
-----------------------
-- Revision History
-- Created - 1/19/2021 - Luke Ferderer

CREATE PROCEDURE [dbo].[delete_LegoBrick]
(@ID [BrickID])
AS
----- Validate Parameters -----
-- Ensure the @ID is not NULL
IF @ID IS NULL
BEGIN
	RAISERROR('The @ID is null. It must not be null', 14, 1);
	RETURN 1;
END
-- Ensure a brick with ID @ID exists in the table
IF (SELECT Count(ID) FROM [LegoBrick] WHERE ID = @ID) = 0
BEGIN
	RAISERROR('A brick with the ID @ID does not exists in the LegoBrick table', 14, 1);
	RETURN 2;
END
----- End Validate Parameters -----

----- Table Manipulation -----
BEGIN TRY
	-- The requested column is deleted from the Order Details table
	DELETE [LegoBrick]
	WHERE ([ID] = @ID)
END TRY
BEGIN CATCH
	-- Error check the previous DELETE operation
	DECLARE @ErrorMessage nvarchar(4000);
	SET @ErrorMessage = ERROR_MESSAGE();
	RAISERROR('DELETE failed. Error code returned. Error message: %s', 14, 1, @ErrorMessage);
	RETURN ERROR_NUMBER();
END CATCH
----- End Table Manipulation -----

RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[delete_LegoSet]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-----------------------
--
-- Deletes an entry from the LegoSet table using its ID value as input.
--
-----------------------
-- Demo:
-- DECLARE @Status SMALLINT
-- EXEC @Status = [delete_LegoSet] @ID = '11111'
-- SELECT Status = @Status
-----------------------
-- Revision History
-- Created - 1/19/2021 - Luke Ferderer

CREATE PROCEDURE [dbo].[delete_LegoSet]
(@ID int)
AS
----- Validate Parameters -----
-- Ensure the @ID is not NULL
IF @ID IS NULL
BEGIN
	RAISERROR('The @ID is null. It must not be null', 14, 1);
	RETURN 1;
END
-- Ensure a set with ID @ID exists in the table
IF (SELECT Count(ID) FROM [LegoSet] WHERE ID = @ID) = 0
BEGIN
	RAISERROR('A set with the ID @ID does not exists in the LegoSet table', 14, 1);
	RETURN 2;
END
----- End Validate Parameters -----

----- Table Manipulation -----
BEGIN TRY
	-- The requested column is deleted from the Order Details table
	DELETE [LegoSet]
	WHERE ([ID] = @ID)
END TRY
BEGIN CATCH
	-- Error check the previous DELETE operation
	DECLARE @ErrorMessage nvarchar(4000);
	SET @ErrorMessage = ERROR_MESSAGE();
	RAISERROR('DELETE failed. Error code returned. Error message: %s', 14, 1, @ErrorMessage);
	RETURN ERROR_NUMBER();
END CATCH
----- End Table Manipulation -----

RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[delete_OwnsIndividualBrick]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-----------------------
--
-- Deletes an entry from the LegoBrick table using its ID value as input.
--
-----------------------
-- Demo:
-- DECLARE @Status SMALLINT
-- EXEC @Status = [delete_OwnsIndividualBrick] @Username = validationUser, @LegoBrick = '1234567/8900'
-- SELECT Status = @Status
-----------------------
-- Revision History
-- Created - 1/19/2021 - Luke Ferderer

CREATE PROCEDURE [dbo].[delete_OwnsIndividualBrick]
(	
	@Username dbo.Username,
	@LegoBrick dbo.BrickID
)
AS
----- Validate Parameters -----
-- Ensure the @ID is not NULL
IF @Username IS NULL
BEGIN
	RAISERROR('The @Username is null. It must not be null', 14, 1);
	RETURN 1;
END
-- Ensure the @LegoBrick is not NULL
IF @LegoBrick IS NULL
BEGIN
	RAISERROR('The @LegoBrick is null. It must not be null', 14, 1);
	RETURN 2;
END
-- Ensure an entry with Username @Username and LegoBrick @LegoBrick exists in the table
IF (SELECT Count(Username) FROM [OwnsIndividualBrick] WHERE Username = @Username AND LegoBrick = @LegoBrick) = 0
BEGIN
	RAISERROR('An entry with Username @Username and LegoBrick @LegoBrick does not exist in the table', 14, 1);
	RETURN 5;
END
----- End Validate Parameters -----

----- Table Manipulation -----
BEGIN TRY
	-- The requested column is deleted from the Order Details table
	DELETE [OwnsIndividualBrick]
	WHERE (Username = @Username AND LegoBrick = @LegoBrick)
END TRY
BEGIN CATCH
	-- Error check the previous DELETE operation
	DECLARE @ErrorMessage nvarchar(4000);
	SET @ErrorMessage = ERROR_MESSAGE();
	RAISERROR('DELETE failed. Error code returned. Error message: %s', 14, 1, @ErrorMessage);
	RETURN ERROR_NUMBER();
END CATCH
----- End Table Manipulation -----

RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[delete_OwnsSet]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------
--
-- Deletes an entry from the LegoBrick table using its ID value as input.
--
-----------------------
-----------------------
-- Revision History
-- Created - 2/12/2021 - Jason Cramer

CREATE PROCEDURE [dbo].[delete_OwnsSet]
(	
	@Username dbo.Username,
	@LegoSet varchar(20)
)
AS
----- Validate Parameters -----
-- Ensure the @ID is not NULL
IF @Username IS NULL
BEGIN
	RAISERROR('The @Username is null. It must not be null', 14, 1);
	RETURN 1;
END
-- Ensure the @LegoSet is not NULL
IF @LegoSet IS NULL
BEGIN
	RAISERROR('The @LegoSet is null. It must not be null', 14, 1);
	RETURN 2;
END
-- Ensure an entry with Username @Username and LegoBrick @LegoBrick exists in the table
IF (SELECT Count(Username) FROM [OwnsSet] WHERE Username = @Username AND LegoSet = @LegoSet) = 0
BEGIN
	RAISERROR('An entry with Username @Username and LegoSet @LegoSet does not exist in the table', 14, 1);
	RETURN 5;
END
----- End Validate Parameters -----

----- Table Manipulation -----
BEGIN TRANSACTION;
	----- Table Manipulation -----
	-- Inserts bricks in the set into OwnsIndividualBrick table
		DECLARE @SetQuantityChange int
	SET @SetQuantityChange = -(SELECT Quantity FROM OwnsSet WHERE Username = @Username AND LegoSet = @LegoSet)
	DECLARE @BuiltQuantityChange int
	SET @BuiltQuantityChange = -(SELECT QuantityBuilt FROM OwnsSet WHERE Username = @Username AND LegoSet = @LegoSet)
	DECLARE @CurrentBrick BrickID
	DECLARE @CurrentQuantityInUse int
	DECLARE @CurrentQuantity int
	DECLARE @i int
	SET @i = 0
	DECLARE @totalDistinctBricksInSet int
	SELECT @totalDistinctBricksInSet = count(LegoBrick) FROM [Contains] WHERE LegoSet = @LegoSet
	WHILE @i < @totalDistinctBricksInSet
	BEGIN
		SELECT @CurrentBrick = LegoBrick, @CurrentQuantity = Quantity * @SetQuantityChange, @CurrentQuantityInUse = Quantity * @BuiltQuantityChange
		FROM [Contains]
		WHERE LegoSet = @LegoSet
		ORDER BY LegoBrick
		OFFSET @i ROWS
		FETCH NEXT 1 ROWS ONLY
		SET @i = @i + 1

		IF(SELECT Count(Username) FROM [OwnsIndividualBrick] WHERE Username = @Username AND LegoBrick = @CurrentBrick) = 0
		BEGIN
			IF @CurrentQuantity > 0
			BEGIN
				DECLARE @Status SMALLINT
				EXEC @Status = [insert_OwnsIndividualBrick] @Username = @Username, @LegoBrick = @CurrentBrick, @Quantity = @CurrentQuantity, @QuantityInUse = @CurrentQuantityInUse
				IF (@Status <> 0)
				BEGIN
					RAISERROR('Error inserting bricks', 14, 1);
					ROLLBACK TRANSACTION
					return 9;
				END
			END
		END
		ELSE
		BEGIN
			DECLARE @NewQuantity int
			SELECT @NewQuantity = @CurrentQuantity + Quantity FROM OwnsIndividualBrick WHERE Username = @Username AND LegoBrick = @CurrentBrick
			DECLARE @NewQuantityInUse int
			SELECT @NewQuantityInUse = @CurrentQuantityInUse + QuantityInUse FROM OwnsIndividualBrick WHERE Username = @Username AND LegoBrick = @CurrentBrick
			DECLARE @Status2 SMALLINT
			IF (@NewQuantity <= 0)
			BEGIN
				EXEC @Status2 = [delete_OwnsIndividualBrick]  @Username = @Username, @LegoBrick = @CurrentBrick
			END
			ELSE
			BEGIN
				EXEC @Status2 = [update_OwnsIndividualBrick]  @Username = @Username, @LegoBrick = @CurrentBrick, @Quantity = @NewQuantity, @QuantityInUse = @NewQuantityInUse
			END
			IF (@Status2 <> 0)
			BEGIN
				RAISERROR('Error inserting bricks', 14, 1);
				ROLLBACK TRANSACTION
				return 10;
			END
		END
	END
BEGIN TRY
-- The requested column is deleted from the Order Details table
DELETE [OwnsSet]
WHERE (Username = @Username AND LegoSet = @LegoSet)
END TRY
BEGIN CATCH
	-- Error check the previous DELETE operation
	DECLARE @ErrorMessage nvarchar(4000);
	SET @ErrorMessage = ERROR_MESSAGE();
	RAISERROR('DELETE failed. Error code returned. Error message: %s', 14, 1, @ErrorMessage);
	ROLLBACK TRANSACTION
	RETURN ERROR_NUMBER();
END CATCH
COMMIT TRANSACTION;
----- End Table Manipulation -----

RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[delete_User]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-----------------------
--
-- Deletes an entry from the User table using its Username as an input
--
-----------------------
-- Demo:
-- DECLARE @Status SMALLINT
-- EXEC @Status = [delete_User] ferderl1
-- SELECT Status = @Status
-----------------------
-- Revision History
-- Created - 1/19/2021 - Luke Ferderer

CREATE PROCEDURE [dbo].[delete_User]
(@Username [Username])
AS
----- Validate Parameters -----
-- Ensure there exists an entry in the User table which has a Username of @Username
IF (SELECT Count(Username) FROM [User] WHERE Username = @Username) = 0
BEGIN
	RAISERROR('A user with Username @Username does not exist in User table', 14, 1);
	RETURN 1;
END
----- End Validate Parameters -----

----- Table Manipulation -----
BEGIN TRY
	-- The requested column is deleted from the User table
	DELETE [User]
	WHERE ( [Username] = @Username)
END TRY
BEGIN CATCH
	-- Error check the previous DELETE operation
	DECLARE @ErrorMessage nvarchar(4000);
	SET @ErrorMessage = ERROR_MESSAGE();
	RAISERROR('DELETE failed. Error code returned. Error message: %s', 14, 1, @ErrorMessage);
	RETURN ERROR_NUMBER();
END CATCH
----- End Table Manipulation -----

RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[delete_WantsBrick]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-----------------------
--
-- Deletes an entry from the WantsBrick table using its Username and BrickID as inputs.
--
-----------------------
-- Demo:
-- DECLARE @Status SMALLINT
-- EXEC @Status = [delete_WantsBrick] @Username = validationUser, @LegoBrick = '1234567/8900'
-- SELECT Status = @Status
-----------------------
-- Revision History
-- Created - 1/19/2021 - Luke Ferderer

CREATE PROCEDURE [dbo].[delete_WantsBrick]
(	
	@Username dbo.Username,
	@LegoBrick dbo.BrickID
)
AS
----- Validate Parameters -----
-- Ensure the @ID is not NULL
IF @Username IS NULL
BEGIN
	RAISERROR('The @Username is null. It must not be null', 14, 1);
	RETURN 1;
END
-- Ensure the @LegoBrick is not NULL
IF @LegoBrick IS NULL
BEGIN
	RAISERROR('The @LegoBrick is null. It must not be null', 14, 1);
	RETURN 2;
END
-- Ensure an entry with Username @Username and LegoBrick @LegoBrick exists in the table
IF (SELECT Count(Username) FROM [WantsBrick] WHERE Username = @Username AND LegoBrick = @LegoBrick) = 0
BEGIN
	RAISERROR('An entry with Username @Username and LegoBrick @LegoBrick does not exist in the table', 14, 1);
	RETURN 5;
END
----- End Validate Parameters -----

----- Table Manipulation -----
BEGIN TRY
	-- The requested column is deleted from the Order Details table
	DELETE [WantsBrick]
	WHERE (Username = @Username AND LegoBrick = @LegoBrick)
END TRY
BEGIN CATCH
	-- Error check the previous DELETE operation
	DECLARE @ErrorMessage nvarchar(4000);
	SET @ErrorMessage = ERROR_MESSAGE();
	RAISERROR('DELETE failed. Error code returned. Error message: %s', 14, 1, @ErrorMessage);
	RETURN ERROR_NUMBER();
END CATCH
----- End Table Manipulation -----

RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[delete_WantsSet]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------
--
-- Deletes an entry from the LegoSet wants table using its ID value as input.
--
-----------------------
-----------------------
-- Revision History
-- Created - 2/12/2021 - Jason Cramer

CREATE PROCEDURE [dbo].[delete_WantsSet]
(	
	@Username dbo.Username,
	@LegoSet varchar(20)
)
AS
----- Validate Parameters -----
-- Ensure the @ID is not NULL
IF @Username IS NULL
BEGIN
	RAISERROR('The @Username is null. It must not be null', 14, 1);
	RETURN 1;
END
-- Ensure the @LegoSet is not NULL
IF @LegoSet IS NULL
BEGIN
	RAISERROR('The @LegoSet is null. It must not be null', 14, 1);
	RETURN 2;
END
-- Ensure an entry with Username @Username and LegoBrick @LegoBrick exists in the table
IF (SELECT Count(Username) FROM [WantsSet] WHERE Username = @Username AND LegoSet = @LegoSet) = 0
BEGIN
	RAISERROR('An entry with Username @Username and LegoSet @LegoSet does not exist in the table', 14, 1);
	RETURN 5;
END
----- End Validate Parameters -----

----- Table Manipulation -----
BEGIN TRY
	-- The requested column is deleted from the Order Details table
	DELETE [WantsSet]
	WHERE (Username = @Username AND LegoSet = @LegoSet)
END TRY
BEGIN CATCH
	-- Error check the previous DELETE operation
	DECLARE @ErrorMessage nvarchar(4000);
	SET @ErrorMessage = ERROR_MESSAGE();
	RAISERROR('DELETE failed. Error code returned. Error message: %s', 14, 1, @ErrorMessage);
	RETURN ERROR_NUMBER();
END CATCH
----- End Table Manipulation -----

RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[getAvailableBricks]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getAvailableBricks] 
@username varchar(20)
AS

----- Validate Parameters -----
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
----- End Validate Parameters -----

SELECT ID, ImageURL, Name, Color, Quantity, QuantityInUse FROM
OwnsIndividualBrick JOIN LegoBrick on LegoBrick	= ID
WHERE Username = @userName AND Quantity - QuantityInUse > 0

GO
/****** Object:  StoredProcedure [dbo].[getBuildableSets]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[getBuildableSets] 
@userName varchar(20)

AS
SELECT ID, ImageURL, Name
FROM
	(SELECT COUNT(LegoBrick.ID) AS BrickCount, LegoSet.ID, LegoSet.ImageURL, LegoSet.Name
	FROM LegoBrick JOIN OwnsIndividualBrick ON LegoBrick.ID = OwnsIndividualBrick.LegoBrick
		 JOIN [Contains] ON LegoBrick.ID = [Contains].LegoBrick
		 JOIN LegoSet ON [Contains].LegoSet = LegoSet.ID
	WHERE OwnsIndividualBrick.Username = @userName AND
		  [Contains].Quantity <= OwnsIndividualBrick.Quantity - OwnsIndividualBrick.QuantityInUse
	GROUP BY [Contains].LegoSet, LegoSet.ID, LegoSet.ImageURL, LegoSet.Name) AS owns
	JOIN
	(SELECT COUNT(*) AS BrickCount, [Contains].LegoSet FROM [Contains] GROUP BY LegoSet) AS [required] ON owns.ID = required.LegoSet
WHERE owns.BrickCount = [required].BrickCount
GO
/****** Object:  StoredProcedure [dbo].[getOwnedBricks]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[getOwnedBricks] 
@userName varchar(20)
AS

----- Validate Parameters -----
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
----- End Validate Parameters -----

SELECT ID, ImageURL, Name, Color, Quantity, QuantityInUse FROM
OwnsIndividualBrick JOIN LegoBrick on LegoBrick	= ID
WHERE Username = @userName 
GO
/****** Object:  StoredProcedure [dbo].[getOwnedSets]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[getOwnedSets] 
@userName varchar(20)
AS
----- Validate Parameters -----
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
----- End Validate Parameters -----

SELECT ID, ImageURL, [Name], Quantity, QuantityBuilt FROM
OwnsSet JOIN LegoSet on LegoSet = ID
WHERE Username = @userName 
GO
/****** Object:  StoredProcedure [dbo].[getPaginatedBricks]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[getPaginatedBricks] 
@targetPage int, 
@itemsPerPage int

AS
if (@targetPage - 1) * @itemsPerPage > (SELECT COUNT(ID) FROM LegoBrick)
BEGIN
Print 'Page does not exist'
return 1
END

--credit to: https://stackoverflow.com/questions/19164698/how-to-select-a-row-based-on-its-row-number
--for selecting by row number
 
Select ID, ImageURL, [Name], Color From 
(Select Row_Number() Over (Order By ID) As RowNum, * From LegoBrick) t2
Where RowNum > (@targetPage - 1)*@itemsPerPage AND RowNum <= (@targetPage - 1)*@itemsPerPage + @itemsPerPage


GO
/****** Object:  StoredProcedure [dbo].[getPaginatedSets]    Script Date: 2/19/2021 12:44:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--if if name is provided, do for the user.  Otherwise, do all models
CREATE procedure [dbo].[getPaginatedSets] 
@targetPage int, 
@itemsPerPage int
AS
if (@targetPage - 1) * @itemsPerPage > (SELECT COUNT(ID) FROM LegoSet)
BEGIN
Print 'Page does not exist'
return 1
end
--credit to: https://stackoverflow.com/questions/19164698/how-to-select-a-row-based-on-its-row-number

Select ID, [Name], ImageURL From 
(Select Row_Number() Over (Order By ID DESC) As RowNum, * From LegoSet) t2
Where RowNum > (@targetPage - 1)*@itemsPerPage AND RowNum <= (@targetPage - 1)*@itemsPerPage + @itemsPerPage


GO
/****** Object:  StoredProcedure [dbo].[getWantedBricks]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[getWantedBricks] 
@userName varchar(20)
AS

----- Validate Parameters -----
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
----- End Validate Parameters -----


SELECT ID, ImageURL, Name, Color, Quantity FROM
WantsBrick JOIN LegoBrick on LegoBrick	= ID
WHERE Username = @userName 
GO
/****** Object:  StoredProcedure [dbo].[getWantedSets]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[getWantedSets]
@userName varchar(20)
AS
----- Validate Parameters -----
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
----- End Validate Parameters -----

SELECT ID, ImageURL, Name, Quantity FROM
WantsSet JOIN LegoSet on LegoSet	= ID
WHERE Username = @userName 
GO
/****** Object:  StoredProcedure [dbo].[insert_Contains]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-----------------------
--
-- Inserts a row into the Contains table with values as selected
--
-----------------------
-- Demo:
-- 
-- DECLARE @Status SMALLINT
-- EXEC @Status = [insert_Contains] @SetID = '11111', @LegoBrick = '1234567/8900', @Quantity = 10
-- SELECT Status = @Status
-- 
-----------------------
-- Revision History
-- Created - 2/5/2021 - Luke Ferderer

CREATE PROCEDURE [dbo].[insert_Contains]
(
	@SetID varchar(20),
	@LegoBrick dbo.BrickID,
	@Quantity int
)
AS
----- Validate Parameters -----
-- Ensure the @SetID is not NULL
IF @SetID IS NULL
BEGIN
	RAISERROR('The @Set is null. It must not be null', 14, 1);
	RETURN 1;
END
-- Ensure the @LegoBrick is not NULL
IF @LegoBrick IS NULL
BEGIN
	RAISERROR('The @LegoBrick is null. It must not be null', 14, 1);
	RETURN 2;
END
-- Ensure the @Quantity is not NULL or negative
IF @Quantity IS NULL OR @Quantity < 0
BEGIN
	RAISERROR('The @Quantity is null or less than 0. It must not be null or less than 0', 14, 1);
	RETURN 3;
END
-- Ensure a set with ID @SetID does exist in the LegoSet table
IF (SELECT Count(ID) FROM [LegoSet] WHERE ID = @SetID) = 0
BEGIN
	RAISERROR('A set with the ID @SetID does not exist in the LegoSet table', 14, 1);
	RETURN 4;
END
-- Ensure a brick with ID @LegoBrickID exists in the LegoBrick table
IF (SELECT Count(ID) FROM [LegoBrick] WHERE ID = @LegoBrick) = 0
BEGIN
	RAISERROR('A brick with the ID @LegoBrick does not exist in the LegoBrick table', 14, 1);
	RETURN 5;
END
-- Ensure an entry with Username @Username and LegoBrick @LegoBrick does not exist in the table
IF (SELECT Count(LegoSet) FROM [Contains] WHERE LegoSet = @SetID AND LegoBrick = @LegoBrick) <> 0
BEGIN
	RAISERROR('An entry with SetID @SetID and LegoBrick @LegoBrick already exists in the table', 14, 1);
	RETURN 6;
END
----- End Validate Parameters -----

----- Table Manipulation -----
-- Inserts the requested data into the LegoBrick table
INSERT INTO [Contains]
([LegoSet], [LegoBrick], [Quantity])
VALUES ( @SetID, @LegoBrick, @Quantity)
----- End Table Manipulation -----
RETURN 0;
GO
/****** Object:  StoredProcedure [dbo].[insert_LegoBrick]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-----------------------
--
-- Inserts a row into the LegoBrick table with values as selected
-- ImageURL, Name, and Color are optional.
--
-----------------------
-- Demo:
-- 
-- DECLARE @Status SMALLINT
-- EXEC @Status = [insert_LegoBrick] @ID = '1234567/8900', @ImageURL = 'https://upload.wikimedia.org/wikipedia/en/9/95/Test_image.jpg', @Name = 'validationBrick', @Color = 'Blue'
-- SELECT Status = @Status
-- 
-----------------------
-- Revision History
-- Created - 1/19/2021 - Luke Ferderer

CREATE PROCEDURE [dbo].[insert_LegoBrick]
(
	@ID [BrickID],
	@ImageURL ImageURL = NULL,
	@Name VarChar(80) = NULL,
	@Color VarChar(30) = NULL
)
AS
----- Validate Parameters -----
-- Ensure the @ID is not NULL
IF @ID IS NULL
BEGIN
	RAISERROR('The @ID is null. It must not be null', 14, 1);
	RETURN 1;
END
-- Ensure a brick with ID @ID does not exist in the table
IF (SELECT Count(ID) FROM [LegoBrick] WHERE ID = @ID) <> 0
BEGIN
	RAISERROR('A brick with the ID @ID already exists in the LegoBrick table', 14, 1);
	RETURN 2;
END
----- End Validate Parameters -----

----- Table Manipulation -----
-- Inserts the requested data into the LegoBrick table
INSERT INTO [LegoBrick]
([ID], [ImageURL], [Name], [Color])
VALUES ( @ID, @ImageURL, @Name, @Color)
----- End Table Manipulation -----
RETURN 0;
GO
/****** Object:  StoredProcedure [dbo].[insert_LegoSet]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------
--
-- Inserts a row into the LegoSet table with values as selected
-- ImageURL and Name are optional.
--
-----------------------
-- Demo:
-- 
-- DECLARE @Status SMALLINT
-- EXEC @Status = [insert_LegoSet] @ID = '11111', @ImageURL = 'https://upload.wikimedia.org/wikipedia/en/9/95/Test_image.jpg', @Name = 'validationSet'
-- SELECT Status = @Status
-- 
-----------------------
-- Revision History
-- Created - 1/19/2021 - Luke Ferderer

CREATE PROCEDURE [dbo].[insert_LegoSet]
(
	@ID VarChar(20),
	@ImageURL ImageURL = NULL,
	@Name VarChar(80) = NULL
)
AS
----- Validate Parameters -----
-- Ensure the @ID is not NULL
IF @ID IS NULL
BEGIN
	RAISERROR('The @ID is null. It must not be null', 14, 1);
	RETURN 1;
END
-- Ensure a set with ID @ID does not exist in the table
IF (SELECT Count(ID) FROM [LegoSet] WHERE ID = @ID) <> 0
BEGIN
	RAISERROR('A set with the ID @ID already exists in the LegoSet table', 14, 1);
	RETURN 2;
END
----- End Validate Parameters -----

----- Table Manipulation -----
-- Inserts the requested data into the LegoSet table
INSERT INTO [LegoSet]
([ID], [ImageURL], [Name])
VALUES ( @ID, @ImageURL, @Name)
----- End Table Manipulation -----
RETURN 0;
GO
/****** Object:  StoredProcedure [dbo].[insert_OwnsIndividualBrick]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-----------------------
--
-- Inserts a row into the OwnsIndividualBrick table with values as selected
--
-----------------------
-- Demo:
-- 
-- DECLARE @Status SMALLINT
-- EXEC @Status = [insert_OwnsIndividualBrick] @Username = validationUser, @LegoBrick = '1234567/8900', @Quantity = 10, @QuantityInUse = 5
-- SELECT Status = @Status
-- 
-----------------------
-- Revision History
-- Created - 1/19/2021 - Luke Ferderer

CREATE PROCEDURE [dbo].[insert_OwnsIndividualBrick]
(
	@Username dbo.Username,
	@LegoBrick dbo.BrickID,
	@Quantity int,
	@QuantityInUse int
)
AS
----- Validate Parameters -----
-- Ensure the @ID is not NULL
IF @Username IS NULL
BEGIN
	RAISERROR('The @Username is null. It must not be null', 14, 1);
	RETURN 1;
END
-- Ensure the @LegoBrickID is not NULL
IF @LegoBrick IS NULL
BEGIN
	RAISERROR('The @LegoBrick is null. It must not be null', 14, 1);
	RETURN 2;
END
-- Ensure the @Quantity is not NULL
IF @Quantity IS NULL OR @Quantity < 0
BEGIN
	RAISERROR('The @Quantity is null or less than 0. It must not be null or less than 0', 14, 1);
	RETURN 3;
END
-- Ensure the @QuantityInUse is not NULL
IF @QuantityInUse IS NULL OR @QuantityInUse < 0
BEGIN
	RAISERROR('The @QuantityInUse is null or less than 0. It must not be null or less than 0', 14, 1);
	RETURN 4;
END
-- Ensure a user with Username @Username does exist in the User table
IF (SELECT Count(Username) FROM [User] WHERE Username = @Username) = 0
BEGIN
	RAISERROR('A user with the username @Username does not exist in the User table', 14, 1);
	RETURN 5;
END
-- Ensure a brick with ID @LegoBrickID exists in the LegoBrick table
IF (SELECT Count(ID) FROM [LegoBrick] WHERE ID = @LegoBrick) = 0
BEGIN
	RAISERROR('A brick with the ID @LegoBrick does not exist in the LegoBrick table', 14, 1);
	RETURN 6;
END
-- Ensure an entry with Username @Username and LegoBrick @LegoBrick does not exist in the table
IF (SELECT Count(Username) FROM [OwnsIndividualBrick] WHERE Username = @Username AND LegoBrick = @LegoBrick) <> 0
BEGIN
	RAISERROR('An entry with Username @Username and LegoBrick @LegoBrick already exists in the table', 14, 1);
	RETURN 7;
END
-- Ensure QuantityInUse is less or equal to Quantity
IF (@QuantityInUse > @Quantity)
BEGIN
	RAISERROR('@QuantityInUse is > @Quantity. This must not be the case', 14, 1);
	RETURN 8;
END
----- End Validate Parameters -----

----- Table Manipulation -----
-- Inserts the requested data into the LegoBrick table
INSERT INTO [OwnsIndividualBrick]
([Username], [LegoBrick], [Quantity], [QuantityInUse])
VALUES ( @Username, @LegoBrick, @Quantity, @QuantityInUse)
----- End Table Manipulation -----
RETURN 0;
GO
/****** Object:  StoredProcedure [dbo].[insert_OwnsSet]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insert_OwnsSet]
(
	@Username dbo.Username,
	@LegoSet varchar(20),
	@Quantity int,
	@QuantityBuilt int = 0
)
AS
----- Validate Parameters -----
-- Ensure the @ID is not NULL
IF @Username IS NULL
BEGIN
	RAISERROR('The @Username is null. It must not be null', 14, 1);
	RETURN 1;
END
-- Ensure the @LegoBrickID is not NULL
IF @LegoSet IS NULL
BEGIN
	RAISERROR('The @LegoSet is null. It must not be null', 14, 1);
	RETURN 2;
END
-- Ensure the @Quantity is not NULL
IF @Quantity IS NULL OR @Quantity < 0
BEGIN
	RAISERROR('The @Quantity is null or less than 0. It must not be null or less than 0', 14, 1);
	RETURN 3;
END
-- Ensure the @QuantityBuilt is not NULL
IF @QuantityBuilt IS NULL OR @QuantityBuilt < 0
BEGIN
	RAISERROR('The @QuantityBuilt is null or less than 0. It must not be null or less than 0', 14, 1);
	RETURN 4;
END
-- Ensure a user with Username @Username does exist in the User table
IF (SELECT Count(Username) FROM [User] WHERE Username = @Username) = 0
BEGIN
	RAISERROR('A user with the username @Username does not exist in the User table', 14, 1);
	RETURN 5;
END
-- Ensure a brick with ID @LegoBrickID exists in the LegoBrick table
IF (SELECT Count(ID) FROM [LegoSet] WHERE ID = @LegoSet) = 0
BEGIN
	RAISERROR('A brick with the ID @LegoSet does not exist in the LegoSet table', 14, 1);
	RETURN 6;
END
-- Ensure an entry with Username @Username and LegoBrick @LegoBrick does not exist in the table
IF (SELECT Count(Username) FROM [OwnsSet] WHERE Username = @Username AND LegoSet = @LegoSet) <> 0
BEGIN
	RAISERROR('An entry with Username @Username and LegoSet @LegoSet already exists in the table', 14, 1);
	RETURN 7;
END
-- Ensure @QuantityBuilt is <= @Quantity
IF @QuantityBuilt > @Quantity
BEGIN
	RAISERROR('@QuantityBuilt is greater than @Quantity is must be less than or equal to @Quantity', 14, 1);
	RETURN 8;
END
----- End Validate Parameters -----

BEGIN TRANSACTION;
	----- Table Manipulation -----
	-- Inserts bricks in the set into OwnsIndividualBrick table
	DECLARE @SetQuantityChange int
	SET @SetQuantityChange = @Quantity
	DECLARE @CurrentBrick BrickID
	DECLARE @CurrentQuantityInUse int
	DECLARE @CurrentQuantity int
	DECLARE @i int
	SET @i = 0
	DECLARE @totalDistinctBricksInSet int
	SELECT @totalDistinctBricksInSet = count(LegoBrick) FROM [Contains] WHERE LegoSet = @LegoSet
	WHILE @i < @totalDistinctBricksInSet
	BEGIN
		SELECT @CurrentBrick = LegoBrick, @CurrentQuantity = Quantity * @SetQuantityChange, @CurrentQuantityInUse = Quantity * @QuantityBuilt
		FROM [Contains]
		WHERE LegoSet = @LegoSet
		ORDER BY LegoBrick
		OFFSET @i ROWS
		FETCH NEXT 1 ROWS ONLY
		SET @i = @i + 1

		IF(SELECT Count(Username) FROM [OwnsIndividualBrick] WHERE Username = @Username AND LegoBrick = @CurrentBrick) = 0
		BEGIN
			IF @CurrentQuantity > 0
			BEGIN
				DECLARE @Status SMALLINT
				EXEC @Status = [insert_OwnsIndividualBrick] @Username = @Username, @LegoBrick = @CurrentBrick, @Quantity = @CurrentQuantity, @QuantityInUse = @CurrentQuantityInUse
				IF (@Status <> 0)
				BEGIN
					RAISERROR('Error inserting bricks', 14, 1);
					ROLLBACK TRANSACTION
					return 9;
				END
			END
		END
		ELSE
		BEGIN
			DECLARE @NewQuantity int
			SELECT @NewQuantity = @CurrentQuantity + Quantity FROM OwnsIndividualBrick WHERE Username = @Username AND LegoBrick = @CurrentBrick
			DECLARE @NewQuantityInUse int
			SELECT @NewQuantityInUse = @CurrentQuantityInUse + QuantityInUse FROM OwnsIndividualBrick WHERE Username = @Username AND LegoBrick = @CurrentBrick
			DECLARE @Status2 SMALLINT
			IF (@NewQuantity <= 0)
			BEGIN
				EXEC @Status2 = [delete_OwnsIndividualBrick]  @Username = @Username, @LegoBrick = @CurrentBrick
			END
			ELSE
			BEGIN
				EXEC @Status2 = [update_OwnsIndividualBrick]  @Username = @Username, @LegoBrick = @CurrentBrick, @Quantity = @NewQuantity, @QuantityInUse = @NewQuantityInUse
			END
			IF (@Status2 <> 0)
			BEGIN
				RAISERROR('Error inserting bricks', 14, 1);
				ROLLBACK TRANSACTION
				return 10;
			END
		END
	END
	
	-- Inserts the requested data into the LegoBrick table
	INSERT INTO [OwnsSet]
	([Username], [LegoSet], [Quantity], [QuantityBuilt])
	VALUES ( @Username, @LegoSet, @Quantity, @QuantityBuilt)
	----- End Table Manipulation -----
COMMIT TRANSACTION;
RETURN 0;
GO
/****** Object:  StoredProcedure [dbo].[insert_User]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-----------------------
--
-- Inserts a row into the Users table with values as selected
--
-----------------------
-- Demo:
-- 
-- DECLARE @Status SMALLINT
-- EXEC @Status = [insert_User] @Username = ferderl1, @Password = V3ryS3cur3Pa22w0rd
-- SELECT Status = @Status
-- 
-----------------------
-- Revision History
-- Created - 1/19/2021 - Luke Ferderer

CREATE PROCEDURE [dbo].[insert_User]
(
	@Username dbo.Username,
	@Password nvarchar(70)
)
AS
----- Validate Parameters -----
-- Ensure the @Username is not NULL
IF @Username IS NULL
BEGIN
	RAISERROR('The @Username is null. It must not be null', 14, 1);
	RETURN 1;
END
-- Ensure a user with Username @Username does not exist in the table
IF (SELECT Count(Username) FROM [User] WHERE Username = @Username) <> 0
BEGIN
	RAISERROR('A user with the Username @Username already exists in the User table', 14, 1);
	RETURN 2;
END
-- Ensure the @Password is not NULL
IF @Password IS NULL
BEGIN
	RAISERROR('The @Password is null. It must not be null', 14, 1);
	RETURN 3;
END
----- End Validate Parameters -----

----- Table Manipulation -----
-- Inserts the requested data into the User table
INSERT INTO [User]
( [Username], [Password])
VALUES (@Username, @Password)
----- End Table Manipulation -----
RETURN 0;
GO
/****** Object:  StoredProcedure [dbo].[insert_WantsBrick]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-----------------------
--
-- Inserts a row into the WantsBrick table with values as selected
--
-----------------------
-- Demo:
-- 
-- DECLARE @Status SMALLINT
-- EXEC @Status = [insert_WantsBrick] @Username = validationUser, @LegoBrick = '1234567/8900', @Quantity = 10
-- SELECT Status = @Status
-- 
-----------------------
-- Revision History
-- Created - 1/19/2021 - Luke Ferderer

CREATE PROCEDURE [dbo].[insert_WantsBrick]
(
	@Username dbo.Username,
	@LegoBrick dbo.BrickID,
	@Quantity int
)
AS
----- Validate Parameters -----
-- Ensure the @Username is not NULL
IF @Username IS NULL
BEGIN
	RAISERROR('The @Username is null. It must not be null', 14, 1);
	RETURN 1;
END
-- Ensure the @LegoBrick is not NULL
IF @LegoBrick IS NULL
BEGIN
	RAISERROR('The @LegoBrick is null. It must not be null', 14, 1);
	RETURN 2;
END
-- Ensure the @Quantity is not NULL or negative
IF @Quantity IS NULL OR @Quantity < 0
BEGIN
	RAISERROR('The @Quantity is null or less than 0. It must not be null or less than 0', 14, 1);
	RETURN 3;
END
-- Ensure a user with Username @Username does exist in the User table
IF (SELECT Count(Username) FROM [User] WHERE Username = @Username) = 0
BEGIN
	RAISERROR('A user with the username @Username does not exist in the User table', 14, 1);
	RETURN 5;
END
-- Ensure a brick with ID @LegoBrickID exists in the LegoBrick table
IF (SELECT Count(ID) FROM [LegoBrick] WHERE ID = @LegoBrick) = 0
BEGIN
	RAISERROR('A brick with the ID @LegoBrick does not exist in the LegoBrick table', 14, 1);
	RETURN 6;
END
-- Ensure an entry with Username @Username and LegoBrick @LegoBrick does not exist in the table
IF (SELECT Count(Username) FROM [WantsBrick] WHERE Username = @Username AND LegoBrick = @LegoBrick) <> 0
BEGIN
	RAISERROR('An entry with Username @Username and LegoBrick @LegoBrick already exists in the table', 14, 1);
	RETURN 7;
END
----- End Validate Parameters -----

----- Table Manipulation -----
-- Inserts the requested data into the LegoBrick table
INSERT INTO [WantsBrick]
([Username], [LegoBrick], [Quantity])
VALUES ( @Username, @LegoBrick, @Quantity)
----- End Table Manipulation -----
RETURN 0;
GO
/****** Object:  StoredProcedure [dbo].[insert_WantsSet]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insert_WantsSet]
(
	@Username dbo.Username,
	@LegoSet varchar(20),
	@Quantity int
)
AS
----- Validate Parameters -----
-- Ensure the @Username is not NULL
IF @Username IS NULL
BEGIN
	RAISERROR('The @Username is null. It must not be null', 14, 1);
	RETURN 1;
END
-- Ensure the @@LegoSet is not NULL
IF @LegoSet IS NULL
BEGIN
	RAISERROR('The @LegoSet is null. It must not be null', 14, 1);
	RETURN 2;
END
-- Ensure the @Quantity is not NULL or negative
IF @Quantity IS NULL OR @Quantity < 0
BEGIN
	RAISERROR('The @Quantity is null or less than 0. It must not be null or less than 0', 14, 1);
	RETURN 3;
END
-- Ensure a user with Username @Username does exist in the User table
IF (SELECT Count(Username) FROM [User] WHERE Username = @Username) = 0
BEGIN
	RAISERROR('A user with the username @Username does not exist in the User table', 14, 1);
	RETURN 5;
END
-- Ensure a set with ID @LegoSetID exists in the LegoSet table
IF (SELECT Count(ID) FROM [LegoSet] WHERE ID = @LegoSet) = 0
BEGIN
	RAISERROR('A set with the ID @SetBrick does not exist in the LegoSet table', 14, 1);
	RETURN 6;
END
-- Ensure an entry with Username @Username and LegoBrick @LegoBrick does not exist in the table
IF (SELECT Count(Username) FROM [WantsSet] WHERE Username = @Username AND LegoSet = @LegoSet) <> 0
BEGIN
	RAISERROR('An entry with Username @Username and LegoSet @LegoSet already exists in the table', 14, 1);
	RETURN 7;
END
----- End Validate Parameters -----

----- Table Manipulation -----
-- Inserts the requested data into the LegoBrick table
INSERT INTO [WantsSet]
([Username], [LegoSet], [Quantity])
VALUES ( @Username, @LegoSet, @Quantity)
----- End Table Manipulation -----
RETURN 0;
GO
/****** Object:  StoredProcedure [dbo].[login_User]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-----------------------
--
-- Gets hashed password from User with username
--
-----------------------
-- Demo:
-- 
-- DECLARE @Status SMALLINT
-- EXEC @Status = [insert_User] @Username = ferderl1
-- SELECT Status = @Status
-- 
-----------------------
-- Revision History
-- Created - 1/26/2021 - Jason Cramer

CREATE PROCEDURE [dbo].[login_User]
(
	@Username dbo.Username
)
AS
----- Validate Parameters -----
-- Ensure the @Username is not NULL
IF @Username IS NULL
BEGIN
	RAISERROR('The @Username is null. It must not be null', 14, 1);
	RETURN 1;
END
-- Ensure a user with Username @Username does exist in the table
IF (SELECT Count(Username) FROM [User] WHERE Username = @Username) = 0
BEGIN
	RAISERROR('User does not exists in the User table', 14, 1);
	RETURN 2;
END
----- End Validate Parameters -----

----- Table Manipulation -----
-- Inserts the requested data into the User table
declare @hash_pass as NVARCHAR(70);
SELECT @hash_pass=Password from [User]
WHERE Username = @Username
----- End Table Manipulation -----
SELECT @hash_pass as [hashpassword];
GO
/****** Object:  StoredProcedure [dbo].[searchBricks]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[searchBricks] @targetName varchar(80) AS



SELECT * FROM LegoBrick WHERE Name  LIKE CONCAT('%',@targetName,'%')
GO
/****** Object:  StoredProcedure [dbo].[searchBricksColor]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[searchBricksColor] @targetColor varchar(30) AS

SELECT * FROM LegoBrick WHERE Color  LIKE CONCAT('%',@targetColor,'%')
GO
/****** Object:  StoredProcedure [dbo].[searchBricksID]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[searchBricksID] @targetID varchar(22) AS

SELECT * FROM LegoBrick WHERE ID  LIKE CONCAT('%',@targetID,'%')
GO
/****** Object:  StoredProcedure [dbo].[searchSets]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[searchSets] @targetName varchar(80) AS



SELECT * FROM LegoSet WHERE Name LIKE '%'+@targetName+'%'
GO
/****** Object:  StoredProcedure [dbo].[searchSetsID]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[searchSetsID] @targetID varchar(32) AS

SELECT * FROM LegoSet WHERE ID  LIKE CONCAT('%',@targetID,'%')
GO
/****** Object:  StoredProcedure [dbo].[SetContents]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[SetContents] 
@SetID varchar(20)
AS
----- Validate Parameters -----
-- Ensure the @LegoSet is not NULL
IF @SetID IS NULL
BEGIN
	RAISERROR('The @SetID is null. It must not be null', 14, 1);
	RETURN 1;
END
IF (SELECT COUNT(LegoBrick) FROM [Contains] WHERE LegoSet = @SetID) <= 0
BEGIN
	PRINT 'Set does not exit'
	RETURN 2;
END
----- End Validate Parameters -----

SELECT LegoBrick, Quantity FROM [Contains] WHERE LegoSet = @SetID
GO
/****** Object:  StoredProcedure [dbo].[update_LegoBrick]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-----------------------
--
-- Upates the values of an entry in the LegoBrick table using its ID value to select which row.
-- ImageURL, Name, and Color can all be updated and all are optional.
--
-----------------------
-- Demo:
-- 
-- DECLARE @Status SMALLINT
-- EXEC @Status = [update_LegoBrick] @ID = '1234567/8900', @ImageURL = 'https://upload.wikimedia.org/wikipedia/en/9/95/Test_image.jpg', @Name = 'validationBrick', @Color = 'Red'
-- SELECT Status = @Status
-- 
-----------------------
-- Revision History
-- Created - 1/19/2021 - Luke Ferderer

CREATE PROCEDURE [dbo].[update_LegoBrick]
(
	@ID [BrickID],
	@ImageURL ImageURL = NULL,
	@Name VarChar(80) = NULL,
	@Color VarChar(30) = NULL
)
AS
----- Validate Parameters -----
IF @ID IS NULL
BEGIN
	RAISERROR('The @ID is null. It must not be null', 14, 1);
	RETURN 1;
END
-- Ensure a brick with ID @ID does exist in the table
IF (SELECT Count(ID) FROM [LegoBrick] WHERE ID = @ID) = 0
BEGIN
	RAISERROR('A brick with the ID @ID does not exists in the LegoBrick table', 14, 1);
	RETURN 2;
END
----- End Validate Parameters -----

----- Optional Parameter Checks -----
-- If @ImageURL is NULL, set it to the ImageURL value currently in the table for the requested entry
IF @ImageURL IS NULL
BEGIN
	SET @ImageURL = (SELECT ImageURL FROM [LegoBrick] WHERE ID = @ID)
END
-- If @Name is NULL, set it to the Name value currently in the table for the requested entry
IF @Name IS NULL
BEGIN
	SET @Name = (SELECT Name FROM [LegoBrick] WHERE ID = @ID)
END
-- If @Color is NULL, set it to the Name value currently in the table for the requested entry
IF @Color IS NULL
BEGIN
	SET @Color = (SELECT Name FROM [LegoBrick] WHERE ID = @ID)
END
----- End Optional Parameter Checks -----

----- Table Manipulation -----
-- Update Order Detail values
UPDATE [LegoBrick]
SET [ImageURL] = @ImageURL, [Name] = @Name,
[Color] = @Color
WHERE ([ID] = @ID)
----- End Table Manipulation -----

Return 0;
GO
/****** Object:  StoredProcedure [dbo].[update_LegoSet]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-----------------------
--
-- Upates the values of an entry in the LegoSet table using its ID value to select which row.
-- ImageURL and Name can be updated and are optional.
--
-----------------------
-- Demo:
-- 
-- DECLARE @Status SMALLINT
-- EXEC @Status = [update_LegoSet] @ID = '11111', @ImageURL = 'https://upload.wikimedia.org/wikipedia/en/9/95/Test_image.jpg', @Name = 'validationSet2'
-- SELECT Status = @Status
-- 
-----------------------
-- Revision History
-- Created - 1/19/2021 - Luke Ferderer

CREATE PROCEDURE [dbo].[update_LegoSet]
(
	@ID int,
	@ImageURL ImageURL = NULL,
	@Name VarChar(80) = NULL
)
AS
----- Validate Parameters -----
IF @ID IS NULL
BEGIN
	RAISERROR('The @ID is null. It must not be null', 14, 1);
	RETURN 1;
END
-- Ensure a set with ID @ID exists in the table
IF (SELECT Count(ID) FROM [LegoSet] WHERE ID = @ID) = 0
BEGIN
	RAISERROR('A set with the ID @ID does not exists in the LegoSet table', 14, 1);
	RETURN 2;
END
----- End Validate Parameters -----

----- Optional Parameter Checks -----
-- If @ImageURL is NULL, set it to the ImageURL value currently in the table for the requested entry
IF @ImageURL IS NULL
BEGIN
	SET @ImageURL = (SELECT ImageURL FROM [LegoSet] WHERE ID = @ID)
END
-- If @Name is NULL, set it to the Name value currently in the table for the requested entry
IF @Name IS NULL
BEGIN
	SET @Name = (SELECT Name FROM [LegoSet] WHERE ID = @ID)
END
----- End Optional Parameter Checks -----

----- Table Manipulation -----
-- Update Order Detail values
UPDATE [LegoSet]
SET [ImageURL] = @ImageURL, [Name] = @Name
WHERE ([ID] = @ID)
----- End Table Manipulation -----

Return 0;
GO
/****** Object:  StoredProcedure [dbo].[update_OwnsIndividualBrick]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-----------------------
--
-- Upates the values of an entry in the OwnsIndividualBrick table using its Username and LegoBrick values to select which row.
-- Quantity and QuantityInUse can all be updated and are optional.
--
-----------------------
-- Demo:
-- 
-- DECLARE @Status SMALLINT
-- EXEC @Status = [update_OwnsIndividualBrick]  @Username = validationUser, @LegoBrick = '1234567/8900', @Quantity = 15, @QuantityInUse = 6
-- SELECT Status = @Status
-- 
-----------------------
-- Revision History
-- Created - 1/19/2021 - Luke Ferderer

CREATE PROCEDURE [dbo].[update_OwnsIndividualBrick]
(
	@Username dbo.Username,
	@LegoBrick dbo.BrickID,
	@Quantity int = NULL,
	@QuantityInUse int = NULL
)
AS
----- Validate Parameters -----
-- Ensure the @Username is not NULL
IF @Username IS NULL
BEGIN
	RAISERROR('The @Username is null. It must not be null', 14, 1);
	RETURN 1;
END
-- Ensure the @LegoBrick is not NULL
IF @LegoBrick IS NULL
BEGIN
	RAISERROR('The @LegoBrick is null. It must not be null', 14, 1);
	RETURN 2;
END
-- Ensure the @Quantity is not negative
IF @Quantity IS NOT NULL AND @Quantity < 0
BEGIN
	RAISERROR('The @Quantity is less than 0. It must not be less than 0', 14, 1);
	RETURN 3;
END
-- Ensure the @QuantityInUse is not NULL
IF @QuantityInUse IS NOT NULL AND @QuantityInUse < 0
BEGIN
	RAISERROR('The @QuantityInUse is less than 0. It must not be less than 0', 14, 1);
	RETURN 4;
END
-- Ensure an entry with Username @Username and LegoBrick @LegoBrick exists in the table
IF (SELECT Count(Username) FROM [OwnsIndividualBrick] WHERE Username = @Username AND LegoBrick = @LegoBrick) = 0
BEGIN
	RAISERROR('An entry with Username @Username and LegoBrick @LegoBrick does not exist in the table', 14, 1);
	RETURN 5;
END
----- End Validate Parameters -----

----- Optional Parameter Checks -----
-- If @ImageURL is NULL, set it to the ImageURL value currently in the table for the requested entry
IF @Quantity IS NULL
BEGIN
	SET @Quantity = (SELECT Quantity FROM [OwnsIndividualBrick] WHERE Username = @Username AND LegoBrick = @LegoBrick)
END
-- If @Name is NULL, set it to the Name value currently in the table for the requested entry
IF @QuantityInUse IS NULL
BEGIN
	SET @QuantityInUse = (SELECT QuantityInUse FROM [OwnsIndividualBrick] WHERE Username = @Username AND LegoBrick = @LegoBrick)
END
-- Ensure QuantityInUse is less or equal to Quantity
IF (@QuantityInUse > @Quantity)
BEGIN
	RAISERROR('@QuantityInUse is > @Quantity. This must not be the case', 14, 1);
	RETURN 6;
END
----- End Optional Parameter Checks -----

----- Table Manipulation -----
-- Update Order Detail values
UPDATE [OwnsIndividualBrick]
SET [Quantity] = @Quantity, [QuantityInUse] = @QuantityInUse
WHERE (Username = @Username AND LegoBrick = @LegoBrick)
----- End Table Manipulation -----

Return 0;
GO
/****** Object:  StoredProcedure [dbo].[update_OwnsSet]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[update_OwnsSet]
(
	@Username dbo.Username,
	@LegoSet varchar(20),
	@Quantity int,
	@QuantityBuilt int = 0
)
AS
----- Validate Parameters -----
-- Ensure the @ID is not NULL
IF @Username IS NULL
BEGIN
	RAISERROR('The @Username is null. It must not be null', 14, 1);
	RETURN 1;
END
-- Ensure the @LegoBrickID is not NULL
IF @LegoSet IS NULL
BEGIN
	RAISERROR('The @LegoSet is null. It must not be null', 14, 1);
	RETURN 2;
END
-- Ensure the @Quantity is not NULL
IF @Quantity IS NULL OR @Quantity < 0
BEGIN
	RAISERROR('The @Quantity is null or less than 0. It must not be null or less than 0', 14, 1);
	RETURN 3;
END
-- Ensure the @QuantityBuilt is not NULL
IF @QuantityBuilt IS NULL OR @QuantityBuilt < 0
BEGIN
	RAISERROR('The @QuantityBuilt is null or less than 0. It must not be null or less than 0', 14, 1);
	RETURN 4;
END
-- Ensure a user with Username @Username does exist in the User table
IF (SELECT Count(Username) FROM [User] WHERE Username = @Username) = 0
BEGIN
	RAISERROR('A user with the username @Username does not exist in the User table', 14, 1);
	RETURN 5;
END
-- Ensure a set with ID @LegoSet exists in the LegoSet table
IF (SELECT Count(ID) FROM [LegoSet] WHERE ID = @LegoSet) = 0
BEGIN
	RAISERROR('A brick with the ID @LegoSet does not exist in the LegoSet table', 14, 1);
	RETURN 6;
END
-- Ensure an entry with Username @Username and LegoBrick @LegoBrick exists in the table
IF (SELECT Count(Username) FROM [OwnsSet] WHERE Username = @Username AND LegoSet = @LegoSet) = 0
BEGIN
	RAISERROR('An entry with Username @Username and LegoSet @LegoSet does not already exist in the table', 14, 1);
	RETURN 7;
END
-- Ensure @QuantityBuilt is <= @Quantity
IF @QuantityBuilt > @Quantity
BEGIN
	RAISERROR('@QuantityBuilt is greater than @Quantity is must be less than or equal to @Quantity', 14, 1);
	RETURN 8;
END
----- End Validate Parameters -----

BEGIN TRANSACTION;
	----- Table Manipulation -----
	-- Inserts bricks in the set into OwnsIndividualBrick table
	DECLARE @SetQuantityChange int
	SET @SetQuantityChange = @Quantity - (SELECT Quantity FROM OwnsSet WHERE Username = @Username AND LegoSet = @LegoSet)
	DECLARE @BuiltQuantityChange int
	SET @BuiltQuantityChange = @QuantityBuilt - (SELECT QuantityBuilt FROM OwnsSet WHERE Username = @Username AND LegoSet = @LegoSet)
	DECLARE @CurrentBrick BrickID
	DECLARE @CurrentQuantityInUse int
	DECLARE @CurrentQuantity int
	DECLARE @i int
	SET @i = 0
	DECLARE @totalDistinctBricksInSet int
	SELECT @totalDistinctBricksInSet = count(LegoBrick) FROM [Contains] WHERE LegoSet = @LegoSet
	WHILE @i < @totalDistinctBricksInSet
	BEGIN
		SELECT @CurrentBrick = LegoBrick, @CurrentQuantity = Quantity * @SetQuantityChange, @CurrentQuantityInUse = Quantity * @BuiltQuantityChange
		FROM [Contains]
		WHERE LegoSet = @LegoSet
		ORDER BY LegoBrick
		OFFSET @i ROWS
		FETCH NEXT 1 ROWS ONLY
		SET @i = @i + 1

		IF(SELECT Count(Username) FROM [OwnsIndividualBrick] WHERE Username = @Username AND LegoBrick = @CurrentBrick) = 0
		BEGIN
			IF @CurrentQuantity > 0
			BEGIN
				DECLARE @Status SMALLINT
				EXEC @Status = [insert_OwnsIndividualBrick] @Username = @Username, @LegoBrick = @CurrentBrick, @Quantity = @CurrentQuantity, @QuantityInUse = @CurrentQuantityInUse
				IF (@Status <> 0)
				BEGIN
					RAISERROR('Error inserting bricks', 14, 1);
					ROLLBACK TRANSACTION
					return 9;
				END
			END
		END
		ELSE
		BEGIN
			DECLARE @NewQuantity int
			SELECT @NewQuantity = @CurrentQuantity + Quantity FROM OwnsIndividualBrick WHERE Username = @Username AND LegoBrick = @CurrentBrick
			DECLARE @NewQuantityInUse int
			SELECT @NewQuantityInUse = @CurrentQuantityInUse + QuantityInUse FROM OwnsIndividualBrick WHERE Username = @Username AND LegoBrick = @CurrentBrick
			DECLARE @Status2 SMALLINT
			IF (@NewQuantity <= 0)
			BEGIN
				EXEC @Status2 = [delete_OwnsIndividualBrick]  @Username = @Username, @LegoBrick = @CurrentBrick
			END
			ELSE
			BEGIN
				EXEC @Status2 = [update_OwnsIndividualBrick]  @Username = @Username, @LegoBrick = @CurrentBrick, @Quantity = @NewQuantity, @QuantityInUse = @NewQuantityInUse
			END
			IF (@Status2 <> 0)
			BEGIN
				RAISERROR('Error inserting bricks', 14, 1);
				ROLLBACK TRANSACTION
				return 10;
			END
		END
	END
	-- Inserts the requested data into the LegoBrick table
	UPDATE [OwnsSet]
	SET [Quantity] = @Quantity, [QuantityBuilt] = @QuantityBuilt
	WHERE Username = @Username AND LegoSet = @LegoSet
	----- End Table Manipulation -----
COMMIT TRANSACTION;
RETURN 0;
GO
/****** Object:  StoredProcedure [dbo].[update_User]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-----------------------
--
-- Upates the values of an entry in the User table using its Username value to select which row.
-- Password can be updated.
--
-----------------------
-- Demo:
-- 
-- DECLARE @Status SMALLINT
-- EXEC @Status = [insert_User] @Username = ferderl1, @Password = V3ryS3cur3Pa22w0rd
-- SELECT Status = @Status
-- 
-----------------------
-- Revision History
-- Created - 1/19/2021 - Luke Ferderer
-- Reoved FirstName and LastName - 1/22/2021 - Luke Ferderer

CREATE PROCEDURE [dbo].[update_User]
(
	@Username dbo.Username,
	@Password nvarchar(70)
)
AS
----- Validate Parameters -----
-- Ensure the @Username is not NULL
IF @Username IS NULL
BEGIN
	RAISERROR('The @Username is null. It must not be null', 14, 1);
	RETURN 1;
END
-- Ensure the @Password is not NULL
IF @Password IS NULL
BEGIN
	RAISERROR('The @Password is null. It must not be null', 14, 1);
	RETURN 2;
END
-- Ensure there exists an entry in the User table which has a Username of @Username
IF (SELECT Count(Username) FROM [User] WHERE Username = @Username) = 0
BEGIN
	RAISERROR('A user with Username @Username does not exist in User table', 14, 1);
	RETURN 3;
END
----- End Validate Parameters -----

----- Optional Parameter Checks -----
-- If @Password is NULL, set it to the Password value currently in the table for the user with Username @Username
IF (@Password IS NULL)
BEGIN
	SET @Password = (SELECT Password FROM [User] WHERE Username = @Username)
END
----- End Optional Parameter Checks -----

----- Table Manipulation -----
-- Update User values
UPDATE [User]
SET [Password] = @Password
WHERE ( [Username] = @Username)
----- End Table Manipulation -----

Return 0;
GO
/****** Object:  StoredProcedure [dbo].[update_WantsBrick]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-----------------------
--
-- Updates the values of an entry in the WantsSet table using its Username and LegoBrick values to select which row.
-- Quantity can be updated.
--
-----------------------
-----------------------
-- Revision History
-- Created - 1/19/2021 - Luke Ferderer

CREATE PROCEDURE [dbo].[update_WantsBrick]
(
	@Username dbo.Username,
	@LegoBrick BrickID,
	@Quantity int
)
AS
----- Validate Parameters -----
-- Ensure the @Username is not NULL
IF @Username IS NULL
BEGIN
	RAISERROR('The @Username is null. It must not be null', 14, 1);
	RETURN 1;
END
-- Ensure the @LegoBrick is not NULL
IF @LegoBrick IS NULL
BEGIN
	RAISERROR('The @LegoBrick is null. It must not be null', 14, 1);
	RETURN 2;
END
-- Ensure the @Quantity is not negative
IF @Quantity IS NULL OR @Quantity < 0
BEGIN
	RAISERROR('The @Quantity is null or less than 0. It must not be null or less than 0', 14, 1);
	RETURN 3;
END
-- Ensure an entry with Username @Username and LegoBrick @LegoBrick exists in the table
IF (SELECT Count(Username) FROM [WantsBrick] WHERE Username = @Username AND LegoBrick = @LegoBrick) = 0
BEGIN
	RAISERROR('An entry with Username @Username and LegoSet @LegoBrick does not exist in the table', 14, 1);
	RETURN 5;
END
----- End Validate Parameters -----

----- Table Manipulation -----
-- Update Order Detail values
UPDATE [WantsBrick]
SET [Quantity] = @Quantity
WHERE (Username = @Username AND LegoBrick = @LegoBrick)
----- End Table Manipulation -----

Return 0;
GO
/****** Object:  StoredProcedure [dbo].[update_WantsSet]    Script Date: 2/18/2021 10:27:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-----------------------
--
-- Upates the values of an entry in the WantsSet table using its Username and LegoSet values to select which row.
-- Quantity can be updated.
--
-----------------------
-- Demo:
-- 
-- DECLARE @Status SMALLINT
-- EXEC @Status = [update_WantsSet]  @Username = validationUser, @LegoSet = '1234567/8900', @Quantity = 15
-- SELECT Status = @Status
-- 
-----------------------
-- Revision History
-- Created - 2/12/2021 - Luke Ferderer

CREATE PROCEDURE [dbo].[update_WantsSet]
(
	@Username dbo.Username,
	@LegoSet varchar(20),
	@Quantity int
)
AS
----- Validate Parameters -----
-- Ensure the @Username is not NULL
IF @Username IS NULL
BEGIN
	RAISERROR('The @Username is null. It must not be null', 14, 1);
	RETURN 1;
END
-- Ensure the @LegoSet is not NULL
IF @LegoSet IS NULL
BEGIN
	RAISERROR('The @LegoSet is null. It must not be null', 14, 1);
	RETURN 2;
END
-- Ensure the @Quantity is not negative
IF @Quantity IS NULL OR @Quantity < 0
BEGIN
	RAISERROR('The @Quantity is null or less than 0. It must not be null or less than 0', 14, 1);
	RETURN 3;
END
-- Ensure an entry with Username @Username and LegoBrick @LegoBrick exists in the table
IF (SELECT Count(Username) FROM [WantsSet] WHERE Username = @Username AND LegoSet = @LegoSet) = 0
BEGIN
	RAISERROR('An entry with Username @Username and LegoBrick @LegoSet does not exist in the table', 14, 1);
	RETURN 5;
END
----- End Validate Parameters -----

----- Table Manipulation -----
-- Update Order Detail values
UPDATE [WantsSet]
SET [Quantity] = @Quantity
WHERE (Username = @Username AND LegoSet = @LegoSet)
----- End Table Manipulation -----

Return 0;
GO
USE [master]
GO
ALTER DATABASE [LegoInventoryTracker2] SET  READ_WRITE 
GO
