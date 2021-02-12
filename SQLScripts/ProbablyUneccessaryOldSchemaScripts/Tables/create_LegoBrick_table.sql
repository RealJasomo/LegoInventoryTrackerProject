USE [LegoInventoryTracker]
GO

/****** Object:  Table [dbo].[LegoBrick]    Script Date: 2/11/2021 11:24:55 PM ******/
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

ALTER TABLE [dbo].[LegoBrick]  WITH CHECK ADD CHECK  (([ID] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9]' OR [ID] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9][0-9]' OR [ID] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9][0-9][0-9]' OR [ID] like '[0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9]' OR [ID] like '[0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9][0-9]' OR [ID] like '[0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9][0-9][0-9]' OR [ID] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9]' OR [ID] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9][0-9]' OR [ID] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]/[0-9][0-9][0-9][0-9][0-9][0-9]'))
GO

