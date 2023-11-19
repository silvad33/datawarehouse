CREATE TABLE [shared].[NameSynonyms] (
    [NameGroup] INT            NOT NULL,
    [Name]      VARCHAR (1000) NOT NULL,
    CONSTRAINT [PK_Name_Group] PRIMARY KEY CLUSTERED ([NameGroup] ASC, [Name] ASC)
);

