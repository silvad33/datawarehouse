CREATE VIEW [financial_mart].[FACTADAPTIVETRANSACTIONEXPORT]
  AS 
SELECT ISNULL(D.DepartmentNumber,'NA') + ' - ' + E.EntityID AS [Level],
	TRIM(A.MainAccountNumber) AS [Account], 
	FORMAT(F.TransactionDate,'yyyy-MM-dd') AS [Posting Date],
	F.AccountingCurrencyAmount AS [Transaction Amount],
	'D365' AS [GL System],
	S.VOUCHER AS [Transaction ID],
	CASE WHEN ISNULL(S.SubLedgerPartyNumber,'') = '' THEN '' 
    ELSE CONCAT(ISNULL(S.SubLedgerPartyNumber,''),' - ',SUP.VENDORORGANIZATIONNAME, ' - ', SUP.DATAAREAID) END AS [Supplier],
	P.ProjectNumber AS [Project],
	T.TaskNumber AS [Task],
	PT.PostingTypeDescription AS [Transaction Type],
	F.TransactionDescription AS [Description1],
	S.SubLedgerDocumentDescription AS [Description2]
FROM [dbo].FactTransaction AS F
  INNER JOIN [dbo].DimAccount AS A ON F.AccountKey = A.AccountKey
  INNER JOIN [dbo].DimEntity AS E ON F.EntityKey = E.EntityKey
  INNER JOIN [dbo].DimProject AS P ON F.ProjectKey = P.ProjectKey AND E.EntityID = P.DataAreaID
  INNER JOIN [dbo].DimTask AS T ON F.TaskKey = T.TaskKey
  INNER JOIN [dbo].DimFinancialCalendar AS FC ON F.[FiscalPeriodKey] = FC.[FiscalPeriodKey]
  LEFT OUTER JOIN (SELECT DISTINCT DestinationCompany, FactTransactionKey, SubLedgerPartyNumber, PostingType, SubLedgerDocumentDescription, VOUCHER
		FROM [dbo].FactAccountingSourceExplorer
		WHERE ISNULL(SubLedgerPartyNumber,'') <> ''
		) AS S ON F.RecID = S.FactTransactionKey AND E.EntityID = S.DestinationCompany
  LEFT OUTER JOIN VendVendorV2Staging AS SUP ON S.SubLedgerPartyNumber = SUP.VENDORACCOUNTNUMBER
  LEFT OUTER JOIN PostingTypeCrossReference AS PT ON S.PostingType = PT.PostingType
  LEFT OUTER JOIN DimDepartment AS D ON F.DepartmentKey = D.DepartmentKey
WHERE FC.Year > DATEPART(YEAR,DATEADD(MONTH,-26,GETDATE())) --limit to previous 2 years
  AND E.EntityID NOT LIKE 'C___'
  AND F.Scenario = 'Actual'
  AND A.MainAccountType in ('Cost','Profit and loss','Revenue')
  AND F.AccountingCurrencyAmount <> 0