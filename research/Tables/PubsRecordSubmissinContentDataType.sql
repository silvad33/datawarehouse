CREATE TABLE [research].[PubsRecordSubmissinContentDataType]
(
	[PubsKey] int NOT NULL,
	[PubsSubmissionContentDataTypeID] int NOT NULL,
	[DateCreated] datetime NOT NULL DEFAULT getdate(),
	[DateModified] datetime NULL
)
GO

ALTER TABLE [research].[PubsRecordSubmissinContentDataType] 
 ADD CONSTRAINT [PK_PubsSubmissionContentDataTypeMap]
	PRIMARY KEY CLUSTERED ([PubsKey] ASC,[PubsSubmissionContentDataTypeID] ASC)
GO

ALTER TABLE [research].[PubsRecordSubmissinContentDataType] ADD CONSTRAINT [FK_PubsRecordSubmissinContentDataType_PubsRecord]
	FOREIGN KEY ([PubsKey]) REFERENCES [research].[PubsRecord] ([PubsKey]) ON DELETE Cascade ON UPDATE No Action
GO

ALTER TABLE [research].[PubsRecordSubmissinContentDataType] ADD CONSTRAINT [FK_PubsRecordSubmissinContentDataType_PubsSubmissionContentDataType]
	FOREIGN KEY ([PubsSubmissionContentDataTypeID]) REFERENCES [research].[PubsSubmissionContentDataType] ([PubsSubmissionContentDataTypeID]) ON DELETE Cascade ON UPDATE No Action
GO