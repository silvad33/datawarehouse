-- *************** Summary Info ***************
-- Date Created : 8/10/2020
-- Contact      : John O'Neill
-- Description  : Used by restricted db login 'api_login_restricted' from a REST Web API
-- Changed      : 7/12/2021.  Replaced UserName and Email field values with UserPrincipalName value. Keep alias for backward compatibility.
-- *************** /Summary Info ***************
CREATE FUNCTION [dbo].[fnEmpLookupForPubs] (@email	VARCHAR(50))
	RETURNS @employees TABLE (EmployeeID Varchar(15)
				,LastName Varchar(30)
    				,FirstName Varchar(30)
    				,FullName Varchar(61)
                    ,Email Varchar(100)
    				,Title Varchar(80)
    				,[ReportsTo.EmployeeID] Varchar(15)
    				,[ReportsTo.Email] Varchar(30)
    				,[ReportsTo.FullName] Varchar(61)
    				,CompanyCode Varchar(15)
    				,Department Varchar(80)
    				,WorkLocation Varchar(15)
    				,ExemptStatus Varchar(15)
    				,FTE numeric(19,4)
    				,StatusCode Varchar(15)
    				,JobLevel Varchar(15)
				)
AS
BEGIN
DECLARE @empID VARCHAR(50);
SET @empID = (SELECT top 1 EmployeeID FROM DimUser WHERE UserPrincipalName = @email);--ActiveEmployees



INSERT INTO @employees SELECT ae.EmployeeNumber
	,LastName
	,FirstName
	,FullName
    ,Email
	,JobTitle
	,[ManagerUserKey]
    	,[ManagerEmail]
    	,ManagerName
    	,CompanyCode
    	,Department
    	,WorkplaceLocation
    	,ExemptStatus 
    	,FTE
    	,Active
    	
    	,JobLevel
 from  vDimUserInfo as ae where ae.Email = @email
  

  RETURN 
END
