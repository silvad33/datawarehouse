CREATE TABLE [clinical].[StudySiteActivation] (
    [CurrentDate]           DATETIME      NULL,
    [FirstSiteActualDate]   DATETIME      NULL,
    [FirstSitePlannedDate]  DATETIME      NULL,
    [ClinicalStudyName]     VARCHAR (256) NULL,
    [StudySiteActivationID] INT           IDENTITY (1, 1) NOT NULL,
    [ClinicalStudyID]       INT           NULL,
    CONSTRAINT [PK_StudySiteActivation] PRIMARY KEY CLUSTERED ([StudySiteActivationID] ASC),
    CONSTRAINT [FK_StudySiteActivation_ClinicalStudy] FOREIGN KEY ([ClinicalStudyID]) REFERENCES [clinical].[ClinicalStudy] ([ClinicalStudyID])
);

