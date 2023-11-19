CREATE procedure [dbo].[spInitializeDimEmployee] as

truncate table ActiveEmployeesHistory

insert into ActiveEmployeesHistory

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
	  --,CASE WHEN NOT CompanyCode in (SELECT EntityID from DimEntity) or CompanyCode is null THEN 'IONS' ELSE CompanyCode END
      ,[Department]
      ,[Building]
	  --,CASE WHEN NOT CompanyCode in (SELECT EntityID from DimEntity) or CompanyCode is null THEN 'XXXX' ELSE [Building] END
      ,[DepartmentCode]
	  --,CASE WHEN DepartmentCode is null then 'NULL' ELSE DepartmentCode end
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
	  from ActiveEmployees

update ActiveEmployeesHistory
set FromDate=PersonJobStartDate

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
	fc.FullDate<=dateadd(m,1,GETDATE()) and fc.FullDate>='1/1/2019' and
	fc.FullDate<=ae.ToDate and MONTH(dateadd(d,1,fc.FullDate))<>MONTH(fc.FullDate)
ORDER BY EmployeeID