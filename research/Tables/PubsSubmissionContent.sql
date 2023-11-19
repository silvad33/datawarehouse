CREATE TABLE [research].[PubsSubmissionContent]
(
	[SubmissionContentKey] int NOT NULL IDENTITY (1, 1),
	[SubmissionContentID] int NOT NULL,
	[SubmissionContent] varchar(255) NOT NULL,
	[Description] varchar(255) NULL,
	[DateCreated] datetime NOT NULL DEFAULT getdate(),
	[DateModified] datetime NULL
)
GO

ALTER TABLE [research].[PubsSubmissionContent] 
 ADD CONSTRAINT [PK_SubmissionContentKey]
	PRIMARY KEY CLUSTERED ([SubmissionContentKey] ASC)
GO