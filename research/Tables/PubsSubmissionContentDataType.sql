CREATE TABLE [research].[PubsSubmissionContentDataType]
(
	[PubsSubmissionContentDataTypeID] int NOT NULL,
	[Title] varchar(255) NOT NULL,
	[Created] datetime NOT NULL,
	[Modified] datetime NULL,
	[DateCreated] datetime NOT NULL DEFAULT getdate(),
	[DateModified] datetime NULL
)
GO

ALTER TABLE [research].[PubsSubmissionContentDataType] 
 ADD CONSTRAINT [PK_PubsSubmissionContentDataTypeID]
	PRIMARY KEY CLUSTERED ([PubsSubmissionContentDataTypeID] ASC)
GO