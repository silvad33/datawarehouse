/*
Purpose: Fact/denormalized Coupa invoice data. Summary data to minimizes columns presented to users
*/

CREATE VIEW [financial_mart].[FACTINVOICESUMMARY] AS
SELECT DISTINCT IH.Entity,
	IH.InvoiceID,
	IH.InvoiceNumber,
	IH.InvoiceDate,
	IH.[LastExportedAt],
	CONCAT('https://isisph.coupahost.com/invoices/',IH.InvoiceID,'/show_for_approval') AS InvoiceWebURL,
	S.SupplierName AS SupplierName,
	S.SupplierID AS SupplierID,
	IH.[Status] AS Invoice_Status,
	ISNULL(IH.PaymentDate, dateadd(dd, 365, getdate())) as PaymentDate, -- Update empty Paymentdate as 365 days in the future to avoid invoices cannot be filtered by this date
	(IH.MiscAmount/ILS.InvoiceLineCount) AS MiscAmount,
	(IH.HandlingAmount/ILS.InvoiceLineCount) AS HandlingAmount,
	(IH.ShippingAmount/ILS.InvoiceLineCount) AS ShippingAmount,
	(IH.TaxAmount/ILS.InvoiceLineCount) AS TaxAmount,
	(ILA.InvoiceLineAmount + (IH.MiscAmount/ILS.InvoiceLineCount) + (IH.HandlingAmount/ILS.InvoiceLineCount) + (IH.ShippingAmount/ILS.InvoiceLineCount) + (IH.TaxAmount/ILS.InvoiceLineCount)) AS InvoiceLineWithCharges,
	IL.[Description],
	IL.PO_ID,
	IL.PO_Number,
	IL.PO_Line_Number,
	CONCAT(IL.PO_Number,'-',IL.PO_Line_Number) AS PO_Number_And_Line,
	IL.Price,
	IL.InvoiceLineNumber,
    ILA.InvoiceLineID,
	--ILA.AccountKey,
	--GL_A.MainAccountNumber AS GLAccountNumber,
	--GL_A.MainAccountDescription AS GLAccountDescription,
	--GL_A.MainAcountNumberDescription AS GLAccountNumberDescription,
	--ILA.DepartmentKey,
	--GL_D.DepartmentNumber AS GLDepartmentNumber,
	--GL_D.DepartmentNumberDescription AS GLDepartmentNumberDescription,
	--ILA.ProjectKey,
	--GL_P.ProjectNumber AS GLProjectNumber,
	--GL_P.ProjectDescription AS GLProjectDescription,
	--GL_P.ProjectNumberDescription AS GLProjectNumberDescription,
	--ILA.TaskKey,
	--GL_T.TaskNumber AS GLTaskNumber,
	--GL_T.TaskDescription AS GLTaskDescription,
	--GL_T.TaskNumberDescription AS GLTaskNumberDescription,
	--CONCAT(GL_A.MainAccountNumber,'-',GL_D.DepartmentNumber,'-',GL_P.ProjectNumber,'-',GL_T.TaskNumber) AS GLCoding,
	--ILA.AllocationPercent,
	ILA.InvoiceLineAmount
--FROM InvoiceLineAllocation AS ILA
FROM (Select InvoiceLineID, sum(Amount) as InvoiceLineAmount from InvoiceLineAllocation group by InvoiceLineID) as ILA
	INNER JOIN InvoiceLine AS IL ON ILA.InvoiceLineID = IL.InvoiceLineID
	INNER JOIN InvoiceHeader AS IH ON IL.InvoiceID = IH.InvoiceID
	--INNER JOIN DimAccount AS GL_A ON ILA.AccountKey = GL_A.AccountKey
	--INNER JOIN DimDepartment AS GL_D ON ILA.DepartmentKey = GL_D.DepartmentKey
	--INNER JOIN DimProject AS GL_P ON ILA.ProjectKey = GL_P.ProjectKey
	--INNER JOIN DimTask AS GL_T ON ILA.TaskKey = GL_T.TaskKey
	INNER JOIN DimSupplier AS S ON IH.SupplierKey = S.SupplierKey
	INNER JOIN (SELECT InvoiceID, COUNT(InvoiceLineID) AS InvoiceLineCount FROM InvoiceLine group by InvoiceID) AS ILS ON IH.InvoiceID = ILS.InvoiceID
GO