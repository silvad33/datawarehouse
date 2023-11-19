CREATE TABLE [clinical].[ClinicalStudyMilestones_rev]
(
	[ClinicalStudyID] int NULL,
	[MilestoneName] varchar(500) NULL,
	[MilestoneOrder] varchar(50) NULL,
	[MilestonePlannedDate] date NULL,
	[MilestoneActualDate] date NULL,
	[MilestoneBaselineDate] date NULL,
	[CriticalMilestone] bit NULL,
	[ClinicalStudyMilestones_revID]  INT IDENTITY (1, 1) NOT NULL,
	[adhocEvent] bit NULL,
	[ClinicalMilestoneGroupingID] int NULL,
	[ClinicalMilestoneNamesID] int NULL
)
GO

ALTER TABLE [clinical].[ClinicalStudyMilestones_rev] 
 ADD CONSTRAINT [PK_ClinicalStudyMilestones_rev]
	PRIMARY KEY CLUSTERED ([ClinicalStudyMilestones_revID] ASC)
GO

ALTER TABLE [clinical].[ClinicalStudyMilestones_rev] ADD CONSTRAINT [FK_ClinicalStudyMilestones_rev_ClinicalMilestoneNames]
	FOREIGN KEY ([ClinicalMilestoneGroupingID]) REFERENCES [clinical].[ClinicalMilestoneNames] ([ClinicalMilestoneNamesID]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [clinical].[ClinicalStudyMilestones_rev] ADD CONSTRAINT [FK_ClinicalStudyMilestones_rev_ClinicalStudy]
	FOREIGN KEY ([ClinicalStudyID]) REFERENCES [clinical].[ClinicalStudy] ([ClinicalStudyID]) ON DELETE No Action ON UPDATE No Action
GO