/*
View: vEmployeeSnapshot
Purpose: Use the slowly changing values of DimEmployee through the udf fnDimEmployeeByPeriod to create a snapshot of employee values month-by-month for the current year and prior year
Sample: 
  SELECT * FROM financial.vEmployeeSnapshot WHERE LastName='Silva'
*/
CREATE VIEW [financial].[vEmployeeSnapshot]
AS
SELECT SNAP.PeriodEndDate, E.CompanyCode, E.EmployeeNumber, E.SupervisorCompanyCode, E.SupervisorEmployeeNumber
  , E.Department, E.FirstName, E.LastName, E.JobCode, E.EmploymentStatus AS SnapshotEmployementStatus
  , CASE WHEN (E.EmploymentStatus = 'T' AND E.LastHireDate <= SNAP.PeriodEndDate AND E.StatusStartDate >= SNAP.PeriodEndDate) THEN 'A'
         WHEN (E.LastHireDate > SNAP.PeriodEndDate) THEN 'N'
         ELSE E.EmploymentStatus END AS CalculatedEmploymentStatus
  , E.ScheduledHours, E.JobTitle
  , E.StatusStartDate, E.OriginalHireDate, E.LastHireDate, E.FullOrPartTime, E.EmployeeType
FROM (
  --current year
  SELECT *
  FROM financial.fnDimEmployeeByPeriod(DATEPART(YEAR,GETDATE()),1)
  UNION
  SELECT *
  FROM financial.fnDimEmployeeByPeriod(DATEPART(YEAR,GETDATE()),2)
  UNION
  SELECT *
  FROM financial.fnDimEmployeeByPeriod(DATEPART(YEAR,GETDATE()),3)
  UNION
  SELECT *
  FROM financial.fnDimEmployeeByPeriod(DATEPART(YEAR,GETDATE()),4)
  UNION
  SELECT *
  FROM financial.fnDimEmployeeByPeriod(DATEPART(YEAR,GETDATE()),5)
  UNION
  SELECT *
  FROM financial.fnDimEmployeeByPeriod(DATEPART(YEAR,GETDATE()),6)
  UNION
  SELECT *
  FROM financial.fnDimEmployeeByPeriod(DATEPART(YEAR,GETDATE()),7)
  UNION
  SELECT *
  FROM financial.fnDimEmployeeByPeriod(DATEPART(YEAR,GETDATE()),8)
  UNION
  SELECT *
  FROM financial.fnDimEmployeeByPeriod(DATEPART(YEAR,GETDATE()),9)
  UNION
  SELECT *
  FROM financial.fnDimEmployeeByPeriod(DATEPART(YEAR,GETDATE()),10)
  UNION
  SELECT *
  FROM financial.fnDimEmployeeByPeriod(DATEPART(YEAR,GETDATE()),11)
  UNION
  SELECT *
  FROM financial.fnDimEmployeeByPeriod(DATEPART(YEAR,GETDATE()),12)
  UNION
  --prior year
  SELECT *
  FROM financial.fnDimEmployeeByPeriod(DATEPART(YEAR,DATEADD(YEAR,-1,GETDATE())),1)
  UNION
  SELECT *
  FROM financial.fnDimEmployeeByPeriod(DATEPART(YEAR,DATEADD(YEAR,-1,GETDATE())),2)
  UNION
  SELECT *
  FROM financial.fnDimEmployeeByPeriod(DATEPART(YEAR,DATEADD(YEAR,-1,GETDATE())),3)
  UNION
  SELECT *
  FROM financial.fnDimEmployeeByPeriod(DATEPART(YEAR,DATEADD(YEAR,-1,GETDATE())),4)
  UNION
  SELECT *
  FROM financial.fnDimEmployeeByPeriod(DATEPART(YEAR,DATEADD(YEAR,-1,GETDATE())),5)
  UNION
  SELECT *
  FROM financial.fnDimEmployeeByPeriod(DATEPART(YEAR,DATEADD(YEAR,-1,GETDATE())),6)
  UNION
  SELECT *
  FROM financial.fnDimEmployeeByPeriod(DATEPART(YEAR,DATEADD(YEAR,-1,GETDATE())),7)
  UNION
  SELECT *
  FROM financial.fnDimEmployeeByPeriod(DATEPART(YEAR,DATEADD(YEAR,-1,GETDATE())),8)
  UNION
  SELECT *
  FROM financial.fnDimEmployeeByPeriod(DATEPART(YEAR,DATEADD(YEAR,-1,GETDATE())),9)
  UNION
  SELECT *
  FROM financial.fnDimEmployeeByPeriod(DATEPART(YEAR,DATEADD(YEAR,-1,GETDATE())),10)
  UNION
  SELECT *
  FROM financial.fnDimEmployeeByPeriod(DATEPART(YEAR,DATEADD(YEAR,-1,GETDATE())),11)
  UNION
  SELECT *
  FROM financial.fnDimEmployeeByPeriod(DATEPART(YEAR,DATEADD(YEAR,-1,GETDATE())),12)
) AS SNAP INNER JOIN financial.DimEmployee AS E ON SNAP.EmployeeKey = E.EmployeeKey