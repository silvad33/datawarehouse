CREATE view dbo.vwCoupaPurchaseOrders AS
SELECT 
    ph.[Entity] AS header_Entity
    , ph.[ID] AS header_ID
    , ph.[PO_Number] AS header_PO_Number
    , ph.[Version] AS header_Version
    , ph.[Requisition_ID] AS header_Requisition_ID
    , ph.[Prior_PO_Number] AS header_Prior_PO_Number
    , ph.[GMP_PO] AS header_GMP_PO
    , dd.[DepartmentNumber] AS header_DepartmentNumber
    , ph.[Capital_ID] AS header_Capital_ID
    , ph.[Capital_Item] AS header_Capital_Item
    , ph.[RequesterKey] AS header_RequesterKey
    , ph.[Order_Date] AS header_Order_Date
    , ds.[SupplierName] AS SupplierName
    , ph.[Status] AS header_Status
    , ph.[Budgeted] AS header_Budgeted
    , ph.[Exported] AS header_Exported
    , ph.[Last_Exported_At] AS header_Last_Exported_At
    , ph.[Created_By] AS header_Created_By
    , ph.[Created_At] AS header_Created_At
    , ph.[Updated_By] AS header_Updated_By
    , ph.[Updated_At] AS header_Updated_At
    , ph.[WH_Created] AS header_WH_Created
    , pl.[Created_By] AS line_Created_By
    , pl.[Created_At] AS line_Created_At
    , pl.[Updated_By] AS line_Updated_By
    , pl.[Updated_At] AS line_Updated_At
    , pl.[Accounting_Total] AS line_Accounting_Total
    , pl.[Accounting_Currency] AS line_Accounting_Currency
    , pl.[Description] AS line_Description
    , pl.[Invoiced_Quantity] AS line_Invoiced_Quantity
    , pl.[PO_Line_Number] AS line_PO_Line_Number
    , pl.[PO_ID] AS line_PO_ID
    , pl.[PO_Number] AS line_PO_Number
    , pl.[Price] AS line_Price
    , pl.[Received_Quantity] AS line_Received_Quantity
    , pl.[Source_Part_Number] AS line_Source_Part_Number
    , pl.[Status] AS line_Status
    , pl.[Total] AS line_Total
    , pl.[Reporting_Total] AS line_Reporting_Total
    , pl.[PoLineStartDate] AS line_PoLineStartDate
    , pl.[PoLineEndDate] AS line_PoLineEndDate
    , pla.[PO_Line_ID] AS lineAllocation_PO_Line_ID
    , dd2.[DepartmentNumber] AS DepartmentNumber
    , da.[MainAccountNumber] AS MainAccountNumber
    , dp.[ProjectNumber] AS ProjectNumber
    , dt.[TaskNumber] AS TaskNumber
    , pla.[AllocationPercent] AS lineAllocation_AllocationPercent
    , pla.[Amount] AS lineAllocation_Amount
    , pla.[PO_Number] AS lineAllocation_PO_Number
FROM poheader AS ph
    LEFT JOIN poline AS pl
    ON ph.id = pl.po_id
    LEFT JOIN polineallocation AS pla
    ON pl.id = pla.po_line_id
    INNER JOIN DimDepartment AS dd
    ON ph.departmentkey = dd.departmentkey
    INNER JOIN DimSupplier AS ds
    ON ph.SupplierKey = ds.SupplierKey
    INNER JOIN DimDepartment AS dd2
    ON pla.Departmentkey = dd2.DepartmentKey
    INNER JOIN DimAccount AS da
    ON pla.AccountKey = da.AccountKey
    INNER JOIN DimProject AS dp
    ON pla.ProjectKey = dp.ProjectKey
    INNER JOIN DimTask AS dt
    ON pla.TaskKey = dt.Taskkey
