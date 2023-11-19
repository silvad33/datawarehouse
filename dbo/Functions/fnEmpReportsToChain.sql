-- *************** Summary Info ***************
-- Date Created : 8/10/2020
-- Contact      : John O'Neill
-- Description  : Used by restricted db login 'api_login_restricted' from a REST Web API. (Pubs functions)
-- Changed      : 7/12/2021.  Replaced Email field values with UserPrincipalName value. Keep alias for backward compatibility.
-- *************** /Summary Info ***************
CREATE FUNCTION [dbo].[fnEmpReportsToChain] (@email	VARCHAR(50))
	RETURNS @employees TABLE (LastName Varchar(30)
    				,FirstName Varchar(30)
    				,FullName Varchar(61)
    				
    				,Email Varchar(50)
    				
                    ,JobLevel VARCHAR(15)
    				,CompanyCode Varchar(50)

				)
AS
BEGIN
DECLARE @empUserKey INT
SET @empUserKey = (SELECT top 1 UserKey from DimUser WHERE UserPrincipalName = @email);--> OPTIONAL:  AND UserType = 'Employee'
;WITH Emps As 
( 
    SELECT e.UserKey, e.ManagerKey, 0 as Depth
    FROM DimUser e
   
    WHERE e.UserKey = @empUserKey
    UNION All 
    SELECT e2.UserKey, e2.ManagerKey, Depth + 1
    FROM DimUser e2
        JOIN Emps 
            On Emps.ManagerKey = e2.UserKey 
) 

INSERT INTO @employees SELECT  ae.LastName, ae.FirstName,ae.FullName,ae.UserPrincipalName,ISNULL( ae.StockLevelCode,''), ISNULL(ae.CompanyCode,'') from Emps as boss  --ae.UserKey,, ae.ManagerKey
INNER JOIN DimUser as ae on boss.ManagerKey = ae.UserKey
WHERE boss.ManagerKey IS NOT null

  RETURN 
END
