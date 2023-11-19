CREATE TABLE [TM].[Indications]
(
	[IndicationName] varchar(255) NOT NULL,
	[SNOMEDKey] varchar(255) NULL,
	[MedDRAKey] varchar(255) NULL,
	[SNOMEDName] varchar(255) NULL,
	[MedDRAName] varchar(255) NULL,
	[ResearchProjectId] int NULL,
	[CreatedBy] varchar(100) NULL,
	[CreatedDate] datetime NULL,
	[LastModifiedBy] varchar(100) NULL,
	[LastModifiedDate] datetime NULL,
	[IndicationsID] int NOT NULL IDENTITY(1,1)
)
GO

ALTER TABLE [TM].[Indications] 
 ADD CONSTRAINT [PK_Indications]
	PRIMARY KEY CLUSTERED ([IndicationsID] ASC)
GO