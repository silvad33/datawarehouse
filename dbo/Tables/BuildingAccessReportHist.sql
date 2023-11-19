CREATE TABLE [dbo].[BuildingAccessReportHist] (
    [ReportId]        INT           IDENTITY (1, 1) NOT NULL,
    [DateFileCreated] DATETIME      NOT NULL,
    [ReportFileName]  VARCHAR (100) NOT NULL,
    [ActivityFrom]    DATETIME      NOT NULL,
    [ActivityTo]      DATETIME      NOT NULL,
    [DateInserted]    DATETIME      CONSTRAINT [CS_BuildingAccessReportHist_DateInserted] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_BuildgReport_ReportId] PRIMARY KEY CLUSTERED ([ReportId] ASC)
);

