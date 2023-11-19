/*
User Defined Function: fnDimEmployeeByPeriod
Author: Richard Crook
Date: 2021-04-01
Parameters:
  Year - The year of the period being requested
  Month - The month of the period being requested
Returns:
  Table - Month End Date and DimEmployee.EmployeeKey for DimDimployee records valid at the last day of the requested year and month
Purpose:
  Return a snapshot of the DimEmployee keys valid at the end of a given month to support an Employee snapshot monthly view
*/
CREATE FUNCTION [financial].[fnDimEmployeeByPeriod] (
  @Year INT,
  @Month INT
)
RETURNS @DimEmployee TABLE (
  PeriodEndDate DATE,
  EmployeeKey INT
)
BEGIN
  DECLARE @MonthEnd DATE
  SET @MonthEnd = EOMONTH(DATEFROMPARTS(@Year,@Month,1))

  --find the effective record by filtering effective start <= eom and isnull(effective end, now) <= eom, reverse sort by effective start choose the top one
  INSERT INTO @DimEmployee
  SELECT @MonthEnd AS PeriodEndDate, EmployeeKey
  FROM financial.DimEmployee
  WHERE (EFF_START_DT <= @MonthEnd AND ISNULL(EFF_END_DT,@MonthEnd) >= @MonthEnd)

  RETURN
END
GO