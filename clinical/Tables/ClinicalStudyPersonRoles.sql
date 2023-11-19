CREATE TABLE [clinical].[ClinicalStudyPersonRoles]
(
	[ClinicalStudyRolesID] int NOT NULL,
	[RoleStartDate] date NOT NULL,
	[RoleEndDate] date NULL,
	[AuditCreatedDate] date NULL,
	[AuditCreatedBy] date NULL,
	[ClinicalStudyPersonsID] int NULL
)
GO

ALTER TABLE [clinical].[ClinicalStudyPersonRoles] ADD CONSTRAINT [FK_ClinicalStudyPersonRoles_ClinicalStudyPersons]
	FOREIGN KEY ([ClinicalStudyPersonsID]) REFERENCES [clinical].[ClinicalStudyPersons] ([ClinicalProjectPersonsID]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [clinical].[ClinicalStudyPersonRoles] ADD CONSTRAINT [FK_ClinicalStudyPersonRoles_ClinicalStudyRoles]
	FOREIGN KEY ([ClinicalStudyRolesID]) REFERENCES [clinical].[ClinicalStudyRoles] ([ClinicalStudyRolesID]) ON DELETE No Action ON UPDATE No Action
GO