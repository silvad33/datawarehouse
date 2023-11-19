CREATE TABLE [clinical].[StudyClinicalSiteCROs] (
    [StartDate]               DATETIME       NULL,
    [EndDate]                 DATETIME       NULL,
    [SiteCROStatus]           VARCHAR (2000) NULL,
    [StudyClinicalSiteCROsID] INT            IDENTITY (1, 1) NOT NULL,
    [ClinicalStudySitesID]    INT            NOT NULL,
    [ClinicalOrganizationID]  INT            NOT NULL,
    CONSTRAINT [PK_StudyClinicalSiteCROs] PRIMARY KEY CLUSTERED ([StudyClinicalSiteCROsID] ASC),
    CONSTRAINT [FK_StudyClinicalSiteCROs_ClinicalOrganization] FOREIGN KEY ([ClinicalOrganizationID]) REFERENCES [clinical].[ClinicalOrganization] ([ClinicalOrganizationID]),
    CONSTRAINT [FK_StudyClinicalSiteCROs_ClinicalStudySites] FOREIGN KEY ([ClinicalStudySitesID]) REFERENCES [clinical].[ClinicalStudySites] ([ClinicalStudySitesID])
);

