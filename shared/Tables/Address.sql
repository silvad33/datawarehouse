CREATE TABLE [shared].[Address] (
    [ID]                          INT            NULL,
    [AddresseeName]               VARCHAR (1000) NULL,
    [StreetAddress1]              VARCHAR (2000) NULL,
    [StreetAddress2]              VARCHAR (2000) NULL,
    [City]                        VARCHAR (2000) NULL,
    [StateProvince]               VARCHAR (2000) NULL,
    [Country]                     VARCHAR (2000) NULL,
    [PostalCode]                  VARCHAR (2000) NULL,
    [AddresseeNameOrigencoding]   VARCHAR (2000) NULL,
    [Street_Address1Origencoding] VARCHAR (2000) NULL,
    [Street_Address2Origencoding] VARCHAR (2000) NULL,
    [CityOrigencoding]            VARCHAR (2000) NULL,
    [StateProvinceOrigencoding]   VARCHAR (2000) NULL,
    [CountryOrigencoding]         VARCHAR (2000) NULL,
    [PostalCodeOrigencoding]      VARCHAR (2000) NULL,
    [StartDate]                   DATETIME       NULL,
    [EndDate]                     DATETIME       NULL,
    [AddressID]                   INT            IDENTITY (1, 1) NOT NULL,
    [LocationInfoID]              INT            NULL,
    CONSTRAINT [PK_Address] PRIMARY KEY CLUSTERED ([AddressID] ASC),
    CONSTRAINT [FK_Address_LocationInfo] FOREIGN KEY ([LocationInfoID]) REFERENCES [shared].[LocationInfo] ([LocationInfoID])
);

