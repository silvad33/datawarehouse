CREATE TABLE [clinical].[ClinicalStudyRoles]
(
	[ClinicalStudyRolesID] int NOT NULL IDENTITY (1, 1),
	[ClinicalStudyRoleName] varchar(50) NULL,	-- Name of a clinical study-level role. Distinct from a project- or site-level role
	[AuditCreatedDate] date NULL,	-- Date record created
	[AuditCreatedBy] varchar(10) NULL	-- Record create by
)
GO

ALTER TABLE [clinical].[ClinicalStudyRoles] 
 ADD CONSTRAINT [PK_ClinicalStudyRoles]
	PRIMARY KEY CLUSTERED ([ClinicalStudyRolesID] ASC)
GO

EXEC sp_addextendedproperty 'MS_Description', 'Name of a clinical study-level role. Distinct from a project- or site-level role', 'Schema', [clinical], 'table', [ClinicalStudyRoles], 'column', [ClinicalStudyRoleName]
GO

EXEC sp_addextendedproperty 'MS_Description', 'Date record created', 'Schema', [clinical], 'table', [ClinicalStudyRoles], 'column', [AuditCreatedDate]
GO

EXEC sp_addextendedproperty 'MS_Description', 'Record create by', 'Schema', [clinical], 'table', [ClinicalStudyRoles], 'column', [AuditCreatedBy]
GO