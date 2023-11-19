CREATE TABLE [clinical].[StudyInclusionExclusionCriteria]
(
	[ClinicalStudyID] int NOT NULL,
	[StudyInclusionExclusionCriteriaID] int NOT NULL IDENTITY (1, 1),
	[IECategory] varchar(500) NOT NULL,
	[IETestCode] varchar(500) NOT NULL,
	[IETestDescription] varchar(1000) NULL
)
GO

ALTER TABLE [clinical].[StudyInclusionExclusionCriteria] 
 ADD CONSTRAINT [PK_StudyInclusionExclusionCriteria]
	PRIMARY KEY CLUSTERED ([StudyInclusionExclusionCriteriaID] ASC)
GO

ALTER TABLE [clinical].[StudyInclusionExclusionCriteria] ADD CONSTRAINT [FK_StudyInclusionExclusionCriteria_ClinicalStudy]
	FOREIGN KEY ([ClinicalStudyID]) REFERENCES [clinical].[ClinicalStudy] ([ClinicalStudyID]) ON DELETE No Action ON UPDATE No Action
GO