CREATE TABLE [dbo].[ExchangeRateEntityStaging] (
    [DEFINITIONGROUP]        NVARCHAR (60)    NOT NULL,
    [EXECUTIONID]            NVARCHAR (90)    NOT NULL,
    [ISSELECTED]             INT              NOT NULL,
    [TRANSFERSTATUS]         INT              NOT NULL,
    [EXCHANGERATEFORSTORAGE] NUMERIC (32, 16) NOT NULL,
    [STARTDATE]              DATETIME         NOT NULL,
    [ENDDATE]                DATETIME         NOT NULL,
    [CONVERSIONFACTOR]       INT              NOT NULL,
    [FROMCURRENCY]           NVARCHAR (3)     NOT NULL,
    [TOCURRENCY]             NVARCHAR (3)     NOT NULL,
    [RATETYPEDESCRIPTION]    NVARCHAR (60)    NOT NULL,
    [RATETYPENAME]           NVARCHAR (20)    NOT NULL,
    [RATE]                   NUMERIC (32, 16) NOT NULL,
    [PARTITION]              NVARCHAR (20)    NOT NULL,
    [SYNCSTARTDATETIME]      DATETIME         NOT NULL,
    [RECID]                  BIGINT           NOT NULL,
    CONSTRAINT [PK_ExchangeRateEntityStaging] PRIMARY KEY CLUSTERED ([EXECUTIONID] ASC, [STARTDATE] ASC, [FROMCURRENCY] ASC, [TOCURRENCY] ASC, [RATETYPENAME] ASC, [PARTITION] ASC)
);

