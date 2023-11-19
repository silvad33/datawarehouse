CREATE TABLE [dbo].[BuildingAccessActivity] (
    [RecordId]               INT           IDENTITY (1, 1) NOT NULL,
    [BuildingAccessReportId] INT           NOT NULL,
    [BadgeNumber]            VARCHAR (50)  NOT NULL,
    [FirstName]              VARCHAR (100) NOT NULL,
    [LastName]               VARCHAR (100) NULL,
    [TerminalName]           VARCHAR (100) NULL,
    [HistoryType]            VARCHAR (50)  NULL,
    [IssueLevel]             VARCHAR (50)  NULL,
    [ActivityDate]           DATETIME      NOT NULL,
    [IsSuperUser]            VARCHAR (10)  NULL,
    [TimedOverrid]           VARCHAR (50)  NULL,
    [DateInserted]           DATETIME      CONSTRAINT [CS_BuildingAccessActivity_DateInserted] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_BuildingAccessActivity_RecorId] PRIMARY KEY CLUSTERED ([RecordId] ASC),
    CONSTRAINT [FK_BuildingAccessActivit_ReportId] FOREIGN KEY ([BuildingAccessReportId]) REFERENCES [dbo].[BuildingAccessReportHist] ([ReportId]) ON DELETE CASCADE
);

