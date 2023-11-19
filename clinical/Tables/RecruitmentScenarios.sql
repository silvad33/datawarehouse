CREATE TABLE [clinical].[RecruitmentScenarios] (
    [ScenarioName]           VARCHAR (2500) NULL,
    [Status]                 VARCHAR (50)   NULL,
    [StatusDate]             DATETIME       NULL,
    [SiteCountry]            VARCHAR (50)   NULL,
    [ScenarioSiteName]       VARCHAR (50)   NULL,
    [ActualSite]             BIT            NULL,
    [PatientRecruitmentDate] DATETIME       NULL,
    [NumberofSubjects]       DECIMAL (8, 2) NULL,
    [ClinicalStudyName]      VARCHAR (50)   NULL,
    [RecruitmentScenariosID] INT            IDENTITY (1, 1) NOT NULL,
    [ScenarioParametersID]   INT            NULL,
    [StudyAnnotationsID]     INT            NULL,
    CONSTRAINT [PK_RecruitmentScenarios] PRIMARY KEY CLUSTERED ([RecruitmentScenariosID] ASC),
    CONSTRAINT [FK_RecruitmentScenarios_ScenarioParameters] FOREIGN KEY ([ScenarioParametersID]) REFERENCES [clinical].[ScenarioParameters] ([ScenarioParametersID]),
    CONSTRAINT [FK_RecruitmentScenarios_StudyAnnotations] FOREIGN KEY ([StudyAnnotationsID]) REFERENCES [clinical].[StudyAnnotations] ([StudyAnnotationsID])
);

