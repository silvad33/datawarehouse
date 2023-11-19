CREATE TABLE [TM].[ResearchProjectMilestones]
(
	[ResearchProjectMilestoneId] int NOT NULL IDENTITY (1, 1),
	[ResearchProjectMilestoneTypeId] int NOT NULL,
	[ResearchProjectId] int NULL,
	[MilestoneDesc] varchar(255) NULL,
	[MilestoneEstDate] varchar(255) NULL,
	[StartDate] datetime NOT NULL,
	[EndDate] datetime NOT NULL,
	[IsCurrent] bit NOT NULL,
	[CreatedBy] varchar(100) NULL,
	[CreatedDate] datetime NULL,
	[LastModifiedBy] varchar(100) NULL,
	[LastModifiedDate] datetime NULL
)
GO

ALTER TABLE [TM].[ResearchProjectMilestones] 
 ADD CONSTRAINT [PK__Research__48F046C7F13CCD9C]
	PRIMARY KEY CLUSTERED ([ResearchProjectMilestoneId] ASC)
GO

ALTER TABLE [TM].[ResearchProjectMilestones] ADD CONSTRAINT [FK__ResearchP__Miles__3C75B3E8]
	FOREIGN KEY ([ResearchProjectMilestoneTypeId]) REFERENCES [TM].[ResearchProjectMilestoneType] ([ResearchProjectMilestoneTypeId]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [TM].[ResearchProjectMilestones] ADD CONSTRAINT [FK__ResearchP__Resea__3D69D821]
	FOREIGN KEY ([ResearchProjectId]) REFERENCES [TM].[ResearchProject] ([ResearchProjectId]) ON DELETE No Action ON UPDATE No Action
GO