CREATE TABLE [clinical].[ProjectPersonRoles]
(
	[ProjectRolesID] int NOT NULL,
	[RoleStartDate] date NOT NULL,
	[RoleEndDate] date NULL,
	[AuditCreatedDate] date NULL,
	[AuditCreatedBy] date NULL,
	[ProjectPersonsID] int NULL
)
GO

ALTER TABLE [clinical].[ProjectPersonRoles] ADD CONSTRAINT [FK_ProjectPersonRoles_ProjectPersons]
	FOREIGN KEY ([ProjectPersonsID]) REFERENCES [clinical].[ProjectPersons] ([ProjectPersonsID]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [clinical].[ProjectPersonRoles] ADD CONSTRAINT [FK_ProjectPersonRoles_ProjectRoles]
	FOREIGN KEY ([ProjectRolesID]) REFERENCES [clinical].[ProjectRoles] ([ProjectRolesID]) ON DELETE No Action ON UPDATE No Action
GO