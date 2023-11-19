CREATE TABLE [clinical].[IVRSData] (
    [SubjectNumber]              INT          NULL,
    [SubjectDOB]                 DATETIME     NULL,
    [SubjectGender]              VARCHAR (50) NULL,
    [ScreeningDate]              DATETIME     NULL,
    [ScreeningPass]              BIT          NULL,
    [SubjectEnrollmentDate]      DATETIME     NULL,
    [SiteScreeningNumber]        VARCHAR (50) NULL,
    [SubjectDiscontinuationDate] DATETIME     NULL,
    [SubjectStudyCompletion]     BIT          NULL,
    [IVRSDataID]                 INT          IDENTITY (1, 1) NOT NULL,
    [ClinicalStudySitesID]       INT          NULL,
    CONSTRAINT [PK_IVRSData] PRIMARY KEY CLUSTERED ([IVRSDataID] ASC),
    CONSTRAINT [FK_IVRSData_ClinicalStudySites] FOREIGN KEY ([ClinicalStudySitesID]) REFERENCES [clinical].[ClinicalStudySites] ([ClinicalStudySitesID])
);

