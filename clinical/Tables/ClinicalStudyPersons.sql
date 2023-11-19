CREATE TABLE [clinical].[ClinicalStudyPersons]
(
	[ClinicalProjectPersonsID] int NOT NULL IDENTITY (1, 1),
	[ClinicalProjectPersonName] varchar(500) NULL,
	[UserKey] int NULL,
	[ClinicalProjectRolesID] int NULL,
	[AuditCreatedDate] date NULL,
	[ClinicalProjectID] int NULL,
	[AuditCreatedBy] varchar(100) NULL
)
GO

ALTER TABLE [clinical].[ClinicalStudyPersons] 
 ADD CONSTRAINT [PK_ClinicalStudyPerson]
	PRIMARY KEY CLUSTERED ([ClinicalProjectPersonsID] ASC)
GO

ALTER TABLE [clinical].[ClinicalStudyPersons] ADD CONSTRAINT [FK_ClinicalStudyPersons_ClinicalStudy]
	FOREIGN KEY ([ClinicalProjectID]) REFERENCES [clinical].[ClinicalStudy] ([ClinicalStudyID]) ON DELETE No Action ON UPDATE No Action
GO
ALTER TABLE [clinical].[ClinicalStudyPersons] ADD CONSTRAINT [FK_ClinicalStudyPersons_DimUser]
	FOREIGN KEY ([UserKey]) REFERENCES [dbo].[DimUser] ([UserKey]) ON DELETE No Action ON UPDATE No Action
GO
