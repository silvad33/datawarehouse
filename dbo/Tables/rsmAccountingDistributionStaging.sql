﻿CREATE TABLE [dbo].[rsmAccountingDistributionStaging] (
    [DEFINITIONGROUP]                   NVARCHAR (60)   NOT NULL,
    [EXECUTIONID]                       NVARCHAR (90)   NOT NULL,
    [ISSELECTED]                        INT             NOT NULL,
    [TRANSFERSTATUS]                    INT             NOT NULL,
    [ACCOUNTINGDATE]                    DATETIME        NOT NULL,
    [ALLOCATIONFACTOR]                  NUMERIC (32, 6) NOT NULL,
    [AMOUNTSOURCE]                      INT             NOT NULL,
    [MONETARYAMOUNT]                    INT             NOT NULL,
    [NUMBER_]                           BIGINT          NOT NULL,
    [REFERENCEROLE]                     INT             NOT NULL,
    [TRANSACTIONCURRENCY]               NVARCHAR (3)    NOT NULL,
    [TRANSACTIONCURRENCYAMOUNT]         NUMERIC (32, 6) NOT NULL,
    [TYPE]                              INT             NOT NULL,
    [ACCOUNTINGLEGALENTITY_PARTYNUMBER] NVARCHAR (40)   NOT NULL,
    [ACCOUNTINGLEGALENTITY_DATAAREA]    NVARCHAR (4)    NOT NULL,
    [PARENTDISTRIBUTION_NUMBER]         BIGINT          NOT NULL,
    [REFERENCEDISTRIBUTION_NUMBER]      BIGINT          NOT NULL,
    [LEDGERDIMENSIONDISPLAYVALUE]       NVARCHAR (500)  NOT NULL,
    [RECID1]                            BIGINT          NOT NULL,
    [PARTITION]                         NVARCHAR (20)   NOT NULL,
    [ACCOUNTINGEVENT]                   BIGINT          NOT NULL,
    [ACCOUNTINGLEGALENTITY]             BIGINT          NOT NULL,
    [FINALIZEACCOUNTINGEVENT]           BIGINT          NOT NULL,
    [REFERENCEDISTRIBUTION]             BIGINT          NOT NULL,
    [SOURCEDOCUMENTHEADER]              BIGINT          NOT NULL,
    [SOURCEDOCUMENTLINE]                BIGINT          NOT NULL,
    [SYNCSTARTDATETIME]                 DATETIME        NOT NULL,
    [RECID]                             BIGINT          NOT NULL,
    CONSTRAINT [PK_rsmAccountingDistributionStaging] PRIMARY KEY CLUSTERED ([EXECUTIONID] ASC, [RECID1] ASC, [PARTITION] ASC)
);

