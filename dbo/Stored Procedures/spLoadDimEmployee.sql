CREATE PROCEDURE spLoadDimEmployee as
-- Move Current to Previous in prep for refreshing current
TRUNCATE TABLE ActiveEmployeesPrevious

-- Reload current table from the latest load
INSERT INTO ActiveEmployeesPrevious
SELECT [RowID]
      ,[EmployeeID]
      ,[LastName]
      ,[FirstName]
      ,[NickName]
      ,[MiddleName]
      ,[WorkPhone]
      ,[CellPhone]
      ,[Email]
      ,[Title]
      ,[ReportsToEmployeeID]
      ,[CompanyCode]
      ,[Department]
      ,[Building]
      ,[DepartmentCode]
      ,[EndDate]
      ,[ExemptStatus]
      ,[FullTimeEquivalent]
      ,[PersonJobStartDate]
      ,[StatusCode]
      ,[WorkStatus]
      ,[StockLevelCode]
      ,[JobCode]
      ,[JobDescription]
      ,[StatusStartDate]
      ,[EEOEstablishmentName]
FROM [dbo].[ActiveEmployeesCurrent]

-- Empty the current table
TRUNCATE TABLE ActiveEmployeesCurrent

-- Reload current table from the latest load
INSERT INTO ActiveEmployeesCurrent
SELECT [RowID]
      ,[EmployeeID]
      ,[LastName]
      ,[FirstName]
      ,[NickName]
      ,[MiddleName]
      ,[WorkPhone]
      ,[CellPhone]
      ,[Email]
      ,[Title]
      ,[ReportsToEmployeeID]
      ,[CompanyCode]
      ,[Department]
      ,[Building]
      ,[DepartmentCode]
      ,[EndDate]
      ,[ExemptStatus]
      ,[FullTimeEquivalent]
      ,[PersonJobStartDate]
      ,[StatusCode]
      ,[WorkStatus]
      ,[StockLevelCode]
      ,[JobCode]
      ,[JobDescription]
      ,[StatusStartDate]
      ,[EEOEstablishmentName]
FROM [dbo].[ActiveEmployees] 

TRUNCATE TABLE ActiveEmployeesInserted

-- Load records in latest set not in previous set of active employees
INSERT INTO ActiveEmployeesInserted

SELECT [RowID]
      ,[EmployeeID]
      ,[LastName]
      ,[FirstName]
      ,[NickName]
      ,[MiddleName]
      ,[WorkPhone]
      ,[CellPhone]
      ,[Email]
      ,[Title]
      ,[ReportsToEmployeeID]
      ,[CompanyCode]
      ,[Department]
      ,[Building]
      ,[DepartmentCode]
      ,[EndDate]
      ,[ExemptStatus]
      ,[FullTimeEquivalent]
      ,[PersonJobStartDate]
      ,[StatusCode]
      ,[WorkStatus]
      ,[StockLevelCode]
      ,[JobCode]
      ,[JobDescription]
      ,[StatusStartDate]
      ,[EEOEstablishmentName] FROM ActiveEmployeesCurrent

EXCEPT

SELECT [RowID]
      ,[EmployeeID]
      ,[LastName]
      ,[FirstName]
      ,[NickName]
      ,[MiddleName]
      ,[WorkPhone]
      ,[CellPhone]
      ,[Email]
      ,[Title]
      ,[ReportsToEmployeeID]
      ,[CompanyCode]
      ,[Department]
      ,[Building]
      ,[DepartmentCode]
      ,[EndDate]
      ,[ExemptStatus]
      ,[FullTimeEquivalent]
      ,[PersonJobStartDate]
      ,[StatusCode]
      ,[WorkStatus]
      ,[StockLevelCode]
      ,[JobCode]
      ,[JobDescription]
      ,[StatusStartDate]
      ,[EEOEstablishmentName] FROM ActiveEmployeesPrevious


TRUNCATE TABLE ActiveEmployeesDeleted

-- Load records in latest set not in current set of active employees
INSERT INTO ActiveEmployeesDeleted

