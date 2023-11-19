CREATE TABLE [clinical].[ScenarioBuilderOutput] (
    [ScenarioName]            NVARCHAR (1000) NULL,
    [Status]                  NVARCHAR (1000) NULL,
    [StatusDate]              DATETIME        NULL,
    [ScenarioSiteName]        NVARCHAR (50)   NULL,
    [ActualSite]              INT             NULL,
    [PatientRecruitmentDate]  DATETIME        NULL,
    [NumberofSubjects]        NUMERIC (18, 2) NULL,
    [ClinicalStudy]           NVARCHAR (1000) NULL,
    [ScenarioBuilderOutputID] INT             IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [PK_ScenarioBuilderOutput] PRIMARY KEY CLUSTERED ([ScenarioBuilderOutputID] ASC)
);

