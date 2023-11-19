CREATE TABLE [dbo].[DimSupplier] (
    [SupplierKey]     INT           IDENTITY (1, 1) NOT NULL,
    [SupplierName]    VARCHAR (250) NULL,
    [CoupaSupplierID] INT           NULL,
    [Entity]          VARCHAR (10)  NULL,
    [SupplierID]      VARCHAR (20)  NULL,
    [LastUpdated]     DATETIME      NULL,
    [D365SupplierID]  VARCHAR (20)  NULL,
    [FederalTaxId]    VARCHAR(100) NULL,
	[InternationTaxId] VARCHAR(100) NULL,
    [LocationCode] VARCHAR(250) NULL,
	[StreetOne] VARCHAR(250) NULL,
	[StreetTwo] VARCHAR(250) NULL,
	[City] VARCHAR(250) NULL,
	[State] VARCHAR(100) NULL,
	[PostalCode] VARCHAR(50) NULL,
    [Country] VARCHAR(100) NULL,
    [AuditCreatedAt] DATETIME NULL,
    [AuditCreatedBy] VARCHAR(100) NULL,
    [AuditUpdatedAt] DATETIME NULL,
    [AuditUpdatedBy] VARCHAR(100) NULL
    CONSTRAINT [PK_DimSupplier] PRIMARY KEY CLUSTERED ([SupplierKey] ASC)
);