SELECT [RowID]
      ,[EmployeeID]
      ,[LastName]
      ,[FirstName]
      ,[NickName]
      ,[MiddleName]
      ,[WorkPhone]
      ,[CellPhone]
      ,[Email]
      ,[Title]
      ,[ReportsToEmployeeID]
      ,[CompanyCode]
      ,[Department]
      ,[Building]
      ,[DepartmentCode]
      ,[EndDate]
      ,[ExemptStatus]
      ,[FullTimeEquivalent]
      ,[PersonJobStartDate]
      ,[StatusCode]
      ,[WorkStatus]
      ,[StockLevelCode]
      ,[JobCode]
      ,[JobDescription]
      ,[StatusStartDate]
      ,[EEOEstablishmentName] FROM ActiveEmployeesPrevious

EXCEPT

SELECT [RowID]
      ,[EmployeeID]
      ,[LastName]
      ,[FirstName]
      ,[NickName]
      ,[MiddleName]
      ,[WorkPhone]
      ,[CellPhone]
      ,[Email]
      ,[Title]
      ,[ReportsToEmployeeID]
      ,[CompanyCode]
      ,[Department]
      ,[Building]
      ,[DepartmentCode]
      ,[EndDate]
      ,[ExemptStatus]
      ,[FullTimeEquivalent]
      ,[PersonJobStartDate]
      ,[StatusCode]
      ,[WorkStatus]
      ,[StockLevelCode]
      ,[JobCode]
      ,[JobDescription]
      ,[StatusStartDate]
      ,[EEOEstablishmentName] FROM ActiveEmployeesCurrent

-- Terminate the ones that are not in current file
UPDATE ActiveEmployeesHistory
SET ToDate=CONVERT(DATE,GETDATE())
WHERE EmployeeID in (SELECT EmployeeiD FROM ActiveEmployeesDeleted) and
	ToDate='1/1/2099'

-- Load the new records
INSERT INTO ActiveEmployeesHistory
SELECT [RowID]
      ,[EmployeeID]
      ,[LastName]
      ,[FirstName]
      ,[NickName]
      ,[MiddleName]
      ,[WorkPhone]
      ,[CellPhone]
      ,[Email]
      ,[Title]
      ,[ReportsToEmployeeID]
      ,[CompanyCode]
      ,[Department]
      ,[Building]
      ,[DepartmentCode]
      ,[EndDate]
      ,[ExemptStatus]
      ,[FullTimeEquivalent]
      ,[PersonJobStartDate]
      ,[StatusCode]
      ,[WorkStatus]
      ,[StockLevelCode]
      ,[JobCode]
      ,[JobDescription]
      ,[StatusStartDate] 
	  ,convert(date,Getdate()) as FromDate
	  ,'1/1/2099' as ToDate
	  from ActiveEmployeesInserted

-- Reload DimEmployee based on new history
TRUNCATE TABLE DimEmployee
INSERT INTO DimEmployee
SELECT [RowID]
      ,[EmployeeID]
      ,[LastName]
      ,[FirstName]
      ,[NickName]
      ,[MiddleName]
      ,[WorkPhone]
      ,[CellPhone]
      ,[Email]
      ,[Title]
      ,[ReportsToEmployeeID]
      ,[CompanyCode]
      ,[Department]
      ,[Building]
      ,[DepartmentCode]
      ,ae.[EndDate]
      ,[ExemptStatus]
      ,[FullTimeEquivalent]
      ,[PersonJobStartDate]
      ,[StatusCode]
      ,[WorkStatus]
      ,[StockLevelCode]
      ,[JobCode]
      ,[JobDescription]
      ,[StatusStartDate] 
	  ,fc.MonthNumer, 
	  fc.MonthName, 
	  fc.Year, 
	  fc.[FiscalPeriodKey]
FROM ActiveEmployeesHistory ae
JOIN DimEntity e on e.EntityID=ae.CompanyCode
JOIN DimFinancialCalendar fc on fc.EntityKey=e.EntityKey and fc.FullDate>=ae.FromDate and 
	-- Don't go beyond current month
	fc.FullDate<=dateadd(m,1,GETDATE()) and 
	-- Starting in 2019
	fc.FullDate>='1/1/2019' and
	-- This gets us so we only consider the last date of the month
	fc.FullDate<=ae.ToDate and MONTH(dateadd(d,1,fc.FullDate))<>MONTH(fc.FullDate)
ORDER BY EmployeeID

