CREATE TABLE [research].[PubsLegacyCompoundsTemp]
(
	[Compound] varchar(100) NOT NULL,
	[PrimaryGeneTerm] varchar(100) NULL,
	[DateCreated] datetime NOT NULL DEFAULT getdate(),
	[ProcessedVal] int NULL,
	[Ensembl_Id] varchar(50) NULL
)
GO

ALTER TABLE [research].[PubsLegacyCompoundsTemp] 
 ADD CONSTRAINT [PK_PubsLegacyCompoundsTempCompound]
	PRIMARY KEY CLUSTERED ([Compound] ASC)
GO