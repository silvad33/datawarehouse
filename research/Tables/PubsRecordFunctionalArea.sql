CREATE TABLE [research].[PubsRecordFunctionalArea]
(
	[PubsKey] int NOT NULL,
	[PubsFunctionalAreaID] int NOT NULL,
	[DateCreated] datetime NOT NULL DEFAULT getdate(),
	[DateModified] datetime NULL
)
GO

ALTER TABLE [research].[PubsRecordFunctionalArea] 
 ADD CONSTRAINT [PK_PubsRecordFunctionalAreaMap]
	PRIMARY KEY CLUSTERED ([PubsKey] ASC,[PubsFunctionalAreaID] ASC)
GO

ALTER TABLE [research].[PubsRecordFunctionalArea] ADD CONSTRAINT [FK_PubsRecordFunctionalArea_PubsFunctionalArea]
	FOREIGN KEY ([PubsFunctionalAreaID]) REFERENCES [research].[PubsFunctionalArea] ([PubsFunctionalAreaID]) ON DELETE Cascade ON UPDATE No Action
GO

ALTER TABLE [research].[PubsRecordFunctionalArea] ADD CONSTRAINT [FK_PubsRecordFunctionalArea_PubsRecord]
	FOREIGN KEY ([PubsKey]) REFERENCES [research].[PubsRecord] ([PubsKey]) ON DELETE Cascade ON UPDATE No Action
GO