CREATE VIEW [dbo].[vDimUserInfo] 
AS
-- *************** Summary Info ***************
-- Date Created : 8/10/2020
-- Date Modified: 8/10/2020
-- Contact      : John O'Neill
-- Description  : Used by restricted db login 'api_login_restricted' from a REST Web API
-- Changed      : 7/12/2021.  Replaced UserName and Email field values with UserPrincipalName value. Keep alias for backward compatibility.
-- *************** /Summary Info ***************

SELECT 
    dusr.UserKey
    ,ISNULL(dusr.UserPrincipalName,'') as UserName
    ,ISNULL(dusr.UserPrincipalName,'') as Email
    ,ISNULL(dusr.FirstName,'') as FirstName
    ,ISNULL(dusr.FirstNameFormal,dusr.FirstName) as FirstNameFormal
    ,ISNULL(dusr.LastName,'') as LastName
    ,ISNULL(dusr.FullName,'') as FullName
    ,ISNULL(dusr.UserType,'') as UserType
    ,ISNULL(dusr.JobTitle,'') as JobTitle
    ,ISNULL(dusr.ExemptStatus,'') as ExemptStatus
    ,ISNULL(dusr.StockLevelCode,'') as JobLevel
    ,ISNULL(CONVERT(Varchar,dusr.FTE),'') as FTE
    ,ISNULL(dusr.WorkplaceName,'') as WorkplaceName
    ,ISNULL(dusr.WorkplaceLocation,'') as WorkplaceLocation
    ,ISNULL(CONVERT(Varchar,dusr.OriginalHireDate,110),'') as OriginalHireDate
    ,ISNULL(CONVERT(Varchar,dusr.TerminationDate,110),'') as TerminationDate
    ,ISNULL(dusr.Active,0) as Active
    ,ISNULL(dusr.EmployeeNumber,'') as EmployeeNumber
    , ISNULL(d.DepartmentNumberDescription,'') as Department
    ,CASE WHEN boss.UserKey IS NULL THEN '' ELSE boss.FirstName + ' ' + boss.LastName END as ManagerName
    ,ISNULL(boss.UserPrincipalName,'') as ManagerEmail
    ,ISNULL(CONVERT(Varchar, boss.UserKey),'') as ManagerUserKey
    ,ISNULL(dusr.CompanyCode,'') as CompanyCode
    ,ISNULL(dusr.PubsUserId,0) as PubsUserId
FROM DimUser as dusr
LEFT JOIN dimUser as boss on dusr.ManagerKey = boss.UserKey
LEFT JOIN dimDepartment as d on dusr.DepartmentKey = d.DepartmentKey
