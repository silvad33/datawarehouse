CREATE TABLE [clinical].[StudySiteSubjects]
(
	[ClinicalStudySitesID] int NOT NULL,
	[StudySubjectID] varchar(500) NULL,
	[StudySiteSubjectsID] int NOT NULL IDENTITY (1, 1),
	[StudySiteScreeningID] varchar(500) NOT NULL
)
GO

ALTER TABLE [clinical].[StudySiteSubjects] 
 ADD CONSTRAINT [PK_StudySiteSubjects]
	PRIMARY KEY CLUSTERED ([StudySiteSubjectsID] ASC)
GO

ALTER TABLE [clinical].[StudySiteSubjects] ADD CONSTRAINT [FK_StudySiteSubjects_ClinicalStudySites]
	FOREIGN KEY ([ClinicalStudySitesID]) REFERENCES [clinical].[ClinicalStudySites] ([ClinicalStudySitesID]) ON DELETE No Action ON UPDATE No Action
GO