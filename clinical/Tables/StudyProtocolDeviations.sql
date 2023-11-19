CREATE TABLE [clinical].[StudyProtocolDeviations]
(
	[StudyProtocolDeviationsID] int NOT NULL IDENTITY (1, 1),
	[StudySiteSubjectsID] int NOT NULL,
	[DVSequenceNumber] int NULL,
	[DVCategory] varchar(500) NULL,
	[DVTypeDecoded] varchar(500) NOT NULL,
	[DVDescription] varchar(1000) NULL,
	[DVDeviationDate] date NULL,
	[DVDeviationDiscoveryDate] date NULL,
	[DVProjectTeamLead] varchar(150) NULL,
	[DVDateSentforReview] date NULL,
	[DVAction] varchar(2500) NULL,
	[DVDateReviewed] date NULL
)
GO

ALTER TABLE [clinical].[StudyProtocolDeviations] 
 ADD CONSTRAINT [PK_Table1]
	PRIMARY KEY CLUSTERED ([StudyProtocolDeviationsID] ASC)
GO

ALTER TABLE [clinical].[StudyProtocolDeviations] ADD CONSTRAINT [FK_StudyProtocolDeviations_StudySiteSubjects]
	FOREIGN KEY ([StudySiteSubjectsID]) REFERENCES [clinical].[StudySiteSubjects] ([StudySiteSubjectsID]) ON DELETE No Action ON UPDATE No Action
GO