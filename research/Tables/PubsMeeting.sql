CREATE TABLE [research].[PubsMeeting]
(
	[PubsMeetingID] int NOT NULL,
	[MeetingTitle] varchar(255) NOT NULL,
	[Location] varchar(255) NULL,
	[StartTime] datetime NOT NULL,
	[EndTime] datetime NOT NULL,
	[Description] varchar(max) NULL,
	[Category] varchar(255) NOT NULL,
	[AddedBy] varchar(255) NOT NULL,
	[MeetingLink] varchar(max) NULL,
	[URLDescription] varchar(max) NULL,
	[Created] datetime NOT NULL,
	[Modified] datetime NULL,
	[CreatedByUserKey] int NULL,
	[DateCreated] datetime NOT NULL DEFAULT getdate(),
	[DateModified] datetime NULL
)
GO

ALTER TABLE [research].[PubsMeeting] 
 ADD CONSTRAINT [PK_PubsMeetingID]
	PRIMARY KEY CLUSTERED ([PubsMeetingID] ASC)
GO