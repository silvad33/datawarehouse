CREATE TABLE [research].[PubsRecordFranchise]
(
	[PubsKey] int NOT NULL,
	[PubsFranchiseID] int NOT NULL,
	[DateCreated] datetime NOT NULL DEFAULT getdate(),
	[DateModified] datetime NULL
)
GO

ALTER TABLE [research].[PubsRecordFranchise] 
 ADD CONSTRAINT [PK_PubsRecordFranchiseMap]
	PRIMARY KEY CLUSTERED ([PubsKey] ASC,[PubsFranchiseID] ASC)
GO

ALTER TABLE [research].[PubsRecordFranchise] ADD CONSTRAINT [FK_PubsRecordFranchise_PubsFranchise]
	FOREIGN KEY ([PubsFranchiseID]) REFERENCES [research].[PubsFranchise] ([PubsFranchiseID]) ON DELETE Cascade ON UPDATE No Action
GO

ALTER TABLE [research].[PubsRecordFranchise] ADD CONSTRAINT [FK_PubsRecordFranchise_PubsRecord]
	FOREIGN KEY ([PubsKey]) REFERENCES [research].[PubsRecord] ([PubsKey]) ON DELETE Cascade ON UPDATE No Action
GO