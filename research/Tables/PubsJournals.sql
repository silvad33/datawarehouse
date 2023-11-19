CREATE TABLE [research].[PubsJournals]
(
	[JournalID] int NOT NULL,
	[JournalTitle] varchar(255) NULL,
	[URLLink] varchar(max) NULL,
	[URLDescription] varchar(max) NULL,
	[ISDN] varchar(255) NULL,
	[AddedBy] varchar(255) NULL,
	[Abbreviation] varchar(255) NULL,
	[Created] datetime NOT NULL,
	[Modified] datetime NULL,
	[CreatedByUserKey] int NULL,
	[DateCreated] datetime NOT NULL DEFAULT getdate(),
	[DateModified] datetime NULL
)
GO

ALTER TABLE [research].[PubsJournals] 
 ADD CONSTRAINT [PK_JournalID]
	PRIMARY KEY CLUSTERED ([JournalID] ASC)
GO