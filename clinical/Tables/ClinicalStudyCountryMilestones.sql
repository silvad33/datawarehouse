CREATE TABLE [clinical].[ClinicalStudyCountryMilestones]
(
	[ClinicalStudyCountryID] int NULL,
	[MilestoneName] varchar(500) NULL,
	[MilestoneOrder] varchar(50) NULL,
	[MilestonePlannedDate] date NULL,
	[MilestoneActualDate] date NULL,
	[MilestoneBaselineDate] date NULL,
	[CriticalMilestone] bit NULL,
	[ClinicalStudyCountryMilestonesID]  INT IDENTITY (1, 1) NOT NULL,
	[Country] varchar(50) NOT NULL,
	[ClinicalStudyID] int NULL,
	[ClinicalMilestoneGroupingID] int NULL,
	[ClinicalMilestoneNamesID] int NULL
)
GO

ALTER TABLE [clinical].[ClinicalStudyCountryMilestones] 
 ADD CONSTRAINT [PK_ClinicalStudyCountryMilestones]
	PRIMARY KEY CLUSTERED ([ClinicalStudyCountryMilestonesID] ASC)
GO

ALTER TABLE [clinical].[ClinicalStudyCountryMilestones] ADD CONSTRAINT [FK_ClinicalStudyCountryMilestones_ClinicalMilestoneNames]
	FOREIGN KEY ([ClinicalMilestoneNamesID]) REFERENCES [clinical].[ClinicalMilestoneNames] ([ClinicalMilestoneNamesID]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [clinical].[ClinicalStudyCountryMilestones] ADD CONSTRAINT [FK_ClinicalStudyCountryMilestones_ClinicalStudy]
	FOREIGN KEY ([ClinicalStudyID]) REFERENCES [clinical].[ClinicalStudy] ([ClinicalStudyID]) ON DELETE No Action ON UPDATE No Action
GO