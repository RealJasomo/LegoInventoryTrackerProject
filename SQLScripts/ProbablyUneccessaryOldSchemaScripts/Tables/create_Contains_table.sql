USE [LegoInventoryTracker]
GO

/****** Object:  Table [dbo].[Contains]    Script Date: 2/11/2021 11:24:30 PM ******/
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

ALTER TABLE [dbo].[Contains]  WITH CHECK ADD FOREIGN KEY([LegoBrick])
REFERENCES [dbo].[LegoBrick] ([ID])
ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[Contains]  WITH CHECK ADD FOREIGN KEY([LegoSet])
REFERENCES [dbo].[LegoSet] ([ID])
GO

ALTER TABLE [dbo].[Contains]  WITH CHECK ADD CHECK  (([LegoBrick] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9]' OR [LegoBrick] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9][0-9]' OR [LegoBrick] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9][0-9][0-9]' OR [LegoBrick] like '[0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9]' OR [LegoBrick] like '[0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9][0-9]' OR [LegoBrick] like '[0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9][0-9][0-9]' OR [LegoBrick] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9]' OR [LegoBrick] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9][0-9]' OR [LegoBrick] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9][0-9][0-9]'))
GO

ALTER TABLE [dbo].[Contains]  WITH CHECK ADD CHECK  (([Quantity]>(0)))
GO

