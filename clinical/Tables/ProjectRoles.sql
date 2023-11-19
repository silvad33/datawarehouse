CREATE TABLE [clinical].[ProjectRoles]
(
	[ProjectRolesID] int NOT NULL IDENTITY (1, 1),
	[ProjectRoleName] varchar(100) NULL,	-- Name of ClinicalProject Role
	[AuditCreatedDate] date NULL,
	[AuditCreateBy] varchar(100) NULL
)
GO

ALTER TABLE [clinical].[ProjectRoles] 
 ADD CONSTRAINT [PK_ProjectRoles]
	PRIMARY KEY CLUSTERED ([ProjectRolesID] ASC)
GO

EXEC sp_addextendedproperty 'MS_Description', 'Name of ClinicalProject Role', 'Schema', [clinical], 'table', [ProjectRoles], 'column', [ProjectRoleName]
GO