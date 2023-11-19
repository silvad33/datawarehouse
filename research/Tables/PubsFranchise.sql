CREATE TABLE [research].[PubsFranchise]
(
	[PubsFranchiseID] int NOT NULL,
	[Franchise] varchar(255) NOT NULL,
	[Created] datetime NOT NULL,
	[Modified] datetime NULL,
	[DateCreated] datetime NOT NULL DEFAULT getdate(),
	[DateModified] datetime NULL,
	[Notes] varchar(100) NULL,
	[LegacyID] int NULL
)
GO

ALTER TABLE [research].[PubsFranchise] 
 ADD CONSTRAINT [PK_PubsFranchiseID]
	PRIMARY KEY CLUSTERED ([PubsFranchiseID] ASC)
GO