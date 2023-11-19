CREATE TABLE [clinical].[ClinicalStudyQueries]
(
	[StudyQueryGUID] varchar(500) NOT NULL,
	[EDCCRFFormName] varchar(500) NOT NULL,
	[StudySiteScreeningNumber] varchar(50) NULL,
	[StudyVisitName] varchar(500) NULL,
	[StudyPlannedTimePoint] varchar(500) NULL,
	[CRFFieldName] varchar(500) NULL,
	[EDCQueryCode] varchar(500) NOT NULL,
	[EDCQueryDescription] varchar(500) NOT NULL,
	[EDCQueryCreationDate] date NOT NULL,
	[EDCQueryAnswerDate] date NULL,
	[EDCQueryReviewDate] date NULL,
	[EDCQueryStatus] varchar(500) NOT NULL,
	[EDCAuditStatus] varchar(500) NULL,
	[ClinicalStudySitesID] int NOT NULL
)
GO

ALTER TABLE [clinical].[ClinicalStudyQueries] 
 ADD CONSTRAINT [PK_ClinicalStudyQueries]
	PRIMARY KEY CLUSTERED ([StudyQueryGUID] ASC)
GO

ALTER TABLE [clinical].[ClinicalStudyQueries] ADD CONSTRAINT [FK_ClinicalStudyQueries_ClinicalStudySites]
	FOREIGN KEY ([ClinicalStudySitesID]) REFERENCES [clinical].[ClinicalStudySites] ([ClinicalStudySitesID]) ON DELETE No Action ON UPDATE No Action
GO