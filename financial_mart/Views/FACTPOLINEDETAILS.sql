/*
Purpose: Fact/denormalized Coupa PO data
*/

CREATE VIEW [financial_mart].[FACTPOLINEDETAILS] AS
SELECT 
	POA.AccountKey AS GLAccountKey,
	GL_A.MainAccountNumber AS GLAccountNumber,
	GL_A.MainAccountDescription AS GLAccountDescription,
	GL_A.MainAccountNumberDescription AS GLAccountNumberDescription,
	POA.DepartmentKey AS GLDepartmentKey,
	GL_D.DepartmentNumber AS GLDepartmentNumber,
	GL_D.DepartmentNumberDescription AS 'GL Department',
	GL_P.ProjectKey AS GLProjectKey,
	GL_P.ProjectNumber AS GLProjectNumber,
	GL_P.ProjectDescription AS GLProjectDescription,
	GL_P.ProjectNumberDescription AS GLProjectNumberDescription,
	GL_T.TaskKey AS GLTaskKey,
	GL_T.TaskNumber AS GLTaskNumber,
	GL_T.TaskDescription AS GLTaskDescription,
	GL_T.TaskNumberDescription AS GLTaskNumberDescription,
    POA.PO_Line_ID,
    POA.AllocationPercent,
    POA.Amount,
    CONCAT(GL_D.DepartmentNumber,'-',GL_A.MainAccountNumber,'-',GL_P.ProjectNumber,'-',GL_T.TaskNumber) AS GLCoding	--CONCAT(POH.PO_Number,'-',POL.PO_Line_Number) AS PO_Number_And_Line

FROM POLineAllocation AS POA
	--INNER JOIN POLine AS POL ON POA.PO_Line_ID = POL.ID
	--INNER JOIN POHeader AS POH ON POL.PO_ID = POH.ID

	INNER JOIN DimAccount AS GL_A ON POA.AccountKey = GL_A.AccountKey
	INNER JOIN DimDepartment AS GL_D ON POA.DepartmentKey = GL_D.DepartmentKey
	INNER JOIN DimProject AS GL_P ON ISNULL(POA.ProjectKey,28) = GL_P.ProjectKey
	INNER JOIN DimTask AS GL_T ON ISNULL(POA.TaskKey,102) = GL_T.TaskKey

GO