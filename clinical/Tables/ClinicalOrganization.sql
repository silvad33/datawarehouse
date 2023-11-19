CREATE TABLE [clinical].[ClinicalOrganization] (
    [ClinicalOrganizationType] VARCHAR (2000) NULL,
    [ClinicalOrganizationID]   INT            IDENTITY (1, 1) NOT NULL,
    [VeevaID]                  VARCHAR (255)  NULL,
    CONSTRAINT [PK_ClinicalOrganization] PRIMARY KEY CLUSTERED ([ClinicalOrganizationID] ASC)
);

