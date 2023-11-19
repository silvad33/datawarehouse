CREATE VIEW [financial_mart].[FACTADAPTIVESUMMARYEXPORT]
  AS

SELECT A.MainAccountNumber AS [Account], 
  ISNULL(D.DepartmentNumber,'NA') + ' - ' + E.EntityID AS [Level],
	'' AS [Split Label],
	P.ProjectNumber AS [Project],
	T.TaskNumber AS [Task],
	CASE WHEN ISNULL(S.SubLedgerPartyNumber,'') = '' THEN '' 
     ELSE CONCAT(S.SubLedgerPartyNumber,' - ',SUP.VENDORORGANIZATIONNAME,' - ',SUP.DATAAREAID) END AS [Supplier],
	CAST(FC.[Year] AS VARCHAR) + '-' + RIGHT('00' + CAST(FC.MonthNumer AS VARCHAR),2) AS [Period],
	SUM(F.AccountingCurrencyAmount) AS [PeriodAmount]
FROM [dbo].FactTransaction AS F
  INNER JOIN [dbo].DimAccount AS A ON F.AccountKey = A.AccountKey
  INNER JOIN [dbo].DimEntity AS E ON F.EntityKey = E.EntityKey
  INNER JOIN [dbo].DimProject AS P ON F.ProjectKey = P.ProjectKey AND E.EntityID = P.DataAreaID
  INNER JOIN [dbo].DimTask AS T ON F.TaskKey = T.TaskKey AND E.EntityID = T.DataAreaID
  INNER JOIN [dbo].DimFinancialCalendar AS FC ON F.[FiscalPeriodKey] = FC.[FiscalPeriodKey]
  LEFT OUTER JOIN (
    SELECT DISTINCT FactTransactionKey, SubLedgerPartyNumber
		FROM [dbo].FactAccountingSourceExplorer
		WHERE ISNULL(SubLedgerPartyNumber,'') <> ''
		) AS S ON F.RecID = S.FactTransactionKey
  LEFT OUTER JOIN VendVendorV2Staging AS SUP ON S.SubLedgerPartyNumber = SUP.VENDORACCOUNTNUMBER
  LEFT OUTER JOIN DimDepartment AS D ON F.DepartmentKey = D.DepartmentKey
WHERE F.Scenario = 'Actual'
  AND A.MainAccountType IN ('Cost','Profit and loss','Revenue')
  AND E.EntityID NOT LIKE 'C___'
  AND FC.[Year] >= DATEPART(YEAR,DATEADD(MONTH,-25,GETDATE())) --Filter out records more than 2 years old
GROUP BY A.MainAccountNumber, 
	ISNULL(D.DepartmentNumber,'NA') + ' - ' + E.EntityID,
	P.ProjectNumber,
	T.TASkNumber,
	S.SubLedgerPartyNumber,
	SUP.VENDORORGANIZATIONNAME,
	SUP.DATAAREAID,
	CAST(FC.[Year] AS VARCHAR) + '-' + RIGHT('00' + CAST(FC.MonthNumer AS VARCHAR),2)
HAVING SUM(F.AccountingCurrencyAmount) <> 0