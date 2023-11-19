/*
Purpose: Fact table, denormalized data, for Coupa PO. Summary table to minimize columns presented to user
*/
CREATE VIEW [financial_mart].[FACTPOLINESUMMARY] AS
SELECT POH.Entity,
	POH.PO_Number,
	POH.ID,
	CONCAT('https://isisph.coupahost.com/order_headers/',POH.ID) as POUrl,
	POH.[Version] AS PO_Version,
	POH.Requisition_ID,	
	case when POH.GMP_PO = 'true' then 'Yes' else 'No' end AS 'GMP PO',
	POH.DepartmentKey,
	D.DepartmentNumber AS PO_DepartmentNumber,
	D.DepartmentNumberDescription AS 'PO Department',
	POH.Capital_ID,
	POH.Capital_Item,
	U.UserName AS 'Requester User Name',
	U.FullName AS 'Requester Name',
	POH.Order_Date,
	S.SupplierName AS 'Supplier Name',
	S.SupplierID AS 'Supplier ID',
	POH.[Status] AS 'PO Status',
	POH.[Budgeted],
    POH.[Exported],
    POH.[Last_Exported_At],
	POL.PO_Line_Number,
	POL.[PoLineStartDate],
    POL.[PoLineEndDate],
	POL.Source_Part_Number AS Item,
	POL.[Description] AS ItemDescription,
	POL.Invoiced_Quantity AS PO_Line_InvoicedAmount,
	POL.Price,
	POL.Received_Quantity,
	POL.Accounting_Currency,
	--POA.POLineAmount,
	ISNULL(POL.[Accounting_Total], 0) AS POLineAccountingTotal,
	ISNULL(POL.[Reporting_Total], 0) as POLineReportingTotal,
	ISNULL(POL.Total,0) AS POLineAmount,
    POA.PO_Line_ID,
	CONCAT(POH.PO_Number,'-',POL.PO_Line_Number) AS PO_Number_And_Line,
	CONCAT(U.FullName,'-',D.DepartmentNumber) AS SecurityKey,
	ISNULL(INV.ApprovedInvoicedAmount,0) AS ApprovedInvoicedAmount,
	ISNULL(INV.PendingInvoiceAmount, 0) AS PendingInvoiceAmount,
	(ISNULL(INV.ApprovedInvoicedAmount,0) + ISNULL(INV.PendingInvoiceAmount,0)) AS TotalInvoiceAmount,
    (ISNULL(POL.Total,0) - ISNULL(INV.ApprovedInvoicedAmount,0) - ISNULL(INV.PendingInvoiceAmount,0)) AS 'Uninvoiced Amount'
FROM (Select PO_Line_ID, Sum(Amount) as POLineAmount from POLineAllocation group by PO_Line_ID ) as POA
	INNER JOIN POLine AS POL ON POA.PO_Line_ID = POL.ID
	INNER JOIN POHeader AS POH ON POL.PO_ID = POH.ID
	INNER JOIN DimUser AS U ON POH.RequesterKey = U.UserKey
	INNER JOIN DimDepartment AS D ON POH.DepartmentKey = D.DepartmentKey
	INNER JOIN DimSupplier AS S ON POH.SupplierKey = S.SupplierKey
	LEFT OUTER JOIN
		(SELECT PO_ID, PO_Line_Number, ISNULL([approved],0) AS ApprovedInvoicedAmount, ISNULL([pending],0) AS PendingInvoiceAmount
			FROM
		(
			SELECT IL.PO_ID, 
				IL.PO_Line_Number,
				ILA.Amount,
				CASE WHEN [Status] = 'approved' THEN 'approved' ELSE 'pending' END AS [Status]
			FROM InvoiceHeader AS IH
				INNER JOIN InvoiceLine AS IL ON IH.InvoiceID = IL.InvoiceID
				INNER JOIN InvoiceLineAllocation AS ILA ON IL.InvoiceLineID = ILA.InvoiceLineID
			WHERE [Status] IN ('approved','ap_hold','booking_hold','on_hold','pending_action','pending_approval','pending_receipt','processing','rejected')
		) AS InvoiceSource
		PIVOT
		(
			SUM(Amount)
			FOR [Status] IN ([approved], [pending])
		) AS InvoicePivot) AS INV ON POL.PO_ID = INV.PO_ID AND POL.PO_Line_Number = INV.PO_Line_Number
GO