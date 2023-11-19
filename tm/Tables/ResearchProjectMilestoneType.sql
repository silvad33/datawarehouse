CREATE TABLE [TM].[ResearchProjectMilestoneType]
(
	[ResearchProjectMilestoneTypeId] int NOT NULL IDENTITY (1, 1),
	[ResearchProjectMilestoneTypeName] varchar(255) NOT NULL,
	[CreatedBy] varchar(100) NULL,
	[CreatedDate] datetime NULL,
	[Lastmodifiedby] varchar(100) NULL,
	[LastmodifiedDate] datetime NULL
)
GO

ALTER TABLE [TM].[ResearchProjectMilestoneType] 
 ADD CONSTRAINT [PK__Mileston__B88C49913FC2186B]
	PRIMARY KEY CLUSTERED ([ResearchProjectMilestoneTypeId] ASC)
GO