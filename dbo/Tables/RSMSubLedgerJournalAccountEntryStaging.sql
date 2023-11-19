CREATE TABLE [dbo].[RSMSubLedgerJournalAccountEntryStaging] (
    [DEFINITIONGROUP]            NVARCHAR (60)   NOT NULL,
    [EXECUTIONID]                NVARCHAR (90)   NOT NULL,
    [ISSELECTED]                 INT             NOT NULL,
    [TRANSFERSTATUS]             INT             NOT NULL,
    [ACCOUNTINGCURRENCYAMOUNT]   NUMERIC (32, 6) NOT NULL,
    [GENERALJOURNALACCOUNTENTRY] BIGINT          NOT NULL,
    [RECIDCOPY1]                 BIGINT          NOT NULL,
    [POSTINGTYPE]                INT             NOT NULL,
    [REPORTINGCURRENCYAMOUNT]    NUMERIC (32, 6) NOT NULL,
    [SIDE]                       INT             NOT NULL,
    [SUBLEDGERJOURNALENTRY]      BIGINT          NOT NULL,
    [TRANSACTIONCURRENCY]        NVARCHAR (3)    NOT NULL,
    [TRANSACTIONCURRENCYAMOUNT]  NUMERIC (32, 6) NOT NULL,
    [PARTITION]                  NVARCHAR (20)   NOT NULL,
    [SYNCSTARTDATETIME]          DATETIME        NOT NULL,
    [RECID]                      BIGINT          NOT NULL,
    CONSTRAINT [PK_RSMSubLedgerJournalAccountEntryStaging] PRIMARY KEY CLUSTERED ([EXECUTIONID] ASC, [RECIDCOPY1] ASC, [PARTITION] ASC)
);

