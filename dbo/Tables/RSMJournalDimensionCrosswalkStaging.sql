CREATE TABLE [dbo].[RSMJournalDimensionCrosswalkStaging] (
    [DEFINITIONGROUP]             NVARCHAR (60)  NOT NULL,
    [EXECUTIONID]                 NVARCHAR (90)  NOT NULL,
    [ISSELECTED]                  INT            NOT NULL,
    [TRANSFERSTATUS]              INT            NOT NULL,
    [GENERALJOURNALLEDGERACCOUNT] NVARCHAR (500) NOT NULL,
    [GENERALJOURNALRECID]         BIGINT         NOT NULL,
    [LEDGERDIMENSION]             BIGINT         NOT NULL,
    [LEDGERDIMENSIONTYPE]         INT            NOT NULL,
    [PARTITION]                   NVARCHAR (20)  NOT NULL,
    [SYNCSTARTDATETIME]           DATETIME       NOT NULL,
    [RECID]                       BIGINT         NOT NULL,
    CONSTRAINT [PK_RSMJournalDimensionCrosswalkStaging] PRIMARY KEY CLUSTERED ([EXECUTIONID] ASC, [GENERALJOURNALRECID] ASC, [PARTITION] ASC)
);

