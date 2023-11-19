CREATE TABLE [financial].[StgUltiproEmployee] (
    [EmployeeKey] [int] IDENTITY(1, 1) NOT NULL
    , [CompanyID] [varchar](20) NULL
    , [UltiproEmployeeID] [varchar](20) NULL
    , [CompanyCode] [varchar](5) NULL
    , [EmployeeNumber] [char](5) NULL
    , [SupervisorCompanyCode] [varchar](5) NULL
    , [SupervisorEmployeeNumber] [char](5) NULL
    , [Department] [varchar](50) NULL
    , [FirstName] [varchar](50) NULL
    , [LastName] [varchar](50) NULL
    , [JobCode] [varchar](50) NULL
    , [EmploymentStatus] [char](1) NULL
    , [ScheduledHours] [float] NULL
    , [JobTitle] [varchar](50) NULL
    , [StatusStartDate] [date] NULL
    , [OriginalHireDate] [date] NULL
    , [LastHireDate] [date] NULL
    , [FullOrPartTime] [char](1) NULL
    , [EmployeeType] [varchar](50) NULL
    , [RowHash] [varbinary](8000) NULL
    , [EFF_START_DT] [datetime] NULL
    , [EFF_END_DT] [datetime] NULL
    )