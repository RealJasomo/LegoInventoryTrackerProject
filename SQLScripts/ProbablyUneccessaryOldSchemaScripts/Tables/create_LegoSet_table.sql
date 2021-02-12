USE [LegoInventoryTracker]
GO

/****** Object:  Table [dbo].[LegoSet]    Script Date: 2/11/2021 11:25:17 PM ******/
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
