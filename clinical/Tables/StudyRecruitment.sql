CREATE TABLE [clinical].[StudyRecruitment] (
    [ScenarioName]       VARCHAR (2500) NULL,
    [Status]             VARCHAR (50)   NULL,
    [StatusDate]         DATETIME       NULL,
    [ClinicalStudyID]    INT            NULL,
    [PlanType]           VARCHAR (50)   NULL,
    [StudyRecruitmentID] INT            IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [PK_StudyRecruitment] PRIMARY KEY CLUSTERED ([StudyRecruitmentID] ASC),
    CONSTRAINT [FK_StudyRecruitment_ClinicalStudy] FOREIGN KEY ([ClinicalStudyID]) REFERENCES [clinical].[ClinicalStudy] ([ClinicalStudyID])
);

