CREATE TABLE [financial].[xrefFreeTextInvoices] (
    xrefFreeTextInvoiceKey [int] IDENTITY(1, 1) NOT NULL
    , [FREETEXTNUMBER] [nvarchar](20) NOT NULL
    , [exported] [nvarchar](20) NULL
    )
