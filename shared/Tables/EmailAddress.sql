CREATE TABLE [shared].[EmailAddress] (
    [Email]          VARCHAR (2000) NULL,
    [StartDate]      DATETIME       NULL,
    [EndDate]        DATETIME       NULL,
    [EmailAddressID] INT            IDENTITY (1, 1) NOT NULL,
    [LocationInfoID] INT            NOT NULL,
    CONSTRAINT [PK_EmailAddress] PRIMARY KEY CLUSTERED ([EmailAddressID] ASC),
    CONSTRAINT [FK_EmailAddress_LocationInfo] FOREIGN KEY ([LocationInfoID]) REFERENCES [shared].[LocationInfo] ([LocationInfoID])
);

