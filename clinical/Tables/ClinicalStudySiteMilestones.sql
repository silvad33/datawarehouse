CREATE TABLE [clinical].[ClinicalStudySiteMilestones]
(
	[ClinicalStudySiteID] int NULL,
	[MilestoneName] varchar(50) NULL,
	[MilestoneOrder] varchar(50) NULL,
	[MilestonePlannedDate] date NULL,
	[MilestoneActualDate] date NULL,
	[MilestoneBaselineDate] date NULL,
	[CriticalMilestone] binary(50) NULL,
	[ClinicalStudySiteMilestonesID] int NOT NULL IDENTITY (1, 1),
	[ClinicalStudySitesID] int NULL
)
GO

ALTER TABLE [clinical].[ClinicalStudySiteMilestones] 
 ADD CONSTRAINT [PK_ClinicalStudySiteMilestones]
	PRIMARY KEY CLUSTERED ([ClinicalStudySiteMilestonesID] ASC)
GO

ALTER TABLE [clinical].[ClinicalStudySiteMilestones] ADD CONSTRAINT [FK_ClinicalStudySiteMilestones_ClinicalStudySites]
	FOREIGN KEY ([ClinicalStudySitesID]) REFERENCES [clinical].[ClinicalStudySites] ([ClinicalStudySitesID]) ON DELETE No Action ON UPDATE No Action
GO