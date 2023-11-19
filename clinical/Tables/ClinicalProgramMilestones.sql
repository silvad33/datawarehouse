CREATE TABLE [clinical].[ClinicalProgramMilestones]
(
	[ClinicalProgramID] int NULL,
	[MilestoneName] varchar(500) NULL,
	[MilestoneOrder] varchar(50) NULL,
	[MilestonePlannedDate] date NULL,
	[MilestoneActualDate] date NULL,
	[MilestoneBaselineDate] date NULL,
	[CriticalMilestone] bit NULL,
	[ClinicalProgramMilestonesID]  INT IDENTITY (1, 1) NOT NULL,
	[ClinicalProgramsID] int NULL,
	[ClinicalMilestoneGroupingID] int NULL,
	[ClinicalMilestoneNamesID] int NULL
)
GO

ALTER TABLE [clinical].[ClinicalProgramMilestones] 
 ADD CONSTRAINT [PK_ClinicalProgramMilestones]
	PRIMARY KEY CLUSTERED ([ClinicalProgramMilestonesID] ASC)
GO

ALTER TABLE [clinical].[ClinicalProgramMilestones] ADD CONSTRAINT [FK_ClinicalProgramMilestones_ClinicalMilestoneNames]
	FOREIGN KEY ([ClinicalMilestoneNamesID]) REFERENCES [clinical].[ClinicalMilestoneNames] ([ClinicalMilestoneNamesID]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [clinical].[ClinicalProgramMilestones] ADD CONSTRAINT [FK_ClinicalProgramMilestones_ClinicalPrograms]
	FOREIGN KEY ([ClinicalProgramsID]) REFERENCES [clinical].[ClinicalPrograms] ([ClinicalProgramsID]) ON DELETE No Action ON UPDATE No Action
GO