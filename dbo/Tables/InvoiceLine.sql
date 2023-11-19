CREATE TABLE [dbo].[InvoiceLine] (
    [InvoiceLineID]  INT           NOT NULL,
    [InvoiceID]      INT           NOT NULL,
    [InvoiceLineNumber] INT NOT NULL,
    [Description]    VARCHAR (500) NULL,
    [PO_ID]          INT           NULL,
    [PO_Number]      VARCHAR (25)  NULL,
    [PO_Line_Number] INT           NULL,
    [Price]          FLOAT (53)    NULL,
    [Total]          FLOAT (53)    NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_InvoiceLine]
    ON [dbo].[InvoiceLine]([InvoiceID] ASC);

