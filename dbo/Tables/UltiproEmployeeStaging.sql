﻿Create TABLE [dbo].[UltiproEmployeeStaging] (
    [EmployeeNumber]            VARCHAR (50)   NULL,
    [LastName]                  VARCHAR (202)  NULL,
    [FirstName]                 VARCHAR (202)  NULL,
    [PreferredFirstName]        VARCHAR (202)  NULL,
    [MiddleName]                VARCHAR (102)  NULL,
    [TypeOther]                 VARCHAR (2002) NULL,
    [WorkPhone]                 VARCHAR (102)  NULL,
    [CellPhone]                 VARCHAR (102)  NULL,
    [EmailAddress]              VARCHAR (102)  NULL,
    [LastHire]                  DATETIME       NULL,
    [JobCode]                   VARCHAR (18)   NULL,
    [IsisStockLevel]            VARCHAR (52)   NULL,
    [Title]                     VARCHAR (302)  NULL,
    [SupervisorEmployeenumber]  VARCHAR (20)   NULL,
    [CompanyCode]               VARCHAR (12)   NULL,
    [Department]                VARCHAR (52)   NULL,
    [MailStop]                  VARCHAR (22)   NULL,
    [DepartmentNumber]          VARCHAR (22)   NULL,
    [TerminationDate]           DATETIME       NULL,
    [SalaryHourlyCode]          VARCHAR (4)    NULL,
    [ScheduledWorkHours]        DECIMAL (16,6) NULL,
    [EmploymentStatusCode]      VARCHAR (4)    NULL,
    [EmploymentTypeCode]        VARCHAR (8)    NULL,
    [StatusAsOf]                DATETIME       NULL,
    [AnticipatedEndDate]        DATETIME       NULL,
    EeoEstablishmentName        VARCHAR (72)   NULL,
    [ProjectCode]               VARCHAR (32)   NULL,
    [Project]                   VARCHAR (2002)   NULL,
    [LocalCurrency]             VARCHAR (50)    NULL,
    [RecordProcessed]           VARCHAR (1) NULL,
    [TestColumn]                VARCHAR (25) NULL 
);
