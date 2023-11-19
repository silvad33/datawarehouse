CREATE TABLE [TM].[Franchise]
(
	[FranchiseId] int NOT NULL IDENTITY (1, 1),
	[FranchiseName] varchar(100) NULL
)
GO

ALTER TABLE [TM].[Franchise] 
 ADD CONSTRAINT [PK__Franchis__9D1246E0B493247B]
	PRIMARY KEY CLUSTERED ([FranchiseId] ASC)
GO