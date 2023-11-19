CREATE TABLE [clinical].[ClinicalSitePerson] (
    [Speciality]           VARCHAR (2000) NULL,
    [SubSpeciality]        VARCHAR (2000) NULL,
    [ProviderIdentifier]   VARCHAR (2000) NULL,
    [Comments]             VARCHAR (2000) NULL,
    [MdmID]                VARCHAR (500)  NULL,
    [ClinicalSitePersonID] INT            NOT NULL,
    CONSTRAINT [PK_ClinicalSitePerson] PRIMARY KEY CLUSTERED ([ClinicalSitePersonID] ASC),
    CONSTRAINT [FK_ClinicalSitePerson_Person] FOREIGN KEY ([ClinicalSitePersonID]) REFERENCES [shared].[Person] ([PersonID])
);

