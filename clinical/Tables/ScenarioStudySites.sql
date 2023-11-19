CREATE TABLE [clinical].[ScenarioStudySites] (
    [SiteCountry]          VARCHAR (50) NULL,
    [SiteInitiationDate]   DATETIME     NULL,
    [ScenerioSiteName]     VARCHAR (50) NULL,
    [ActualSite]           BIT          NULL,
    [ScenarioStudySitesID] INT          IDENTITY (1, 1) NOT NULL,
    [StudyRecruitmentID]   INT          NOT NULL,
    [ClinicalStudySitesID] INT          NULL,
    CONSTRAINT [PK_ScenarioStudySites] PRIMARY KEY CLUSTERED ([ScenarioStudySitesID] ASC),
    CONSTRAINT [FK_ScenarioStudySites_ClinicalStudySites] FOREIGN KEY ([ClinicalStudySitesID]) REFERENCES [clinical].[ClinicalStudySites] ([ClinicalStudySitesID]),
    CONSTRAINT [FK_ScenarioStudySites_StudyRecruitment] FOREIGN KEY ([StudyRecruitmentID]) REFERENCES [clinical].[StudyRecruitment] ([StudyRecruitmentID])
);

