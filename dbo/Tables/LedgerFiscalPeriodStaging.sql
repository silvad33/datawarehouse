﻿CREATE TABLE [dbo].[LedgerFiscalPeriodStaging] (
    [DEFINITIONGROUP]             NVARCHAR (60) NOT NULL,
    [EXECUTIONID]                 NVARCHAR (90) NOT NULL,
    [ISSELECTED]                  INT           NOT NULL,
    [TRANSFERSTATUS]              INT           NOT NULL,
    [PERIODSTATUS]                INT           NOT NULL,
    [PERIODNAME]                  NVARCHAR (60) NOT NULL,
    [YEARNAME]                    NVARCHAR (10) NOT NULL,
    [CALENDAR]                    NVARCHAR (10) NOT NULL,
    [LEDGERNAME]                  NVARCHAR (20) NOT NULL,
    [LEDGERACCESSLEVEL]           INT           NOT NULL,
    [LEDGERUSERGROUPINFO]         NVARCHAR (10) NOT NULL,
    [TAXACCESSLEVEL]              INT           NOT NULL,
    [TAXUSERGROUPINFO]            NVARCHAR (10) NOT NULL,
    [BANKACCESSLEVEL]             INT           NOT NULL,
    [BANKUSERGROUPINFO]           NVARCHAR (10) NOT NULL,
    [CUSTACCESSLEVEL]             INT           NOT NULL,
    [CUSTUSERGROUPINFO]           NVARCHAR (10) NOT NULL,
    [VENDACCESSLEVEL]             INT           NOT NULL,
    [VENDUSERGROUPINFO]           NVARCHAR (10) NOT NULL,
    [SALESACCESSLEVEL]            INT           NOT NULL,
    [SALESUSERGROUPINFO]          NVARCHAR (10) NOT NULL,
    [PURCHACCESSLEVEL]            INT           NOT NULL,
    [PURCHUSERGROUPINFO]          NVARCHAR (10) NOT NULL,
    [INVENTACCESSLEVEL]           INT           NOT NULL,
    [INVENTUSERGROUPINFO]         NVARCHAR (10) NOT NULL,
    [PRODACCESSLEVEL]             INT           NOT NULL,
    [PRODUSERGROUPINFO]           NVARCHAR (10) NOT NULL,
    [PROJECTACCESSLEVEL]          INT           NOT NULL,
    [PROJECTUSERGROUPINFO]        NVARCHAR (10) NOT NULL,
    [FIXEDASSETSACCESSLEVEL]      INT           NOT NULL,
    [FIXEDASSETSUSERGROUPINFO]    NVARCHAR (10) NOT NULL,
    [PAYROLLACCESSLEVEL]          INT           NOT NULL,
    [PAYROLLUSERGROUPINFO]        NVARCHAR (10) NOT NULL,
    [EXPENSEACCESSLEVEL]          INT           NOT NULL,
    [EXPENSEUSERGROUPINFO]        NVARCHAR (10) NOT NULL,
    [FIXEDASSETS_RUACCESSLEVEL]   INT           NOT NULL,
    [FIXEDASSETS_RUUSERGROUPINFO] NVARCHAR (10) NOT NULL,
    [RETAILACCESSLEVEL]           INT           NOT NULL,
    [RETAILUSERGROUPINFO]         NVARCHAR (10) NOT NULL,
    [LEGALENTITYID]               NVARCHAR (4)  NOT NULL,
    [PARTITION]                   NVARCHAR (20) NOT NULL,
    [SYNCSTARTDATETIME]           DATETIME      NOT NULL,
    [RECID]                       BIGINT        NOT NULL,
    CONSTRAINT [PK_LedgerFiscalPeriodStaging] PRIMARY KEY CLUSTERED ([EXECUTIONID] ASC, [PERIODNAME] ASC, [YEARNAME] ASC, [CALENDAR] ASC, [LEDGERNAME] ASC, [PARTITION] ASC)
);
