CREATE TABLE [dbo].[InvoiceLineAllocation] (
    [InvoiceLineID]     INT        NOT NULL,
    [InvoiceID]         INT        NOT NULL,
    [DepartmentKey]     INT        NULL,
    [AccountKey]        INT        NULL,
    [ProjectKey]        INT        NULL,
    [TaskKey]           INT        NULL,
    [AllocationPercent] FLOAT (53) NULL,
    [Amount]            FLOAT (53) NULL
);
GO

CREATE NONCLUSTERED INDEX [IX_InvoiceLineAllocation] ON [dbo].[InvoiceLineAllocation] ([InvoiceID] ASC);
GO

CREATE NONCLUSTERED INDEX [IX2_InvoiceLineAllocation] ON [dbo].[InvoiceLineAllocation] ([InvoiceLineID] ASC) INCLUDE (Amount);
GO