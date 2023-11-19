CREATE TABLE [clinical].[ScenarioParameters] (
    [Annotations]            VARCHAR (5000) NULL,
    [SiteActivationLag]      INT            NULL,
    [SubjectRunInDuration]   INT            NULL,
    [SubjectScreensPerMonth] INT            NULL,
    [ScreenFailureRate]      INT            NULL,
    [EarlyTermination_pct]   INT            NULL,
    [RandomizationRate_pct]  INT            NULL,
    [TotalSubjectsRequired]  INT            NULL,
    [ScenarioParametersID]   INT            IDENTITY (1, 1) NOT NULL,
    [StudyRecruitmentID]     INT            NOT NULL,
    [PlanLevel]              VARCHAR (50)   NULL,
    CONSTRAINT [PK_ScenarioParameters] PRIMARY KEY CLUSTERED ([ScenarioParametersID] ASC),
    CONSTRAINT [FK_ScenarioParameters_StudyRecruitment] FOREIGN KEY ([StudyRecruitmentID]) REFERENCES [clinical].[StudyRecruitment] ([StudyRecruitmentID])
);

