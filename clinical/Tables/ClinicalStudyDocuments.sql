CREATE TABLE [clinical].[ClinicalStudyDocuments]
(
	[DocumentType] varchar(50) NOT NULL,
	[Comments] varchar(50) NULL,
	[Country] varchar(50) NULL,
	[ApprovedDate] varchar(50) NULL,
	[ClinicalStudyDocumentsID] INT IDENTITY (1, 1) NOT NULL,
	[ClinicalStudyDocumentNumber] varchar(50) NOT NULL,
	[ClinicalStudyID] int NOT NULL
)
GO

ALTER TABLE [clinical].[ClinicalStudyDocuments] 
 ADD CONSTRAINT [PK_ClinicalStudyDocuments]
	PRIMARY KEY CLUSTERED ([ClinicalStudyDocumentsID] ASC)
GO

ALTER TABLE [clinical].[ClinicalStudyDocuments] ADD CONSTRAINT [FK_ClinicalStudyDocuments_ClinicalStudy]
	FOREIGN KEY ([ClinicalStudyID]) REFERENCES [clinical].[ClinicalStudy] ([ClinicalStudyID]) ON DELETE No Action ON UPDATE No Action
GO