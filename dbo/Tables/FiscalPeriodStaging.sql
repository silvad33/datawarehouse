CREATE TABLE [dbo].[FiscalPeriodStaging] (
    [DEFINITIONGROUP]   NVARCHAR (60) NOT NULL,
    [EXECUTIONID]       NVARCHAR (90) NOT NULL,
    [ISSELECTED]        INT           NOT NULL,
    [TRANSFERSTATUS]    INT           NOT NULL,
    [COMMENTS]          NVARCHAR (60) NOT NULL,
    [ENDDATE]           DATETIME      NOT NULL,
    [MONTH]             INT           NOT NULL,
    [PERIODNAME]        NVARCHAR (60) NOT NULL,
    [QUARTER]           INT           NOT NULL,
    [SHORTNAME]         NVARCHAR (8)  NOT NULL,
    [STARTDATE]         DATETIME      NOT NULL,
    [TYPE]              INT           NOT NULL,
    [CALENDAR]          NVARCHAR (10) NOT NULL,
    [FISCALYEAR]        NVARCHAR (10) NOT NULL,
    [CALENDARTYPE]      INT           NOT NULL,
    [DAYS]              INT           NOT NULL,
    [PARTITION]         NVARCHAR (20) NOT NULL,
    [SYNCSTARTDATETIME] DATETIME      NOT NULL,
    [RECID]             BIGINT        NOT NULL,
    CONSTRAINT [PK_FiscalPeriodStaging] PRIMARY KEY CLUSTERED ([EXECUTIONID] ASC, [ENDDATE] ASC, [PERIODNAME] ASC, [STARTDATE] ASC, [CALENDAR] ASC, [FISCALYEAR] ASC, [PARTITION] ASC)
);

