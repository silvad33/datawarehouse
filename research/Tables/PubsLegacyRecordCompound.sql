CREATE TABLE [research].[PubsLegacyRecordCompound]
(
	[ID] int NOT NULL,
	[PubsId] int NOT NULL,
	[PubsKey] int NULL,
	[CompoundNumber] varchar(255) NULL,
	[DateCreated] datetime NOT NULL,
	[DateModified] datetime NULL
)
GO