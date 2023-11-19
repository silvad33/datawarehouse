CREATE TABLE [clinical].[ClinicalMilestoneNames]
(
	[MilestoneLevel] varchar(50) NULL,
	[MilestoneName] varchar(500) NULL,
	[ClinicalMilestoneNamesID]  INT IDENTITY (1, 1) NOT NULL,
	[ClinicalMilestoneGroupsID] INT NULL
)
GO

ALTER TABLE [clinical].[ClinicalMilestoneNames] 
 ADD CONSTRAINT [PK_ClinicalMilestoneNames]
	PRIMARY KEY CLUSTERED ([ClinicalMilestoneNamesID] ASC)
GO

ALTER TABLE [clinical].[ClinicalMilestoneNames] ADD CONSTRAINT [FK_ClinicalMilestoneNames_ClinicalMilestoneGroups]
	FOREIGN KEY ([ClinicalMilestoneGroupsID]) REFERENCES [clinical].[ClinicalMilestoneGroups] ([ClinicalMilestoneGroupsID]) ON DELETE No Action ON UPDATE No Action
GO