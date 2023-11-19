CREATE TABLE [dbo].[RSMSubLedgerJournalAccountEntryDistributionStaging] (
    [DEFINITIONGROUP]              NVARCHAR (60)   NOT NULL,
    [EXECUTIONID]                  NVARCHAR (90)   NOT NULL,
    [ISSELECTED]                   INT             NOT NULL,
    [TRANSFERSTATUS]               INT             NOT NULL,
    [ACCOUNTINGCURRENCYAMOUNT]     NUMERIC (32, 6) NOT NULL,
    [ACCOUNTINGDISTRIBUTION]       BIGINT          NOT NULL,
    [PARENTDISTRIBUTION]           BIGINT          NOT NULL,
    [RECIDCOPY1]                   BIGINT          NOT NULL,
    [REPORTINGCURRENCYAMOUNT]      NUMERIC (32, 6) NOT NULL,
    [SUBLEDGERJOURNALACCOUNTENTRY] BIGINT          NOT NULL,
    [PARTITION]                    NVARCHAR (20)   NOT NULL,
    [SYNCSTARTDATETIME]            DATETIME        NOT NULL,
    [RECID]                        BIGINT          NOT NULL,
    CONSTRAINT [PK_RSMSubLedgerJournalAccountEntryDistributionStaging] PRIMARY KEY CLUSTERED ([EXECUTIONID] ASC, [RECIDCOPY1] ASC, [PARTITION] ASC)
);

