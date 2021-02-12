USE [LegoInventoryTracker]
GO

/****** Object:  Table [dbo].[WantsSet]    Script Date: 2/11/2021 11:26:27 PM ******/
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

ALTER TABLE [dbo].[WantsSet]  WITH CHECK ADD FOREIGN KEY([LegoSet])
REFERENCES [dbo].[LegoSet] ([ID])
GO

ALTER TABLE [dbo].[WantsSet]  WITH CHECK ADD FOREIGN KEY([Username])
REFERENCES [dbo].[User] ([Username])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[WantsSet]  WITH CHECK ADD CHECK  (([Quantity]>(0)))
GO

