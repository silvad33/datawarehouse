CREATE VIEW BLACKLINE
AS
SELECT -- TOP 10 
	GL.LEDGERNAME AS [Entity Unique Identifier]
	,dbo.IONIS_FIELD(GL.ACCOUNTDISPLAYVALUE,'-',1) AS [Main Account Number]
	,dbo.IONIS_FIELD(GL.ACCOUNTDISPLAYVALUE,'-',2) AS [Department]
	,dbo.IONIS_FIELD(GL.ACCOUNTDISPLAYVALUE,'-',3) AS [Project]
	,dbo.IONIS_FIELD(GL.ACCOUNTDISPLAYVALUE,'-',4) AS [Task Code]
	,'' AS [Key6]
	,'' AS [Key7]
	,'' AS [Key8]
	,'' AS [Key9]
	,'' AS [Key10]
	,A.[NAME] AS [AccountDescription]
	,A.[ACCOUNTCATEGORYDESCRIPTION] AS [Account Reference]
	,CASE 
		WHEN A.MAINACCOUNTID>='1000' AND A.MAINACCOUNTID<'4000' THEN 'A'
		WHEN A.MAINACCOUNTID>='4000' AND A.MAINACCOUNTID<='9999' THEN 'I'
		ELSE ''
	END AS [Financial Statement]
	,CASE A.MAINACCOUNTTYPE
		WHEN 0 THEN 'Profit and Loss'
		WHEN 1 THEN 'Revenue'
		WHEN 2 THEN 'Expense'
		WHEN 3 THEN 'Balance Sheet'
		WHEN 4 THEN 'Asset'
		WHEN 5 THEN 'Liability'
		WHEN 6 THEN 'Equity'
		WHEN 8 THEN 'Totaling'
	END AS [Account Type]
	,CASE A.ISSUSPENDED
		WHEN 0 THEN 'TRUE'
		ELSE 'FALSE'
	END AS [Active Account]
	,CASE ISNULL(PB.TransactionsInPeriod,0) WHEN 0 THEN 'FALSE' ELSE 'TRUE' END AS [Activity in Period]
	,'' AS [Alternate Currency]
	--income statements use coding to assign by account
	--LEFT(ACCOUNTINGCURRENCY,2)+'1' for income accounts (Financial Statement = 'I')
	,CASE 
		WHEN A.MAINACCOUNTID>='1000' AND A.MAINACCOUNTID<'4000' THEN E.ACCOUNTINGCURRENCY
		ELSE CONCAT(LEFT(E.ACCOUNTINGCURRENCY,2),'1')
		END AS [Accounting Currency]
	,P.PeriodEndDate AS [Period End Date]
	,'' AS [GL Reporting Balance- US]
	,'' AS [GL Alternate Balance]
	,CASE 
		WHEN A.MAINACCOUNTID>='1000' AND A.MAINACCOUNTID<'4000' THEN ISNULL(PB.PeriodAmountBalanceSheet,0)
		ELSE ISNULL(PB.PeriodAmountExpense,0)
		END AS [GL Reporting Balance- Functional]
FROM (SELECT DISTINCT LEDGERNAME, ACCOUNTDISPLAYVALUE
		FROM GeneralJournalAccountEntryStaging) AS GL
	INNER JOIN MainAccountStaging AS A ON dbo.IONIS_FIELD(GL.ACCOUNTDISPLAYVALUE,'-',1) = A.MAINACCOUNTID
	CROSS JOIN (
		SELECT FISCALYEAR, [MONTH], FORMAT(ENDDATE,'M/d/yyyy') AS PeriodEndDate
		FROM FiscalPeriodStaging
		WHERE FISCALYEAR = DATEPART(year,GETDATE())
		  AND (MONTH = DATEPART(MONTH,GETDATE()) OR MONTH = DATEPART(MONTH,GETDATE()) - 1) 
	) AS P
	LEFT OUTER JOIN ( --period balances (PB) for current and prior periods
		SELECT LEDGERNAME, PeriodYear, PeriodMonth, Account, PeriodAmountBalanceSheet, PeriodAmountExpense, TransactionsInPeriod
		FROM GLPeriodBalances(DATEPART(year,GETDATE()),DATEPART(MONTH,GETDATE())) 

		UNION ALL

		SELECT LEDGERNAME, PeriodYear, PeriodMonth, Account, PeriodAmountBalanceSheet, PeriodAmountExpense, TransactionsInPeriod
		FROM GLPeriodBalances(DATEPART(year,GETDATE()),DATEPART(MONTH,GETDATE())-1) 
	) AS PB ON PB.LEDGERNAME = GL.LEDGERNAME AND PB.Account = GL.ACCOUNTDISPLAYVALUE AND P.FISCALYEAR = PB.PeriodYear AND P.[MONTH] = PB.PeriodMonth
	INNER JOIN LedgerEntityStaging AS E ON GL.LEDGERNAME = E.LEGALENTITYID
-- no consolidated companies
WHERE GL.LEDGERNAME NOT LIKE 'C%' --Do not export consolidation companies
  AND A.MAINACCOUNTID <> 'HC' AND A.MAINACCOUNTID <> 'HCO' --Do not show headcount accounts (maybe future use account type to filter stat accounts?)
-- order by Entity, Account
-- s/b select *
-- from LedgerEntityStaging
-- where ACCOUNTSTRUCTURENAME1 = 'CONS' OR LEGALENTITYID LIKE 'C%'
