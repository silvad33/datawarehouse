CREATE TABLE [clinical].[ClinicalPrograms]
(
	[ProgramName] varchar(50) NULL,
	[Compound] varchar(50) NULL,
	[Franchise] varchar(50) NULL,
	[Indication] varchar(500) NULL,
	[GeneTarget] varchar(500) NULL,
	[Partner] varchar(500) NULL,
	[ProjectManager] varchar(500) NULL,
	[ProjectCode] varchar(500) NULL,
	[RMCCandidateSelectionDate] varchar(500) NULL,
	[ClinicalStatus] varchar(500) NULL,
	[ChemistryType] varchar(500) NULL,
	[PartnerName] varchar(500) NULL,
	[ClinicalProgramsID] int NOT NULL IDENTITY (1, 1)
)
GO

ALTER TABLE [clinical].[ClinicalPrograms] 
 ADD CONSTRAINT [PK_ClinicalPrograms]
	PRIMARY KEY CLUSTERED ([ClinicalProgramsID] ASC)
GO