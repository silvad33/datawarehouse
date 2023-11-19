CREATE TABLE [financial_mart].[FACTHEADCOUNT]
(
  [Scenario] VARCHAR (60) NULL,
  [SubScenario] VARCHAR (60) NULL,
  [PeriodEndDate] DATE NULL,
  [InternalID] VARCHAR(20) NULL,
  [EmployeeNumber] CHAR(5) NULL,
  [ExistingNewReplace] VARCHAR(20) NULL,
  [Name] VARCHAR(100) NULL,
  [RequisitionID] VARCHAR(50) NULL,
  [Notes] VARCHAR(500) NULL,
  [Title] VARCHAR(100) NULL,
  [Case] VARCHAR(50) NULL,
  [Prioritization] VARCHAR(50) NULL,
  [GradeLevel] VARCHAR(50) NULL,
  [ProposedVsJudgment] VARCHAR(50) NULL,
  [NumberOfFTEs] INT NULL,
  [HoursPerWeek] INT NULL
)
