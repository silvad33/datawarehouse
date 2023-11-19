CREATE TABLE [dbo].[GeneralJournalAccountEntryStaging] (
    [DEFINITIONGROUP]                 NVARCHAR (60)   NOT NULL,
    [EXECUTIONID]                     NVARCHAR (90)   NOT NULL,
    [ISSELECTED]                      INT             NOT NULL,
    [TRANSFERSTATUS]                  INT             NOT NULL,
    [JOURNALNUMBER]                   NVARCHAR (20)   NOT NULL,
    [VOUCHER]                         NVARCHAR (20)   NOT NULL,
    [ACCOUNTINGDATE]                  DATETIME        NOT NULL,
    [POSTINGLAYER]                    INT             NOT NULL,
    [LEDGERACCOUNT]                   NVARCHAR (500)  NOT NULL,
    [TRANSACTIONCURRENCYCODE]         NVARCHAR (3)    NOT NULL,
    [TRANSACTIONCURRENCYCREDITAMOUNT] NUMERIC (32, 6) NOT NULL,
    [TRANSACTIONCURRENCYDEBITAMOUNT]  NUMERIC (32, 6) NOT NULL,
    [TRANSACTIONCURRENCYAMOUNT]       NUMERIC (32, 6) NOT NULL,
    [ACCOUNTINGCURRENCYAMOUNT]        NUMERIC (32, 6) NOT NULL,
    [REPORTINGCURRENCYAMOUNT]         NUMERIC (32, 6) NOT NULL,
    [DESCRIPTION]                     NVARCHAR (60)   NOT NULL,
    [QUANTITY]                        NUMERIC (32, 6) NOT NULL,
    [POSTINGTYPE]                     INT             NOT NULL,
    [JOURNALCATEGORY]                 INT             NOT NULL,
    [ISCORRECTION]                    INT             NOT NULL,
    [ISCREDIT]                        INT             NOT NULL,
    [ACKNOWLEDGEMENTDATE]             DATETIME        NOT NULL,
    [DOCUMENTDATE]                    DATETIME        NOT NULL,
    [DOCUMENTNUMBER]                  NVARCHAR (250)   NOT NULL,
    [LEDGERNAME]                      NVARCHAR (20)   NOT NULL,
    [GENERALJOURNALACCOUNTENTRYRECID] BIGINT          NOT NULL,
    [ACCOUNTDISPLAYVALUE]             NVARCHAR (500)  NOT NULL,
    [PARTITION]                       NVARCHAR (20)   NOT NULL,
    [DATAAREAID]                      NVARCHAR (4)    NOT NULL,
    [SYNCSTARTDATETIME]               DATETIME        NOT NULL,
    [RECID]                           BIGINT          NOT NULL,
    CONSTRAINT [PK_GeneralJournalAccountEntryStaging] PRIMARY KEY CLUSTERED ([EXECUTIONID] ASC, [GENERALJOURNALACCOUNTENTRYRECID] ASC, [DATAAREAID] ASC, [PARTITION] ASC)
);
GO


CREATE NONCLUSTERED INDEX [nci_wi_GeneralJournalAccountEntryStaging_DATAAREAID_EXECUTIONID] ON [dbo].[GeneralJournalAccountEntryStaging]
(
	[DATAAREAID] ASC,
	[EXECUTIONID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [nci_wi_GeneralJournalAccountEntryStaging_ACCT_CUR_LEDGER]
    ON [dbo].[GeneralJournalAccountEntryStaging] ([ACCOUNTINGDATE])
    INCLUDE ([ACCOUNTDISPLAYVALUE], [ACCOUNTINGCURRENCYAMOUNT], [LEDGERNAME])
    WITH (ONLINE = ON);
GO