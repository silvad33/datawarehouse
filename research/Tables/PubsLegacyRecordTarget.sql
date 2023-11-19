CREATE TABLE [research].[PubsLegacyRecordTarget]
(
	[ID] int NOT NULL,
	[PubsId] int NOT NULL,
	[PubsKey] int NULL,
	[Ensembl_Id] varchar(100) NOT NULL,
	[PrimarySymbol] varchar(50) NULL,
	[DateCreated] datetime NOT NULL,
	[DateModified] datetime NULL
)
GO