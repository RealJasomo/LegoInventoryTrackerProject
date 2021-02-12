USE [LegoInventoryTracker]
GO

/****** Object:  Table [dbo].[ModelContains]    Script Date: 2/11/2021 11:25:29 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ModelContains](
	[Model] [int] NOT NULL,
	[LegoBrick] [dbo].[BrickID] NOT NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK_ModelContains_1] PRIMARY KEY CLUSTERED 
(
	[Model] ASC,
	[LegoBrick] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[ModelContains]  WITH CHECK ADD FOREIGN KEY([LegoBrick])
REFERENCES [dbo].[LegoBrick] ([ID])
ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[ModelContains]  WITH CHECK ADD FOREIGN KEY([Model])
REFERENCES [dbo].[LegoModel] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[ModelContains]  WITH CHECK ADD CHECK  (([LegoBrick] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9]' OR [LegoBrick] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9][0-9]' OR [LegoBrick] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9][0-9][0-9]' OR [LegoBrick] like '[0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9]' OR [LegoBrick] like '[0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9][0-9]' OR [LegoBrick] like '[0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9][0-9][0-9]' OR [LegoBrick] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9]' OR [LegoBrick] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9][0-9]' OR [LegoBrick] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9][0-9][0-9]'))
GO

ALTER TABLE [dbo].[ModelContains]  WITH CHECK ADD CHECK  (([Quantity]>(0)))
GO

