CREATE TABLE [dbo].[RSMVendTransStaging] (
    [DEFINITIONGROUP]         NVARCHAR (60)   NOT NULL,
    [EXECUTIONID]             NVARCHAR (90)   NOT NULL,
    [ISSELECTED]              INT             NOT NULL,
    [TRANSFERSTATUS]          INT             NOT NULL,
    [ACCOUNTINGEVENT]         BIGINT          NOT NULL,
    [VENDORACCOUNTNUM]        NVARCHAR (20)   NOT NULL,
    [DOCUMENTNUM]             NVARCHAR (20)   NOT NULL,
    [DOCUMENTDATE]            DATETIME        NOT NULL,
    [REPORTINGCURRENCYAMOUNT] NUMERIC (32, 6) NOT NULL,
    [TRANSDATE]               DATETIME        NOT NULL,
    [VOUCHER]                 NVARCHAR (20)   NOT NULL,
    [VENDTRANSRECID]          BIGINT          NOT NULL,
    [PARTITION]               NVARCHAR (20)   NOT NULL,
    [CURRENCYCODE]            NVARCHAR (3)    NOT NULL,
    [TRANSTYPE]               INT             NOT NULL,
    [TXT]                     NVARCHAR (60)   NOT NULL,
    [INVOICE]                 NVARCHAR (20)   NOT NULL,
    [DATAAREAID]              NVARCHAR (4)    NOT NULL,
    [SYNCSTARTDATETIME]       DATETIME        NOT NULL,
    [RECID]                   BIGINT          NOT NULL,
    CONSTRAINT [PK_RSMVendTransStaging] PRIMARY KEY CLUSTERED ([EXECUTIONID] ASC, [VENDTRANSRECID] ASC, [DATAAREAID] ASC, [PARTITION] ASC)
);

