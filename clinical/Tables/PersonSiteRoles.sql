CREATE TABLE [clinical].[PersonSiteRoles] (
    [StartDate]            DATETIME       NULL,
    [EndDate]              DATETIME       NULL,
    [Role]                 VARCHAR (2000) NULL,
    [PersonSiteRolesID]    INT            IDENTITY (1, 1) NOT NULL,
    [ClinicalSitePersonID] INT            NOT NULL,
    [ClinicalStudySitesID] INT            NOT NULL,
    CONSTRAINT [PK_PersonSiteRoles] PRIMARY KEY CLUSTERED ([PersonSiteRolesID] ASC),
    CONSTRAINT [FK_PersonSiteRoles_ClinicalSitePerson] FOREIGN KEY ([ClinicalSitePersonID]) REFERENCES [clinical].[ClinicalSitePerson] ([ClinicalSitePersonID]),
    CONSTRAINT [FK_PersonSiteRoles_ClinicalStudySites] FOREIGN KEY ([ClinicalStudySitesID]) REFERENCES [clinical].[ClinicalStudySites] ([ClinicalStudySitesID])
);

