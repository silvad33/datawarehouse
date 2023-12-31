/* ---------------------------------------------------- */
/*  Generated by Enterprise Architect Version 15.2 		*/
/*  Created On : 18-Jan-2021 12:01:18 PM 				*/
/*  DBMS       : SQL Server 2012 						*/
/* ---------------------------------------------------- */

/* Drop Foreign Key Constraints */


/* Create Tables */

CREATE TABLE [shared].[Organization]
(
	[OrgName] varchar(2000) NULL,
	[SupplierKey] varchar(2000) NULL,
	[OrganizationID] int NOT NULL IDENTITY (1, 1),
	[ClinicalOrganizationID] int NULL,
	[LegalOrganizationID] int NULL
)
GO

/* Create Primary Keys, Indexes, Uniques, Checks */

ALTER TABLE [shared].[Organization] 
 ADD CONSTRAINT [PK_Organization]
	PRIMARY KEY CLUSTERED ([OrganizationID] ASC)
GO

/* Create Foreign Key Constraints */

ALTER TABLE [shared].[Organization] ADD CONSTRAINT [FK_Organization_LegalOrganization]
	FOREIGN KEY ([LegalOrganizationID]) REFERENCES [legal].[LegalOrganization] ([LegalOrganizationID]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [shared].[Organization] ADD CONSTRAINT [FK_Organization_ClinicalOrganization]
	FOREIGN KEY ([ClinicalOrganizationID]) REFERENCES [clinical].[ClinicalOrganization] ([ClinicalOrganizationID]) ON DELETE No Action ON UPDATE No Action
GO