USE [LegoInventoryTracker]
GO

/****** Object:  Table [dbo].[OwnsIndividualBrick]    Script Date: 2/11/2021 11:25:43 PM ******/
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

ALTER TABLE [dbo].[OwnsIndividualBrick]  WITH CHECK ADD FOREIGN KEY([LegoBrick])
REFERENCES [dbo].[LegoBrick] ([ID])
ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[OwnsIndividualBrick]  WITH CHECK ADD FOREIGN KEY([Username])
REFERENCES [dbo].[User] ([Username])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[OwnsIndividualBrick]  WITH CHECK ADD CHECK  (([Quantity]>(0)))
GO

ALTER TABLE [dbo].[OwnsIndividualBrick]  WITH CHECK ADD CHECK  (([QuantityInUse]>=(0)))
GO

ALTER TABLE [dbo].[OwnsIndividualBrick]  WITH CHECK ADD CHECK  (([QuantityInUse]<=[Quantity]))
GO

