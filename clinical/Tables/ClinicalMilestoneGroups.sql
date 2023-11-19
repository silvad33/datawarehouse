CREATE TABLE [clinical].[ClinicalMilestoneGroups]
(
	[ClinicalMilestoneAbbreviation] varchar(50) NULL,
	[ClinicalMilestoneGroup] varchar(150) NULL,
	[ClinicalMilestoneGroupsID] INT IDENTITY (1, 1) NOT NULL
)
GO

ALTER TABLE [clinical].[ClinicalMilestoneGroups] 
 ADD CONSTRAINT [PK_ClinicalMilestoneGroups]
	PRIMARY KEY CLUSTERED ([ClinicalMilestoneGroupsID] ASC) 
GO