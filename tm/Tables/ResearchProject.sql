CREATE TABLE [TM].[ResearchProject]
(
	[ResearchProjectId] int NOT NULL IDENTITY (1, 1),
	[ionisTargetName] varchar(100) NOT NULL,
	[FranchiseId] int NULL,
	[FranchiseName] varchar(100) NULL,
	[CreatedBy] varchar(100) NULL,
	[CreatedDate] datetime NULL,
	[LastModifiedBy] varchar(100) NULL,
	[LastModifiedDate] datetime NULL
)
GO

ALTER TABLE [TM].[ResearchProject] 
 ADD CONSTRAINT [PK__Research__F2290364E3E9C091]
	PRIMARY KEY CLUSTERED ([ResearchProjectId] ASC)
GO

ALTER TABLE [TM].[ResearchProject] 
 ADD CONSTRAINT [UQ__Research__577F5E271B9C1E72] UNIQUE NONCLUSTERED ([ionisTargetName],[FranchiseId] ASC)
GO

ALTER TABLE [TM].[ResearchProject] ADD CONSTRAINT [FK__ResearchP__Franc__1DF12CC8]
	FOREIGN KEY ([FranchiseId]) REFERENCES [TM].[Franchise] ([FranchiseId]) ON DELETE No Action ON UPDATE No Action
GO