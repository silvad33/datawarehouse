CREATE TABLE [dbo].[rsmAccountingEventStaging] (
    [DEFINITIONGROUP]       NVARCHAR (60) NOT NULL,
    [EXECUTIONID]           NVARCHAR (90) NOT NULL,
    [ISSELECTED]            INT           NOT NULL,
    [TRANSFERSTATUS]        INT           NOT NULL,
    [ACCOUNTINGDATE]        DATETIME      NOT NULL,
    [CREATEDBY1]            NVARCHAR (20) NOT NULL,
    [CREATEDDATETIME1]      DATETIME      NOT NULL,
    [CREATEDTRANSACTIONID1] BIGINT        NOT NULL,
    [EVENTDATETIME]         DATETIME      NOT NULL,
    [MODIFIEDBY1]           NVARCHAR (20) NOT NULL,
    [MODIFIEDDATETIME1]     DATETIME      NOT NULL,
    [PARTITION1]            BIGINT        NOT NULL,
    [RECID1]                BIGINT        NOT NULL,
    [RECVERSION1]           INT           NOT NULL,
    [SOURCEDOCUMENTHEADER]  BIGINT        NOT NULL,
    [STATE]                 INT           NOT NULL,
    [TYPE]                  INT           NOT NULL,
    [PARTITION]             NVARCHAR (20) NOT NULL,
    [SYNCSTARTDATETIME]     DATETIME      NOT NULL,
    [RECID]                 BIGINT        NOT NULL,
    CONSTRAINT [PK_rsmAccountingEventStaging] PRIMARY KEY CLUSTERED ([EXECUTIONID] ASC, [RECID1] ASC, [PARTITION] ASC)
);

