CREATE TABLE [clinical].[ClinicalStudyMilestones]
(
	[ClinicalStudyID] int NULL,
	[MilestoneName] varchar(500) NULL,
	[MilestoneOrder] varchar(50) NULL,
	[MilestonePlannedDate] date NULL,
	[MilestoneActualDate] date NULL,
	[MilestoneBaselineDate] date NULL,
	[CriticalMilestone] bit NULL,
	[ClinicalStudyMilestonesID] int NOT NULL IDENTITY (1, 1),
	[adhocEvent] bit NULL,
	[ClinicalMilestoneNamesID] int NULL,
	[ClinicalMilestoneGroupingID] int NULL
)
GO

ALTER TABLE [clinical].[ClinicalStudyMilestones] 
 ADD CONSTRAINT [PK_ClinicalStudyMilestones]
	PRIMARY KEY CLUSTERED ([ClinicalStudyMilestonesID] ASC)
GO

ALTER TABLE [clinical].[ClinicalStudyMilestones] ADD CONSTRAINT [FK_ClinicalStudyMilestones_ClinicalMilestoneNames]
	FOREIGN KEY ([ClinicalMilestoneNamesID]) REFERENCES [clinical].[ClinicalMilestoneNames] ([ClinicalMilestoneNamesID]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [clinical].[ClinicalStudyMilestones] ADD CONSTRAINT [FK_ClinicalStudyMilestones_ClinicalStudy]
	FOREIGN KEY ([ClinicalStudyID]) REFERENCES [clinical].[ClinicalStudy] ([ClinicalStudyID]) ON DELETE No Action ON UPDATE No Action
GO