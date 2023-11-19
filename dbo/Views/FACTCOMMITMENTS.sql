

CREATE VIEW [dbo].[FACTCOMMITMENTS] AS
SELECT POH.Entity,
	POH.PO_Number,
	POH.[Version],
	POH.Requisition_ID,
	POH.GMP_PO,
	POH.DepartmentKey,
	POH.Capital_ID,
	POH.Capital_Item,
	POH.RequesterKey,
	POH.Order_Date,
	POH.SupplierKey,
	POH.[Status],
	POL.PO_Line_Number,
	POL.Source_Part_Number,
	POL.Invoiced_Quantity,
	POL.Price,
	POL.Received_Quantity,
	POL.Total,
	POL.Reporting_Total,
	POA.PO_Line_ID, 
	POA.AccountKey AS GLAccountKey,
	POA.DepartmentKey AS GLDepartmentKey,
	POA.ProjectKey AS GLProjectKey,
	POA.TaskKey AS GLTaskKey,
	POA.AllocationPercent, 
	POA.Amount AS GLAmount
FROM POLineAllocation AS POA
	INNER JOIN POLine AS POL ON POA.PO_Line_ID = POL.ID
	INNER JOIN POHeader AS POH ON POL.PO_ID = POH.ID
