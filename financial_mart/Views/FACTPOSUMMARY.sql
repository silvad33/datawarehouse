CREATE VIEW [financial_mart].[FACTPOSUMMARY] AS

    -- ***************DB Info ***************
    -- Description  : Summary POLine amount by PO for P2P team
    -- Notes        : This will be used by P2P reports
    -- Contact      : Harry Chen
    -- Date Created : 07/30/2021
    -- Change hist.	: 07/30/2021 added localcurrency
    -- *************** /DB Info ***************


SELECT Entity
      ,[PO_Number]
      ,[ID]
      ,[DepartmentKey]
      ,[PO_DepartmentNumber]
      ,[PO Department]
      ,[Requester User Name]
      ,[Requester Name]
      ,[Order_Date]
      ,[Supplier Name]
      ,[Supplier ID]
      ,[PO Status]
      ,Sum([Received_Quantity]) as TotalReceivedQuantity
      ,Sum([POLineAmount]) as POAmount
      ,Sum([ApprovedInvoicedAmount]) as ApprovedInvoicedAmount
      ,Sum([PendingInvoiceAmount]) as PendingInvoiceAmount
      ,Sum([TotalInvoiceAmount]) as TotalInvoiceAmount
      ,Sum([Uninvoiced Amount]) as UninvoicedAmount
  FROM [financial_mart].[FACTPOLINESUMMARY]
  group by Entity
      ,[PO_Number]
      ,[ID]
      ,[DepartmentKey]
      ,[PO_DepartmentNumber]
      ,[PO Department]
      ,[Requester User Name]
      ,[Requester Name]
      ,[Order_Date]
      ,[Supplier Name]
      ,[Supplier ID]
      ,[PO Status]
GO