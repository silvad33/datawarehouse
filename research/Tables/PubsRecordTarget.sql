CREATE TABLE [research].[PubsRecordTarget]
(
	[ID] int NOT NULL IDENTITY (1, 1),
	[PubsKey] int NOT NULL,
	[Ensembl_Id] varchar(100) NOT NULL,
	[SelectedTerm] varchar(50) NULL,
	[DateCreated] datetime NOT NULL DEFAULT getdate(),
	[DateModified] datetime NULL
)
GO

ALTER TABLE [research].[PubsRecordTarget] 
 ADD CONSTRAINT [PK__PubsReco__3214EC27159099A2]
	PRIMARY KEY CLUSTERED ([ID] ASC)
GO

ALTER TABLE [research].[PubsRecordTarget] ADD CONSTRAINT [FK_PubsRecordTarget_PubsRecord]
	FOREIGN KEY ([PubsKey]) REFERENCES [research].[PubsRecord] ([PubsKey]) ON DELETE Cascade ON UPDATE No Action
GO