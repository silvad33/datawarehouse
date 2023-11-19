/*
Purpose:
*/

CREATE VIEW [financial_mart].[FACTINVOICEDETAILS] AS
SELECT 
	--IL.PO_Number,
	--CONCAT(IL.PO_Number,'-',IL.PO_Line_Number) AS PO_Number_And_Line,
	GL_A.MainAccountNumber AS GLAccountNumber,
	GL_A.MainAccountDescription AS GLAccountDescription,
	GL_A.MainAccountNumberDescription AS GLAccountNumberDescription,
	ILA.DepartmentKey as GLDepartmentKey ,
	GL_D.DepartmentNumber AS GLDepartmentNumber,
	GL_D.DepartmentNumberDescription AS GLDepartmentNumberDescription,
	ILA.ProjectKey as GLProjectKey,
	GL_P.ProjectNumber AS GLProjectNumber,
	GL_P.ProjectDescription AS GLProjectDescription,
	GL_P.ProjectNumberDescription AS GLProjectNumberDescription,
	ILA.TaskKey as GLTaskKay,
	GL_T.TaskNumber AS GLTaskNumber,
	GL_T.TaskDescription AS GLTaskDescription,
	GL_T.TaskNumberDescription AS GLTaskNumberDescription,
    ILA.Amount as GLAmount,
    ILA.AllocationPercent,
    ILA.InvoiceLineID,
	CONCAT(GL_D.DepartmentNumber,'-', GL_A.MainAccountNumber,'-',GL_P.ProjectNumber,'-',GL_T.TaskNumber) AS GLCoding

FROM InvoiceLineAllocation AS ILA
	--INNER JOIN InvoiceLine AS IL ON ILA.InvoiceLineID = IL.InvoiceLineID
    --INNER JOIN InvoiceHeader AS IH ON IL.InvoiceID = IH.InvoiceID
	INNER JOIN DimAccount AS GL_A ON ILA.AccountKey = GL_A.AccountKey
	INNER JOIN DimDepartment AS GL_D ON ILA.DepartmentKey = GL_D.DepartmentKey
	INNER JOIN DimProject AS GL_P ON ILA.ProjectKey = GL_P.ProjectKey
	INNER JOIN DimTask AS GL_T ON ILA.TaskKey = GL_T.TaskKey

GO