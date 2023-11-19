﻿CREATE TABLE [dbo].[MainAccountTotalAccountIntervalEntityStaging] (
    [DEFINITIONGROUP]   NVARCHAR (60) NOT NULL,
    [EXECUTIONID]       NVARCHAR (90) NOT NULL,
    [ISSELECTED]        INT           NOT NULL,
    [TRANSFERSTATUS]    INT           NOT NULL,
    [MAINACCOUNTID]     NVARCHAR (20) NOT NULL,
    [CHARTOFACCOUNTS]   NVARCHAR (60) NOT NULL,
    [FROMVALUE]         NVARCHAR (30) NOT NULL,
    [TOVALUE]           NVARCHAR (30) NOT NULL,
    [INVERTTOTALSIGN]   INT           NOT NULL,
    [PARTITION]         NVARCHAR (20) NOT NULL,
    [SYNCSTARTDATETIME] DATETIME      NOT NULL,
    [RECID]             BIGINT        NOT NULL,
    CONSTRAINT [PK_MainAccountTotalAccountIntervalEntityStaging] PRIMARY KEY CLUSTERED ([EXECUTIONID] ASC, [MAINACCOUNTID] ASC, [CHARTOFACCOUNTS] ASC, [FROMVALUE] ASC, [TOVALUE] ASC, [PARTITION] ASC)
);
