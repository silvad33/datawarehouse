CREATE TABLE [research].[PubsLegacyLookup]
(
	[PubsId] int NOT NULL,
	[SpLegacyListId] int NOT NULL,
	[PubsKey] int NULL,
	[DateCreated] datetime NOT NULL DEFAULT getdate()
)
GO

ALTER TABLE [research].[PubsLegacyLookup] 
 ADD CONSTRAINT [PK_PubsLegacyLookup_PubsKey]
	PRIMARY KEY CLUSTERED ([PubsId] ASC)
GO