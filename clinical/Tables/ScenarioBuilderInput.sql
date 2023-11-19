CREATE TABLE [clinical].[ScenarioBuilderInput] (
    [ClinicalStudy]            VARCHAR (1000) NULL,
    [BaselinePlan]             VARCHAR (256)  NULL,
    [ScenarioName]             VARCHAR (1000) NULL,
    [NumberofSites]            INT            NULL,
    [NumberofPatients]         INT            NULL,
    [Country]                  VARCHAR (255)  NULL,
    [ActivationDate]           DATE           NULL,
    [ScreeningsPerSiteMonth]   INT            NULL,
    [ScreenFailRatePct]        DECIMAL (2)    NULL,
    [SiteActivationLag]        INT            NULL,
    [PatientRunIn]             INT            NULL,
    [EarlyTermPct]             DECIMAL (2)    NULL,
    [ScenarioComments]         VARCHAR (MAX)  NULL,
    [EnrollmentsPerSiteMonth]  INT            NULL,
    [RandomizationRatePct]     DECIMAL (2)    NULL,
    [ScenarioBuilderID]        INT            IDENTITY (1, 1) NOT NULL,
    [EnrollmentCompletionDate] DATE           NULL,
    CONSTRAINT [PK_ScenarioBuilderID] PRIMARY KEY NONCLUSTERED ([ScenarioBuilderID] ASC)
);

