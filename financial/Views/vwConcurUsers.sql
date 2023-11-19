CREATE VIEW [financial].[vwConcurUsers]
AS
SELECT du.CompanyCode AS CompanyCode
    , dd.DepartmentNumber AS DepartmentCode
    , LOWER(du.UserPrincipalName) COLLATE SQL_Latin1_General_CP1253_CI_AI AS Email
    , du.EmployeeNumber AS EmployeeID
    , du.FirstNameFormal AS FirstName
    , du.LastName COLLATE SQL_Latin1_General_CP1253_CI_AI AS LastName
    , du2.EmployeeNumber AS ReportsToEmployeeID
    , du.StockLevelCode AS StockLevelCode
    , du.JobTitle AS JobTitle
    , CASE WHEN du.Active = 1 THEN 'Y' ELSE 'N' END AS Active
    , coalesce(du.DateModified, du.dateinserted) as datemodified
FROM dbo.DimUser AS du
LEFT JOIN dbo.DimDepartment AS dd
    ON du.DepartmentKey = dd.DepartmentKey
LEFT JOIN dbo.DimUser AS du2
    ON du.Managerkey = du2.userkey
WHERE du.employeeid IS NOT NULL
    AND du.CompanyCode <> 'TEMP'
    AND du.UserType = 'Employee'
    AND du.EmailUltiPro IS NOT NULL
    AND du.companycode IS NOT NULL
    AND LOWER(SUBSTRING(du.UserPrincipalName, CHARINDEX('@', du.UserPrincipalName, 1) + 1, 30)) IN ('akceatx.com', 'ionisph.com')

UNION ALL
--added a union to explicitly add temps who need a concur account, as they are not automatically given one. 
SELECT du.CompanyCode AS CompanyCode
    , dd.DepartmentNumber AS DepartmentCode
    , LOWER(du.UserPrincipalName) COLLATE SQL_Latin1_General_CP1253_CI_AI AS Email
    , du.EmployeeNumber AS EmployeeID
    , du.FirstNameFormal AS FirstName
    , du.LastName COLLATE SQL_Latin1_General_CP1253_CI_AI AS LastName
    , du2.EmployeeNumber AS ReportsToEmployeeID
    , du.StockLevelCode AS StockLevelCode
    , du.JobTitle AS JobTitle
    , CASE WHEN du.Active = 1 THEN 'Y' ELSE 'N' END AS Active
    , coalesce(du.DateModified, du.dateinserted) as datemodified
FROM dbo.DimUser AS du
LEFT JOIN dbo.DimDepartment AS dd
    ON du.DepartmentKey = dd.DepartmentKey
LEFT JOIN dbo.DimUser AS du2
    ON du.Managerkey = du2.userkey
WHERE du.EmployeeNumber IN (4248, 4265) 
