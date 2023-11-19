CREATE VIEW [dbo].[ActiveEmployeeListing] 
AS
-- *************** Summary Info ***************
-- Date Created : 8/27/2020
-- Date Modified: 7/28/2021
-- Contact      : John O'Neill
-- Description  : Used by Pubs function user listing. accessed from login 'api_login_restricted'
-- Notes        : Do not modify or delete without checking with Pubs developer team.
-- Changed      : 7/28/2021.  Replaced Email and ReportsTo.Email field values with UserPrincipalName value. Keep alias for backward compatibility.
-- *************** /Summary Info ***************

SELECT 
  ISNULL(dusr.EmployeeNumber,'') as EmployeeID
 ,ISNULL(dusr.LastName,'') as LastName
 ,ISNULL(dusr.FirstName,'') as FirstName
 ,ISNULL(dusr.FullName,'') as FullName
 ,RTRIM(ISNULL(dusr.LastName,'') + ', ' + ISNULL(dusr.FirstName, dusr.FirstNameFormal) )  as FullNameLastFirst
 ,ISNULL(dusr.WorkPhone,'') as WorkPhone
 ,ISNULL(dusr.UserPrincipalName,'') as Email
 ,ISNULL(dusr.JobTitle,'') as Title
 ,ISNULL(boss.EmployeeNumber,'') as 'ReportsTo.EmployeeID'
 ,ISNULL(boss.UserPrincipalName,'')  as 'ReportsTo.Email'
 ,CASE WHEN boss.UserKey IS NULL THEN '' ELSE boss.FirstName + ' ' + boss.LastName END  as 'ReportsTo.FullName'
 ,ISNULL(dusr.CompanyCode,'') as CompanyCode
 ,ISNULL(d.DepartmentNumber,'') as DepartmentCode
 ,ISNULL(d.DepartmentDescription,'') as Department
 ,ISNULL(dusr.WorkplaceLocation,'') as WorkLocation
 ,ISNULL(dusr.ExemptStatus,'') as ExemptStatus
 ,ISNULL(CONVERT(Varchar,dusr.FTE),'') as FTE
 ,CASE WHEN dusr.Active = 1 THEN 'A' ELSE 'T'END as StatusCode
 ,ISNULL(dusr.UserType,'') as WorkStatus
 ,ISNULL(dusr.StockLevelCode,'') as JobLevel
 
FROM DimUser as dusr
LEFT JOIN dimUser as boss on dusr.ManagerKey = boss.UserKey
LEFT JOIN dimDepartment as d on dusr.DepartmentKey = d.DepartmentKey
WHERE dusr.Active = 1