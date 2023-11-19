﻿CREATE TABLE [dbo].[FactAccountingSourceExplorer] (
    [SubLedgerSource]                    VARCHAR (50)    NULL,
    [JournalNumber]                      NVARCHAR (20)   NOT NULL,
    [AccountingDate]                     DATETIME        NOT NULL,
    [VOUCHER]                            NVARCHAR (20)   NOT NULL,
    [DocumentNumber]                     NVARCHAR (200)   NOT NULL,
    [DocumentDate]                       DATETIME        NULL,
    [JournalCategory]                    INT             NOT NULL,
    [PostingType]                        INT             NOT NULL,
    [SubLedgerDocumentDescription]       NVARCHAR (60)   NOT NULL,
    [LedgerAccount]                      NVARCHAR (500)  NOT NULL,
    [SubLedgerTransactionCurrency]       NVARCHAR (3)    NOT NULL,
    [LedgerDimension]                    BIGINT          NOT NULL,
    [FactTransactionKey]                 BIGINT          NOT NULL,
    [IsCorrection]                       INT             NOT NULL,
    [Side]                               INT             NOT NULL,
    [SubLedgerAccountingCurrencyAmount]  NUMERIC (32, 6) NOT NULL,
    [SubLedgerReportingCurrencyAmount]   NUMERIC (32, 6) NOT NULL,
    [SubLedgerTransactionCurrencyAmount] NUMERIC (32, 6) NOT NULL,
    [MonetaryAmount]                     INT             NULL,
    [AccountingDistributionRecId]        BIGINT          NOT NULL,
    [DestinationCompany]                 NVARCHAR (1000) NULL,
    [TypeEnumName]                       VARCHAR (1000)  NULL,
    [SourceDocumentRecId]                BIGINT          NOT NULL,
    [SourceRelationType]                 VARCHAR (1000)  NULL,
    [MainAccountId]                      VARCHAR (10)    NOT NULL,
    [MainAccountName]                    VARCHAR (1000)  NULL,
    [SubLedgerPartyNumber]               NVARCHAR (1000) NULL,
    [SubLedgerPartyName]                 NVARCHAR (1000) NULL,
    [LINEDOCUMENTREFERENCE]              NVARCHAR (1000) NULL,
        [PostingTypeDescription]             NVARCHAR (120)  NULL
);

