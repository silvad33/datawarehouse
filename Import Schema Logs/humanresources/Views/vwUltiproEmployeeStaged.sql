CREATE VIEW humanresources.vwUltiproEmployeeStaged AS
SELECT CONVERT(INT, REPLACE(ues.EmployeeNumber, 'UK', '44')) AS EmployeeNumber,
       TRIM(ues.EmailAddress) AS EmailAddress,
       CONVERT(INT, du.userkey) AS ManagerKey,
       dd.departmentKey AS DepartmentKey,
       TRIM(ues.PreferredFirstName) AS FirstName,
       TRIM(ues.LastName) AS LastName,
       CONCAT(CONCAT(TRIM(ues.PreferredFirstName), ' '), TRIM(ues.LastName)) AS FullName,
       CASE 
           -- handles all numbers greater than 10
           WHEN SUBSTRING(IsisStockLevel, CHARINDEX('Level', IsisStockLevel) + 6, 10) IN ( '10-300', '11', '12', '13' ) THEN
               SUBSTRING(IsisStockLevel, CHARINDEX('Level', IsisStockLevel) + 6, 10)
           -- handles the sales people
           WHEN SUBSTRING(IsisStockLevel, CHARINDEX('Level', IsisStockLevel) + 6, 10) LIKE 'S%' THEN
               CONCAT('0', RIGHT(IsisStockLevel, CHARINDEX('S', REVERSE(IsisStockLevel) + 'S') - 1))
           WHEN LEN(SUBSTRING(IsisStockLevel, CHARINDEX('Level', IsisStockLevel) + 6, 10)) < 5 THEN
               CONCAT('0', SUBSTRING(IsisStockLevel, CHARINDEX('Level', IsisStockLevel) + 6, 10))
           ELSE
               NULL
       END AS StockLevelCode,
       CASE
           WHEN TRIM(ues.EmploymentTypeCode) = 'REG' THEN
               'Employee'
           ELSE
               ues.EmploymentTypeCode
       END AS UserType,
       CASE
           WHEN TRIM(ues.EmploymentStatusCode) in ('A', 'L') THEN
               1
           ELSE
               0
       END AS Active,
       CASE
           WHEN CHARINDEX('ionis', ues.EmailAddress) > 0
                AND TRIM(ues.CompanyCode) = 'TEMP' THEN
               'IONS'
           WHEN CHARINDEX('akcea', ues.EmailAddress) > 0
                AND TRIM(ues.CompanyCode) = 'TEMP' THEN
               'AKCEA'
           WHEN TRIM(ues.CompanyCode) IN ( 'AKCCA', 'AKCCN' ) THEN
               'AKCA'
           WHEN TRIM(ues.CompanyCode) IN ( 'AKCCY' ) THEN
               'AKCY'
           WHEN TRIM(ues.CompanyCode) IN ( 'AKCDE', 'AKCGR' ) THEN
               'AKDE'
           WHEN TRIM(ues.CompanyCode) IN ( 'AKCSP', 'AKSE', 'AKSP', 'AKCSE' ) THEN
               'AKES'
           WHEN TRIM(ues.CompanyCode) IN ( 'AKCFR' ) THEN
               'AKFR'
           WHEN TRIM(ues.CompanyCode) IN ( 'AKCIE' ) THEN
               'AKIE'
           WHEN TRIM(ues.CompanyCode) IN ( 'AKCIT' ) THEN
               'AKIT'
           WHEN TRIM(ues.CompanyCode) IN ( 'AKCPT' ) THEN
               'AKPT'
           WHEN TRIM(ues.CompanyCode) IN ( 'AKCSC' ) THEN
               'AKSC'
           WHEN TRIM(ues.CompanyCode) IN ( 'AKCUK', 'AKDR', 'AKUK', 'AKCDR', 'AKCEA' ) THEN
               'AKUK'
           WHEN TRIM(ues.CompanyCode) IN ( 'AKCEM' ) THEN
               'EAKC'
           WHEN TRIM(ues.CompanyCode) IN ( 'ISIS', 'ISIS2' ) THEN
               'IONS'
           WHEN TRIM(ues.CompanyCode) IN ( 'AKCCH' ) THEN
               'AKCH'
           ELSE
               TRIM(ues.CompanyCode)
       END AS CompanyCode,
       GETDATE() AS DateModified,
       'Updated from UltiPro' AS Notes,
       CASE
           WHEN ues.ScheduledWorkHours IN ( 80, 160, 86.670000 ) THEN
               1
           WHEN ues.ScheduledWorkHours IS NULL THEN
               NULL
           ELSE
               ROUND(ues.ScheduledWorkHours / 80, 2)
       END AS FTE,
       ues.Title AS JobTitle,
       ues.TerminationDate AS TerminationDate,
       ues.StatusAsOf AS LatestHireDate,
       ues.FirstName AS FirstNameFormal,
       CASE
           WHEN UPPER(ues.SalaryHourlyCode) = 'S' THEN
               'EX'
           ELSE
               'NE'
       END AS ExemptStatus,
       ues.EeoEstablishmentName AS WorkplaceName,
       ues.EmployeeNumber AS EmployeeId,
       ues.EmailAddress AS EmailUltiPro,
       ues.WorkPhone AS WorkPhone,
       ues.CellPhone AS CellPhone,
       ues.MailStop AS MailStop,
       CASE ues.LocalCurrency
           WHEN 'Pound Sterling' THEN
               'GBP'
           WHEN 'Euro' THEN
               'EUR'
           WHEN 'Swedish Krona' THEN
               'SEK'
           WHEN 'Swiss Franc' THEN
               'CHF'
           WHEN 'Danish Krone' THEN
               'DKK'
           WHEN 'US Dollar' THEN
               'USD'
           WHEN 'Canadian Dollar' THEN
               'CAD'
           ELSE
               NULL
       END AS CurrencyCode,
       ues.RecordProcessed
FROM dbo.UltiproEmployeeStaging AS ues
    LEFT JOIN dbo.DimDepartment AS dd
        ON ues.DepartmentNumber = dd.DepartmentNumber
    LEFT JOIN dbo.DimUser AS du
        ON CONVERT(INT, ues.SupervisorEmployeeNumber) = du.EmployeeNumber