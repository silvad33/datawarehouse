CREATE TABLE [dbo].[RSMSubLedgerJournalEntryStaging] (
    [DEFINITIONGROUP]                 NVARCHAR (60)  NOT NULL,
    [EXECUTIONID]                     NVARCHAR (90)  NOT NULL,
    [ISSELECTED]                      INT            NOT NULL,
    [TRANSFERSTATUS]                  INT            NOT NULL,
    [ACCOUNTINGEVENT]                 BIGINT         NOT NULL,
    [DOCUMENTDATE]                    DATETIME       NOT NULL,
    [DOCUMENTNUMBER]                  NVARCHAR (20)  NOT NULL,
    [JOURNALNUMBER]                   NVARCHAR (20)  NOT NULL,
    [LEDGER]                          BIGINT         NOT NULL,
    [POSTINGLAYER]                    INT            NOT NULL,
    [REFERENCEIDENTITYTRANSFERSTATUS] INT            NOT NULL,
    [STATUS]                          INT            NOT NULL,
    [TRANSTXT]                        NVARCHAR (512) NOT NULL,
    [TYPE]                            INT            NOT NULL,
    [VOUCHER]                         NVARCHAR (20)  NOT NULL,
    [VOUCHERDATAAREAID]               NVARCHAR (4)   NOT NULL,
    [RECIDCOPY1]                      BIGINT         NOT NULL,
    [PARTITION]                       NVARCHAR (20)  NOT NULL,
    [SYNCSTARTDATETIME]               DATETIME       NOT NULL,
    [RECID]                           BIGINT         NOT NULL,
    CONSTRAINT [PK_RSMSubLedgerJournalEntryStaging] PRIMARY KEY CLUSTERED ([EXECUTIONID] ASC, [RECIDCOPY1] ASC, [PARTITION] ASC)
);

