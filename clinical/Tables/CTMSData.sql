﻿CREATE TABLE [clinical].[CTMSData] (
    [SubjectNumber]                  INT           NULL,
    [ScreeningDate]                  DATETIME      NULL,
    [ScreeningPass]                  BIT           NULL,
    [SubjectEnrollmentDate]          DATETIME      NULL,
    [SiteScreeningNumber]            VARCHAR (50)  NULL,
    [SubjectDiscontinuationDate]     DATETIME      NULL,
    [SubjectStudyCompleted]          BIT           NULL,
    [CTMSStatus]                     VARCHAR (50)  NULL,
    [ScreenFailureReason]            VARCHAR (500) NULL,
    [RandomizationDate]              DATETIME      NULL,
    [BaselineDate]                   DATETIME      NULL,
    [StudyDiscontinuationDate]       DATETIME      NULL,
    [StudyDiscontinuationReason]     VARCHAR (500) NULL,
    [TreatmentCompletionDate]        DATETIME      NULL,
    [TreatmentDiscontinuationDate]   DATETIME      NULL,
    [TreatmentDiscontinuationReason] VARCHAR (500) NULL,
    [SubjectTreatmentCompleted]      BIT           NULL,
    [CTMSDataID]                     INT           IDENTITY (1, 1) NOT NULL,
    [ClinicalStudySitesID]           INT           NULL,
    [ClinicalStudyCohortsID]         INT           NULL,
    CONSTRAINT [PK_CTMSData] PRIMARY KEY CLUSTERED ([CTMSDataID] ASC),
    CONSTRAINT [FK_CTMSData_ClinicalStudyCohorts] FOREIGN KEY ([ClinicalStudyCohortsID]) REFERENCES [clinical].[ClinicalStudyCohorts] ([ClinicalStudyCohortsID]),
    CONSTRAINT [FK_CTMSData_ClinicalStudySites] FOREIGN KEY ([ClinicalStudySitesID]) REFERENCES [clinical].[ClinicalStudySites] ([ClinicalStudySitesID])
);

