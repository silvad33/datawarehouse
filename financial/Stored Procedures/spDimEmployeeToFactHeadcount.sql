CREATE PROCEDURE [financial].[spDimEmployeeToFactHeadcount]
AS
/*
DECLARE @Year INT
SET @Year = 2021

DECLARE @Jan AS DATE
DECLARE @Feb AS DATE
DECLARE @Mar AS DATE
DECLARE @Apr AS DATE
DECLARE @May AS DATE
DECLARE @Jun AS DATE
DECLARE @Jul AS DATE
DECLARE @Aug AS DATE
DECLARE @Sep AS DATE
DECLARE @Oct AS DATE
DECLARE @Nov AS DATE
DECLARE @Dec AS DATE

SET @Jan = DATEFROMPARTS(@Year, 1, 1)
SET @Jan = EOMONTH(@Jan)
SET @Feb = DATEFROMPARTS(@Year, 1, 1)
SET @Feb = EOMONTH(@Jan)
SET @Mar = DATEFROMPARTS(@Year, 1, 1)
SET @Mar = EOMONTH(@Jan)
SET @Apr = DATEFROMPARTS(@Year, 1, 1)
SET @Apr = EOMONTH(@Jan)
SET @May = DATEFROMPARTS(@Year, 1, 1)
SET @May = EOMONTH(@Jan)
SET @Jun = DATEFROMPARTS(@Year, 1, 1)
SET @Jun = EOMONTH(@Jan)
SET @Jul = DATEFROMPARTS(@Year, 1, 1)
SET @Jul = EOMONTH(@Jan)
SET @Aug = DATEFROMPARTS(@Year, 1, 1)
SET @Aug = EOMONTH(@Jan)
SET @Sep = DATEFROMPARTS(@Year, 1, 1)
SET @Sep = EOMONTH(@Jan)
SET @Oct = DATEFROMPARTS(@Year, 1, 1)
SET @Oct = EOMONTH(@Jan)
SET @Nov = DATEFROMPARTS(@Year, 1, 1)
SET @Nov = EOMONTH(@Jan)
SET @Dec = DATEFROMPARTS(@Year, 1, 1)
SET @Dec = EOMONTH(@Jan)

SELECT FC.*, EMP.*
FROM (
  SELECT @Year AS [Year], 1 AS [MonthNumber], *
  FROM financial.DimEmployee AS E1
  --WHERE E1.

    WHERE ISNULL(EFF_START_DT,'1/1/1901') <= @EndDate 
      AND ISNULL(EFF_END_DT,GETDATE()) >= @StartDate  
) AS QRY
WHERE RowNumber = 1
  AND ((EmploymentStatus = 'A' AND LastHireDate <= @EndDate)
        OR (EmploymentStatus = 'T' AND StatusStartDate >= @StartDate)
        OR (EmploymentStatus = 'L' AND LastHireDate <= @EndDate))


) AS EMP INNER JOIN (
  SELECT FC.[Year], FC.MonthNumber, FC.FullDate, FC.MonthName
  FROM DimFinancialCalendar AS FC
  WHERE FC.[Year] = @Year
    AND FC.EntityKey = 1 --simplify, could use the Employee Company to link to Entity to get fiscal calendar for specific entity
    AND FC.FullDate = FC.EndDate --get the last day of the month
) AS FC ON 
WHERE EMP.EmployeeNumber = '04046'
*/
RETURN 0