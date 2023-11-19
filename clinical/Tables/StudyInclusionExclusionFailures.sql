CREATE TABLE [clinical].[StudyInclusionExclusionFailures]
( 
	[StudySiteSubjectsID] int NOT NULL,
	[StudyInclusionExclusionFailuresID] int  IDENTITY (1, 1) NOT NULL,
	[StudyInclusionExclusionCriteriaID] int NOT NULL
)
GO

ALTER TABLE [clinical].[StudyInclusionExclusionFailures] 
 ADD CONSTRAINT [PK_StudyInclusionExclusionFailures]
	PRIMARY KEY CLUSTERED ([StudyInclusionExclusionFailuresID] ASC)
GO

ALTER TABLE [clinical].[StudyInclusionExclusionFailures] ADD CONSTRAINT [FK_StudyInclusionExclusionFailures_StudyInclusionExclusionCriteria]
	FOREIGN KEY ([StudyInclusionExclusionCriteriaID]) REFERENCES [clinical].[StudyInclusionExclusionCriteria] ([StudyInclusionExclusionCriteriaID]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [clinical].[StudyInclusionExclusionFailures] ADD CONSTRAINT [FK_StudyInclusionExclusionFailures_StudySiteSubjects]
	FOREIGN KEY ([StudySiteSubjectsID]) REFERENCES [clinical].[StudySiteSubjects] ([StudySiteSubjectsID]) ON DELETE No Action ON UPDATE No Action
GO