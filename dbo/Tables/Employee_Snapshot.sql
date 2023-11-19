CREATE TABLE [dbo].[Employee_Snapshot](   
    [UserKey] [int] NOT NULL,
    [FiscalPeriod] [varchar] (7) NOT NULL, --> YYYY-mm
    [Department] [char](3) NOT NULL,
    [EmployeeName] [varchar](100) NOT NULL,
    [Title] [varchar](80) NULL,
    [ReportsToName] [varchar](100) NULL,
    [CompanyCode] [varchar](15) NULL,
    [FullTimeEquivalent] [numeric](19, 2) NULL,
    [AnnualSal] [nvarchar] (50) NULL, --> encypted value. US dollars if Currency field is blank,
    [HourlyRate] [nvarchar] (50) NULL, -->encypted value. US dollars if Currency field is blank,
    [Currency] VARCHAR(3) NULL
    CONSTRAINT [UQ_UserAndPeriod] UNIQUE NONCLUSTERED
    (
        [UserKey], [FiscalPeriod]
    ),
    [DateModified] DATETIME NULL, 
    CONSTRAINT [FK_EmployeeSnapshot_DimUser_UserKey] FOREIGN KEY ([UserKey]) REFERENCES [dbo].[DimUser] ([UserKey])
) 

GO
CREATE NONCLUSTERED INDEX [idx_EmployeeSnapshot_EmployeeName]
   ON [dbo].[Employee_Snapshot]([EmployeeName] ASC) WITH (FILLFACTOR = 80);