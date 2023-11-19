CREATE VIEW financial_mart.FACTPOLINEINVOICESACCRUAL AS
SELECT ph.[Entity] as POEntity
    , ph.[ID] AS [PO_ID]
    , ph.[PO_Number]
    , CONCAT('https://isisph.coupahost.com/order_headers/',ph.ID) as POUrl
    , ph.Internal_Revision
    , CONCAT (
        ph.[PO_Number]
        , '-'
        , pl.[PO_Line_Number]
        ) AS PO_Number_And_Line
    , ph.[Version] as PO_Version
    , ph.[Requisition_ID]
    , ph.[Prior_PO_Number]
    , ph.[GMP_PO] 
    , ph.[Capital_ID]
    , ph.[Capital_Item]
    , ph.[RequesterKey]
    , ph.[Order_Date]
    --  , ds.[SupplierName]
    , ph.[Status] as POStatus-- Same as pl.[Status] 
    , ph.[Budgeted]
    , ph.[Exported]
    , ph.[Last_Exported_At]
    --, ph.[Created_By] -- Need to change names
    --, ph.[Created_At] -- Need to change names
    --, ph.[Updated_By] -- Need to change names
    --, ph.[Updated_At] -- Need to change names
    --, ph.[WH_Created]
    --, pl.[Created_By] --Same as ph.[Created_By] if not need to change name
    --, pl.[Created_At] --Same as ph.[Created_By] if not need to change name
    --, pl.[Updated_By] --Same as ph.[Created_By] if not need to change name
    --, pl.[Updated_At] --Same as ph.[Created_By] if not need to change name
    , s.SupplierName
	, s.SupplierID
    , pl.[Accounting_Total]
    , pl.[Accounting_Currency]
    , pl.[Description] as POLineDescription
    , pl.[Invoiced_Quantity]
    , pl.[PO_Line_Number]
    -- , pl.[PO_ID] -- Same as ID
    --, pl.[PO_Number] -- Remove
    , pl.[Price] as POLinePrice
    , pl.[Received_Quantity]
    , pl.[Source_Part_Number] AS PartNumber
    --, pl.[Status]    --Same as ph.[Status]
    , pl.[Total] AS POLineTotal -- Need to change name
    , pl.[Reporting_Total]
    , pl.[PoLineStartDate]
    , pl.[PoLineEndDate]
    , pla.[PO_Line_ID]
    , dd2.DepartmentNumberDescription AS PODepartment
    , dd2.[DepartmentNumber] AS PODepartmentNumber
    , da.[MainAccountNumber] AS POMainAccountNumber
    , dp.[ProjectNumber] AS POProjectNumber
    , dt.[TaskNumber] AS TaskNumber
    , CONCAT (
        dd2.[DepartmentNumber]
        , '-'
        , da.[MainAccountNumber]
        , '-'
        , dp.[ProjectNumber]
        , '-'
        , dt.[TaskNumber]
        ) AS POGLAccountCode
    , pla.[AllocationPercent] AS POAllocationPercent
    , pla.[Amount] AS POLineAllocationAmount
    -- , pla.[PO_Number] -- Remove
    , ih.[Entity]
    , ih.[InvoiceID]
    , ih.[InvoiceNumber]
    , CONCAT('https://isisph.coupahost.com/invoices/',ih.InvoiceID,'/show_for_approval') AS InvoiceWebURL
    , ih.[InvoiceDate]
    , ih.[LastExportedAt] --added
    -- , ds3.[SupplierName]
    , ih.[Status] as InvoiceStatus
    --  , ih.[Created_By] --Need different name if join with PO Lines
    , ih.[Created_At] AS InvoiceCreatedDate
    --, ih.[Updated_By] --Need different name if join with PO Lines
    --, ih.[Updated_At] --Need different name if join with PO Lines
    --, ih.[WH_Created] --Need different name if join with PO Lines
    , ih.[PaymentDate]
    , ih.[HandlingAmount]
    , ih.[MiscAmount]
    , ih.[ShippingAmount]
    , ih.[TaxAmount]
    , ih.[CurrencyCode]
    , il.[InvoiceLineID]
    -- , il.[InvoiceID] -- Remove
    , il.[Description]
    --, il.[PO_ID]
    --, il.[PO_Number]
    --, il.[PO_Line_Number]
    , il.[Price]
    , il.[Total] AS InvoiceLineTotal
    --, ila.[InvoiceLineID] -- Remove
    -- , ila.[InvoiceID] -- Remove
    , dd3.[DepartmentNumber] AS InvoiceDepartmentNumber
    , da1.[MainAccountNumber] AS InvoiceMainAccountNumber
    , dp1.[ProjectNumber] AS InvoiceProjectNumber
    , dp1.DataAreaID AS ChartOfAccounts
    , dt1.[TaskNumber] AS InvoiceTaskNumber
    , CONCAT (
        dd3.[DepartmentNumber]
        , '-'
        , da1.[MainAccountNumber]
        , '-'
        , dp1.[ProjectNumber]
        , '-'
        , dt1.[TaskNumber]
        ) AS InvoiceGLAccountCode
    , ila.[AllocationPercent] AS InvoiceAllocationPercent
    , ila.[Amount] AS InvoiceLineAllocationAmount
    , CONCAT(u.FullName,'-',dd2.DepartmentNumber) AS SecurityKey
    , u.FullName AS RequesterName
FROM poheader AS ph
INNER JOIN poline AS pl
    ON ph.id = pl.po_id
INNER JOIN polineallocation AS pla
    ON pl.id = pla.po_line_id
INNER JOIN DimUser AS u ON ph.RequesterKey = u.UserKey
INNER JOIN DimSupplier AS s ON ph.SupplierKey = s.SupplierKey
LEFT JOIN InvoiceLine AS iL
    ON ph.[PO_Number] = il.[PO_Number]
        AND pl.[PO_Line_Number] = il.[PO_Line_Number]
INNER JOIN InvoiceHeader AS ih
    ON ih.invoiceid = il.invoiceid
INNER JOIN InvoiceLineAllocation AS ila
    ON il.invoiceLineid = ila.invoiceLineid
INNER JOIN DimDepartment AS dd2
    ON pla.Departmentkey = dd2.DepartmentKey
INNER JOIN DimAccount AS da
    ON pla.AccountKey = da.AccountKey
INNER JOIN DimProject AS dp
    ON pla.ProjectKey = dp.ProjectKey
INNER JOIN DimTask AS dt
    ON pla.TaskKey = dt.Taskkey
INNER JOIN DimDepartment AS dd3
    ON ila.DepartmentKey = dd3.DepartmentKey
INNER JOIN DimAccount AS da1
    ON ila.AccountKey = da1.AccountKey
INNER JOIN DimProject AS dp1
    ON ila.Projectkey = dp1.ProjectKey
INNER JOIN DimTask AS dt1
    ON ila.TaskKey = dt1.TaskKey
