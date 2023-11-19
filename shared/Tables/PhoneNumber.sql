CREATE TABLE [shared].[PhoneNumber] (
    [CountryCode]    INT          NULL,
    [AreaCode]       INT          NULL,
    [Number]         VARCHAR (50) NULL,
    [Extension]      INT          NULL,
    [StartDate]      DATETIME     NULL,
    [EndDate]        DATETIME     NULL,
    [PhoneNumberID]  INT          IDENTITY (1, 1) NOT NULL,
    [LocationInfoID] INT          NOT NULL,
    CONSTRAINT [PK_PhoneNumber] PRIMARY KEY CLUSTERED ([PhoneNumberID] ASC),
    CONSTRAINT [FK_PhoneNumber_LocationInfo] FOREIGN KEY ([LocationInfoID]) REFERENCES [shared].[LocationInfo] ([LocationInfoID])
);

