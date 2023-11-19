CREATE TABLE [research].[PubsFunctionalArea]
(
	[PubsFunctionalAreaID] int NOT NULL,
	[Functional] varchar(255) NOT NULL,
	[Created] datetime NOT NULL,
	[Modified] datetime NULL,
	[DateCreated] datetime NOT NULL DEFAULT getdate(),
	[DateModified] datetime NULL
)
GO

ALTER TABLE [research].[PubsFunctionalArea] 
 ADD CONSTRAINT [PK_PubsFunctionalAreaID]
	PRIMARY KEY CLUSTERED ([PubsFunctionalAreaID] ASC)
GO