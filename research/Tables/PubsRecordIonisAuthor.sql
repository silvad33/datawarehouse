CREATE TABLE [research].[PubsRecordIonisAuthor]
(
	[PubsKey] int NOT NULL,
	[IonisAuthorKey] int NOT NULL,
	[DateCreated] datetime NOT NULL DEFAULT getdate(),
	[DateModified] datetime NULL
)
GO

ALTER TABLE [research].[PubsRecordIonisAuthor] 
 ADD CONSTRAINT [PK_PubsInoisAuthorMap]
	PRIMARY KEY CLUSTERED ([PubsKey] ASC,[IonisAuthorKey] ASC)
GO

ALTER TABLE [research].[PubsRecordIonisAuthor] ADD CONSTRAINT [FK_PubsRecordIonisAuthor_IonisAuthor]
	FOREIGN KEY ([IonisAuthorKey]) REFERENCES [dbo].[DimUser] ([UserKey]) ON DELETE Cascade ON UPDATE No Action
GO

ALTER TABLE [research].[PubsRecordIonisAuthor] ADD CONSTRAINT [FK_PubsRecordIonisAuthor_PubsRecord]
	FOREIGN KEY ([PubsKey]) REFERENCES [research].[PubsRecord] ([PubsKey]) ON DELETE Cascade ON UPDATE No Action
GO