CREATE TABLE [dbo].[AllEmployees_Snapshot] (
    [PeriodDate]         DATE            NOT NULL,
    [Department]         CHAR (3)        NOT NULL,
    [EmployeeID]         VARCHAR (15)    NOT NULL,
    [EmployeeName]       VARCHAR (100)   NOT NULL,
    [Title]              VARCHAR (80)    NULL,
    [ReportsToName]      VARCHAR (100)   NULL,
    [CompanyCode]        VARCHAR (15)    NULL,
    [FullTimeEquivalent] NUMERIC (19, 2) NULL
);

