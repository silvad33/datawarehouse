CREATE TABLE [clinical].[SiteSubjectRecruitment] (
    [PatientRecruitmentDate]   DATETIME       NULL,
    [NumberofSubjects]         DECIMAL (8, 2) NULL,
    [SiteSubjectRecruitmentID] INT            IDENTITY (1, 1) NOT NULL,
    [ScenarioStudySitesID]     INT            NOT NULL,
    CONSTRAINT [PK_SiteSubjectRecruitment] PRIMARY KEY CLUSTERED ([SiteSubjectRecruitmentID] ASC),
    CONSTRAINT [FK_SiteSubjectRecruitment_ScenarioStudySites] FOREIGN KEY ([ScenarioStudySitesID]) REFERENCES [clinical].[ScenarioStudySites] ([ScenarioStudySitesID])
);

