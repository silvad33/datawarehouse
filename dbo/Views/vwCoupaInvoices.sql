create view dbo.vwCoupaInvoices AS
SELECT 
    ih.[Entity] AS Header_Entity
    , ih.[InvoiceID] AS Header_InvoiceID
    , ih.[InvoiceNumber] AS Header_InvoiceNumber
    , ih.[InvoiceDate] AS Header_InvoiceDate
    , ds.[SupplierName] AS Header_SupplierName
    , ih.[Status] AS Header_Status
    , ih.[Exported] AS Header_Exported
    , ih.[LastExportedAt] AS Header_LastExportedAt
    , ih.[Created_By] AS Header_Created_By
    , ih.[Created_At] AS Header_Created_At
    , ih.[Updated_By] AS Header_Updated_By
    , ih.[Updated_At] AS Header_Updated_At
    , ih.[WH_Created] AS Header_WH_Created
    , ih.[PaymentDate] AS Header_PaymentDate
    , ih.[HandlingAmount] AS Header_HandlingAmount
    , ih.[MiscAmount] AS Header_MiscAmount
    , ih.[ShippingAmount] AS Header_ShippingAmount
    , ih.[TaxAmount] AS Header_TaxAmount
    , ih.[CurrencyCode] AS Header_CurrencyCode
    , il.[InvoiceLineID] AS Line_InvoiceLineID
    , il.[InvoiceID] AS Line_InvoiceID
    , il.[Description] AS Line_Description
    , il.[PO_ID] AS Line_PO_ID
    , il.[PO_Number] AS Line_PO_Number
    , il.[PO_Line_Number] AS Line_PO_Line_Number
    , il.[Price] AS Line_Price
    , il.[Total] AS Line_Total
    , ila.[InvoiceLineID] AS LineAllocation_InvoiceLineID
    , ila.[InvoiceID] AS LineAllocation_
    , dd.[DepartmentNumber] AS DepartmentNumber
    , da.[MainAccountNumber] AS MainAccountNumber
    , dp.[ProjectNumber] AS ProjectNumber
    , dt.[TaskNumber] AS TaskNumber
    , ila.[AllocationPercent] AS LineAllocation_AllocationPercent
    , ila.[Amount] AS LineAllocation_Amount
FROM InvoiceHeader AS ih
    LEFT JOIN InvoiceLine AS il
    ON ih.invoiceid = il.invoiceid
    LEFT JOIN InvoiceLineAllocation AS ila
    ON il.invoiceLineid = ila.invoiceLineid
    INNER JOIN DimSupplier AS ds
    ON ih.Supplierkey = ds.SupplierKey
    INNER JOIN DimDepartment AS dd
    ON ila.DepartmentKey = dd.DepartmentKey
    INNER JOIN DimAccount AS da
    ON ila.AccountKey = da.AccountKey
    INNER JOIN DimProject AS dp
    ON ila.Projectkey = dp.ProjectKey
    INNER JOIN DimTask AS dt
    ON ila.TaskKey = dt.TaskKey
