CREATE TABLE [research].[PubsRecordCompound]
(
	[ID] int NOT NULL IDENTITY (1, 1),
	[PubsKey] int NOT NULL,
	[CompoundNumber] varchar(255) NOT NULL,
	[DateCreated] datetime NOT NULL DEFAULT getdate()
)
GO

ALTER TABLE [research].[PubsRecordCompound] 
 ADD CONSTRAINT [PK__PubsReco__3214EC27BF4E189E]
	PRIMARY KEY CLUSTERED ([ID] ASC)
GO

ALTER TABLE [research].[PubsRecordCompound] ADD CONSTRAINT [FK_PubsRecordCompound_PubsRecord]
	FOREIGN KEY ([PubsKey]) REFERENCES [research].[PubsRecord] ([PubsKey]) ON DELETE Cascade ON UPDATE No Action
GO