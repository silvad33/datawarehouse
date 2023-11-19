CREATE TABLE [dbo].[TranProjAllocation] (
    [department]                VARCHAR (10)     NULL,
    [project]                   VARCHAR (10)     NULL,
    [ACCOUNTINGDATE]            DATETIME         NOT NULL,
    [DataAreaID]                NVARCHAR (4)     NOT NULL,
    [TRANSACTIONCURRENCYAMOUNT] NUMERIC (32, 6)  NOT NULL,
    [AllocationPercentage]      DECIMAL (18, 10) NULL,
    [NewProj]                   INT              NULL,
    [RECID]                     BIGINT           NOT NULL
);

