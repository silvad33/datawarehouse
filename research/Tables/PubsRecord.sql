CREATE TABLE [research].[PubsRecord]
(
	[PubsKey] int NOT NULL IDENTITY (1, 1),
	[Version] int NULL DEFAULT 2,
	[Title] varchar(255) NOT NULL,
	[ResponsiblePartyKey] int NULL,
	[PubsType] varchar(255) NULL,
	[SubmissionDeadline] datetime NULL,
	[ExternalAuthors] varchar(max) NULL,
	[Comments] varchar(max) NULL,
	[IonisClinicalStudyCSNum] varchar(255) NULL,
	[ClinicalTrialRegistryIDNCTNum] varchar(255) NULL,
	[SubmissionContentID] int NULL,
	[JournalLinkedID] int NULL,
	[AssociatedRecordKey] int NULL,
	[BookTitle] varchar(255) NULL,
	[BookChapter] varchar(255) NULL,
	[Editor] varchar(255) NULL,
	[Edition] varchar(255) NULL,
	[Volume] varchar(255) NULL,
	[PresentationType] varchar(255) NULL,
	[Explain] varchar(MAX) NULL,
	[MeetingLinkedID] int NULL,
	[PatentsCompleted] varchar(255) NULL,
	[LastWFStartTime] datetime NULL,
	[NeedAbstract] varchar(10) NULL,
	[ApprovalStatus] varchar(255) NULL,
	[Presenters] varchar(255) NULL,
	[UserComments] varchar(max) NULL,
	[Expedited] varchar(10) NULL,
	[CreatedBy] int NULL,
	[Created] datetime NULL,
	[Modified] datetime NULL,
	[ModifiedBy] int NULL,
	[DateCreated] datetime NOT NULL DEFAULT getdate(),
	[DateModified] datetime NULL,
	[PubsID] int NOT NULL,
	[CompletedTime] datetime NULL,
	[ComplianceRelated] varchar(10) NULL,
	[SubmissionStatus]  varchar(255) NULL
)
GO

ALTER TABLE [research].[PubsRecord] 
 ADD CONSTRAINT [PK_PubsKey]
	PRIMARY KEY CLUSTERED ([PubsKey] ASC)
GO

CREATE NONCLUSTERED INDEX [idx_createdby_pubsrecord] 
 ON [research].[PubsRecord] ([CreatedBy] ASC)
GO