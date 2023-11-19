CREATE TABLE [clinical].[ProjectPersons]
(
	[ProjectPersonsID] int NOT NULL IDENTITY (1, 1),
	[ProjectPersonName] varchar(500) NULL,
	[UserKey] int NULL,
	[ProjectRolesID] int NULL,
	[AuditCreatedDate] date NULL,
	[ProjectID] int NULL,
	[AuditCreatedBy] varchar(100) NULL,
	[ClinicalProgramsID] int NULL
)
GO

ALTER TABLE [clinical].[ProjectPersons] 
 ADD CONSTRAINT [PK_ClinicalProjectPerson]
	PRIMARY KEY CLUSTERED ([ProjectPersonsID] ASC)
GO

ALTER TABLE [clinical].[ProjectPersons] ADD CONSTRAINT [FK_ClinicaProjectPersons_ClinicalPrograms]
	FOREIGN KEY ([ClinicalProgramsID]) REFERENCES [clinical].[ClinicalPrograms] ([ClinicalProgramsID]) ON DELETE No Action ON UPDATE No Action
GO