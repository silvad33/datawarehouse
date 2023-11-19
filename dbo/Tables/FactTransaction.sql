/*
Change Log:
2020-10-29 RLC: Add index on Scenario+SubScenario to accelerate deletes by Scenario
CREATE NONCLUSTERED INDEX [IX2_FactTransaction]
    ON [dbo].[FactTransaction]([Scenario] ASC, [SubScenario] ASC);
*/

CREATE TABLE [dbo].[FactTransaction] (
    [AccountString]            NVARCHAR (500)  NOT NULL,
    [TransactionDate]          DATETIME        NOT NULL,
    [Scenario]                 VARCHAR (60)    NULL,
    [TransactionDescription]   NVARCHAR (MAX)   NOT NULL,
    [BudgetAmount]             NUMERIC (32, 6) NULL,
    [IsAllocated]              VARCHAR (30)    NULL,
    [RecID]                    BIGINT          NOT NULL,
    [Partition]                NVARCHAR (20)   NOT NULL,
    [AccountKey]               INT             NULL,
    [DepartmentKey]            INT             NULL,
    [ProjectKey]               INT             NULL,
    [TaskKey]                  INT             NULL,
    [FiscalPeriodKey]         INT             NOT NULL,
    [EntityKey]                INT             NULL,
    [TransactionAmount]        MONEY           NULL,
    [ReportingCurrencyAmount]  MONEY           NULL,
    [AccountingCurrencyAmount] MONEY           NULL,
    [ReportingCurrencyCode]    VARCHAR (10)    NULL,
    [AccountingCurrencyCode]   VARCHAR (10)    NULL,
    [TransactionCurrencyCode]  VARCHAR (10)    NULL,
    [InvoiceNumber]            VARCHAR (50)    NULL,
    [SecurityKey]              INT             NULL,
    [Voucher]                  VARCHAR (50)    NULL,
    [SubScenario]              VARCHAR (60)    NULL,
    [FCastQ1Amount]            MONEY           NULL,
    [FCastQ2Amount]            MONEY           NULL,
    [FCastQ3Amount]            MONEY           NULL,
    [FCastQ4Amount]            MONEY           NULL,
    [PostingTypeDescription]   VARCHAR (500)   NULL
);
GO

CREATE NONCLUSTERED INDEX [IX_FactTransaction] ON [dbo].[FactTransaction]([EntityKey] ASC, [DepartmentKey] ASC);
GO

CREATE NONCLUSTERED INDEX [IX1_FactTransaction] ON [dbo].[FactTransaction]([AccountKey] ASC);
GO

CREATE NONCLUSTERED INDEX [IX2_FactTransaction] ON [dbo].[FactTransaction]([Scenario] ASC, [SubScenario] ASC);
GO

CREATE NONCLUSTERED INDEX [IX3_FactTransaction] ON [dbo].[FactTransaction]([DepartmentKey] ASC) INCLUDE (AccountString, AccountKey);
GO