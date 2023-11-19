CREATE TABLE [financial].[DimEmployee]
(
	[EmployeeKey] [int] IDENTITY(1,1) NOT NULL,
	[CompanyID] [varchar](20) NULL,
	[SourceEmployeeId] [varchar](25) NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[PrefferedName] [varchar](100) NULL,
	[FullName] [varchar] (200) NULL,
    [Email] [varchar](100) NULL,
	[WorkPhone] [varchar](50) NULL,
	[CompanyCode] [varchar](15) NULL,
	[FTE] [int] NULL,
	[EmployeeNumber] [varchar](15) NULL,
	[SupervisorCompanyCode] [varchar](15) NULL,
	[SupervisorEmployeeNumber] [varchar](15) NULL,
	[ManagerKey] [int] NULL,
	[Department] [varchar](50) NULL,
	[DepartmentKey] [int] NULL,
	[WorkPlaceLocation] [varchar](15) NULL,
	[WorkPlaceName] [varchar](100) NULL,
	[StockLevelCode] [varchar](15) NULL, 
	[JobCode] [varchar](50) NULL,
	[EmploymentStatus] [char](1) NULL,
	[Active] [int] NULL,
    [ExemptStatus] [varchar](3) NULL,
	[ScheduledHours] [float] NULL,
	[JobTitle] [varchar](250) NULL,
	[StatusStartDate] [date] NULL,
	[OriginalHireDate] [date] NULL,
	[LastHireDate] [date] NULL,
	[TerminationDate] [date] NULL,
	[FullOrPartTime] [char](1) NULL,
	[EmployeeType] [varchar](50) NULL,
	[CoupaUserId] [int] NULL,
	[SourceCreatedDate] [datetime] NULL,
	[SourceUpdatedDate] [datetime] NULL,
	[RowHash] [varbinary](8000) NULL,
	[EFF_START_DT] [datetime] NULL,
	[EFF_END_DT] [datetime] NULL,
    [AuditCreatedAt] DATETIME NULL,
    [AuditCreatedBy] VARCHAR(100) NULL,
    [AuditUpdatedAt] DATETIME NULL,
    [AuditUpdatedBy] VARCHAR(100) NULL
)