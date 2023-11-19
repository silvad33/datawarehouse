CREATE TABLE [clinical].[ClinicalSite] (
    [ClinicalSiteNumber] INT NULL,
    [ClinicalSiteID]     INT IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [PK_ClinicalSite] PRIMARY KEY CLUSTERED ([ClinicalSiteID] ASC)
);

