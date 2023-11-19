/*
Purpose:
Change Log:
2020-10-28 RLC - Include filters that were added in PowerBI dataset. Add here rather than pulling to PowerBI then filtering:
      Table.SelectRows(financial_mart_FactTransaction, each not Text.Contains([TransactionDescription], "closing transaction")),
      #"Renamed Columns" = Table.RenameColumns(#"Filtered Rows",{{"ReportingCurrencyAmount", "ReportingActualAmount"}}),
      #"Filtered Rows2" = Table.SelectRows(#"Renamed Columns", each [TransactionDate] > #datetime(2018, 12, 31, 0, 0, 0)),
      #"Filtered Rows1" = Table.SelectRows(#"Filtered Rows2", each not Text.StartsWith([TransactionDescription], "Consolidation"))
*/
Create VIEW [financial_mart].[FactTransaction] AS

SELECT  CONCAT(et.[EntityID], '-', ft.[AccountString]) as EntityAccountString
      , CONCAT(ISNULL(dp.[DepartmentNumber],'NA'), ' - ', et.[EntityID]) as Level
      ,ft.[AccountString]
      ,ft.[TransactionDate]
      ,ft.[Scenario]
      ,ft.[TransactionDescription]
      ,ft.[BudgetAmount]
      ,ft.[IsAllocated]
      ,ft.[RecID]
      ,ft.[Partition]
      ,ft.[AccountKey]
      ,ft.[DepartmentKey]
      ,ft.[ProjectKey]
      ,ft.[TaskKey]
      ,ft.[FiscalPeriodKey]
      ,ft.[EntityKey]
      ,ft.[TransactionAmount]
      ,ft.[ReportingCurrencyAmount]
      ,ft.[AccountingCurrencyAmount] AS [ReportingActualAmount] --Based on PowerBI column rename
      ,ft.[ReportingCurrencyCode]
      ,ft.[AccountingCurrencyCode]
      ,ft.[TransactionCurrencyCode]
      ,ft.[InvoiceNumber]
      ,ft.[SecurityKey]
      ,ft.[Voucher]
      ,ft.[SubScenario]
      ,ft.[FCastQ1Amount]
      ,ft.[FCastQ2Amount]
      ,ft.[FCastQ3Amount]
      ,ft.[FCastQ4Amount]
      ,ft.[PostingTypeDescription]
FROM [dbo].[FactTransaction] as ft
      LEFT JOIN [dbo].[DimEntity] as et ON ft.EntityKey = et.EntityKey 
      LEFT JOIN [dbo].[DimDepartment] as dp ON ft.DepartmentKey = dp.DepartmentKey
WHERE ft.[TransactionDescription] NOT LIKE '%closing transaction%' --Based on PowerBI row filter "each not Text.Contains([TransactionDescription], "closing transaction")"
  AND ft.[TransactionDate] > '12/31/2018' --Base on PowerBI row filter "each [TransactionDate] > #datetime(2018, 12, 31, 0, 0, 0)"
  AND ft.[TransactionDescription] NOT LIKE 'Consolidation%' --Based on PowerBI row filter " each not Text.StartsWith([TransactionDescription], "Consolidation")"

GO