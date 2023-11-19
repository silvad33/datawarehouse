CREATE TABLE [shared].[Person] (
    [FirstName]              VARCHAR (2000) NULL,
    [LastName]               VARCHAR (2000) NULL,
    [MiddleName]             VARCHAR (2000) NULL,
    [Title]                  VARCHAR (2000) NULL,
    [FirstNameOrigencoding]  VARCHAR (2000) NULL,
    [LastNameOrigencoding]   VARCHAR (2000) NULL,
    [MiddleNameOrigencoding] VARCHAR (2000) NULL,
    [TitleOrigencoding]      VARCHAR (2000) NULL,
    [PersonID]               INT            IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [PK_Person] PRIMARY KEY CLUSTERED ([PersonID] ASC)
);

