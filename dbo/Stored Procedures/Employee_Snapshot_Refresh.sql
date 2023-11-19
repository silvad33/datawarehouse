CREATE PROCEDURE [dbo].[Employee_Snapshot_Refresh] 
 @FiscalPerdiodDate DATETIME
AS 
BEGIN
-- ***************DB Info ***************
-- Description  : Refresh the dbo.Employee_Snapshot table with a current month's employee info for a given date
-- Notes        : This routine will be called every day and will only replace the records for the month of the date provided in the parameter @FiscalPeriodDate
-- Dependencies : The salary table tblLocalMeritCalc needs to be freshed at least once toward the end of a month to keep salary values accurate.
-- Contact      : John O'Neill
-- Date Created : 10/26/2020
-- Change hist.	: 01/08/2021 Added HourlyRate field
--              : 03/22/2021 Added DateModified field
-- *************** /DB Info ***************

   SET NOCOUNT ON

    DECLARE @FiscalPeriod Varchar(7)
    SET @FiscalPeriod = FORMAT (@FiscalPerdiodDate,'yyyy-MM') 

    -- Delete all rows for this period, then recreate from DimUser and the salary lookkup table
  DELETE FROM dbo.Employee_Snapshot where FiscalPeriod = @FiscalPeriod

  INSERT INTO dbo.Employee_Snapshot (UserKey, FiscalPeriod, Department, EmployeeName, Title, ReportsToName, CompanyCode, FullTimeEquivalent, AnnualSal, HourlyRate, Currency, DateModified)
  SELECT DISTINCT
    du.UserKey
    ,@FiscalPeriod as FiscalPeriod
    ,ISNULL(dept.DepartmentNumber,'') as Department
    ,du.LastName + ', ' + du.FirstName     as EmployeeName
    , ISNULL(du.JobTitle,'') as Title
   , CASE 
        when boss.UserKey IS NULL then ''
        ELSE
        ISNULL(boss.LastName,'') + ', ' + ISNULL(boss.FirstName,'')
    End as ReportsToName
    , ISNULL(du.CompanyCode,'') as CompanyCode
    , ISNULL(du.FTE,1.0) as FullTimeEquivalent
    , ISNULL(sals.Sal,'') as AnnualSal
    , ISNULL(sals.HourlyRate,'') as HourlyRate
    , ISNULL(du.CurrencyCode, '') as CurrencyCode
    , GetDate() as DateModified
FROM dbo.DimUser as du
LEFT JOIN dimUser as boss on du.ManagerKey = boss.UserKey
LEFT JOIN DimDepartment as dept ON du.DepartmentKey = dept.DepartmentKey
LEFT JOIN tblLocalMeritCalc as sals on du.EmployeeNumber = sals.ID
WHERE du.UserType = 'Employee'
AND du.Active = 1;

--Rebuild the index on this table to stop fragmentation due to multiple deletes and inserts every week
 --DBCC DBREINDEX('dbo.Employee_Snapshot', '', 80) 

END
GO
