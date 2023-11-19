CREATE TABLE [dbo].[InvoiceHeader] (
    [Entity]         VARCHAR (4)   NOT NULL,
    [InvoiceID]      INT           NOT NULL,
    [InvoiceNumber]  VARCHAR (100) NULL,
    [InvoiceDate]    DATETIME2(3)  NULL,
    [SupplierKey]    INT           NULL,
    [Status]         VARCHAR (100) NULL,
    [Exported]       VARCHAR (5)   NULL,
    [LastExportedAt] DATETIME2(3)  NULL,
    [Created_By]     VARCHAR (100) NULL,
    [Created_At]     DATETIME      NULL,
    [Updated_By]     VARCHAR (100) NULL,
    [Updated_At]     DATETIME2(3)  NULL,
    [WH_Created]     DATETIME2(3)  NULL,
    [PaymentDate]    DATETIME2(3)  NULL,
    [HandlingAmount] FLOAT (53)    NULL,
    [MiscAmount]     FLOAT (53)    NULL,
    [ShippingAmount] FLOAT (53)    NULL,
    [TaxAmount]      FLOAT (53)    NULL,
    [CurrencyCode]   VARCHAR(10)   NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_InvoiceHeader]
    ON [dbo].[InvoiceHeader]([InvoiceID] ASC);

