CREATE VIEW [financial].[vwBlacklineGlAccounts]
AS
SELECT -- TOP 10 
    GL.LEDGERNAME AS [Entity Unique Identifier]
    , dbo.IONIS_FIELD(GL.ACCOUNTDISPLAYVALUE, '-', 1) AS [Main Account Number]
    , dbo.IONIS_FIELD(GL.ACCOUNTDISPLAYVALUE, '-', 2) AS [Department]
    , dbo.IONIS_FIELD(GL.ACCOUNTDISPLAYVALUE, '-', 3) AS [Project]
    , dbo.IONIS_FIELD(GL.ACCOUNTDISPLAYVALUE, '-', 4) AS [Task Code]
    , '' AS [Key6]
    , '' AS [Key7]
    , '' AS [Key8]
    , '' AS [Key9]
    , '' AS [Key10]
    , A.[NAME] AS [AccountDescription]
    , A.[ACCOUNTCATEGORYDESCRIPTION] AS [Account Reference]
    , CASE 
        WHEN A.MAINACCOUNTID >= '1000'
            AND A.MAINACCOUNTID < '4000'
            THEN 'A'
        WHEN A.MAINACCOUNTID >= '4000'
            AND A.MAINACCOUNTID <= '9999'
            THEN 'I'
        ELSE ''
        END AS [Financial Statement]
    , CASE A.MAINACCOUNTTYPE
        WHEN 0
            THEN 'Profit and Loss'
        WHEN 1
            THEN 'Revenue'
        WHEN 2
            THEN 'Expense'
        WHEN 3
            THEN 'Balance Sheet'
        WHEN 4
            THEN 'Asset'
        WHEN 5
            THEN 'Liability'
        WHEN 6
            THEN 'Equity'
        WHEN 8
            THEN 'Totaling'
        END AS [Account Type]
    , CASE A.ISSUSPENDED
        WHEN 0
            THEN 'TRUE'
        ELSE 'FALSE'
        END AS [Active Account]
    , CASE ISNULL(PB.TransactionsInPeriod, 0)
        WHEN 0
            THEN 'FALSE'
        ELSE 'TRUE'
        END AS [Activity in Period]
    , '' AS [Alternate Currency]
    ,
    --income statements use coding to assign by account
    --LEFT(ACCOUNTINGCURRENCY,2)+'1' for income accounts (Financial Statement = 'I')
    CASE 
        WHEN A.MAINACCOUNTID >= '1000'
            AND A.MAINACCOUNTID < '4000'
            THEN E.ACCOUNTINGCURRENCY
        ELSE CONCAT (
                LEFT(E.ACCOUNTINGCURRENCY, 2)
                , '1'
                )
        END AS [Accounting Currency]
    , P.PeriodEndDate AS [Period End Date]
    , '' AS [GL Reporting Balance- US]
    , '' AS [GL Alternate Balance]
    ,
    --CASE 
    --	WHEN A.MAINACCOUNTID>='1000' AND A.MAINACCOUNTID<'4000' THEN ISNULL(PB.PeriodAmountBalanceSheet,0)
    --	ELSE ISNULL(PB.PeriodAmountExpense,0)
    --END 
    ISNULL(PB.PeriodAmountBalanceSheet, 0) AS [GL Reporting Balance- Functional]
FROM (
    SELECT DISTINCT LEDGERNAME
        , ACCOUNTDISPLAYVALUE
    FROM GeneralJournalAccountEntryStaging
    WHERE ACCOUNTINGDATE > '12/31/2018'
    ) AS GL
INNER JOIN MainAccountStaging AS A
    ON dbo.IONIS_FIELD(GL.ACCOUNTDISPLAYVALUE, '-', 1) = A.MAINACCOUNTID
CROSS JOIN (
    -- 	SELECT FISCALYEAR, ISNULL(TRY_CONVERT(INT,REPLACE(PERIODNAME,'Period ','')),0) AS [MONTH], FORMAT(ENDDATE,'M/d/yyyy') AS PeriodEndDate
    -- FROM FiscalPeriodStaging
    -- WHERE FISCALYEAR = DATEPART(year,GETDATE())
    --     AND (PERIODNAME = CONCAT('Period ',DATEPART(MONTH,GETDATE())) OR PERIODNAME = CONCAT('Period ',DATEPART(MONTH,GETDATE()) - 1) OR PERIODNAME = CONCAT('Period ',DATEPART(MONTH,GETDATE()) - 2))
    SELECT FISCALYEAR
        , ISNULL(TRY_CONVERT(INT, REPLACE(PERIODNAME, 'Period ', '')), 0) AS [MONTH]
        , FORMAT(ENDDATE, 'M/d/yyyy') AS PeriodEndDate
    FROM FiscalPeriodStaging
    WHERE enddate BETWEEN DATEADD(MONTH, - 2, GETDATE()) AND EOMONTH(GETDATE())
        AND ENDDATE <> STARTDATE --there is an entry for the first of the month in the period end field, we can't include that in the output.
    ) AS P
LEFT OUTER JOIN (
    --period balances (PB) for current and prior periods
    /*
    We have to pass the correct year in when it's the Jan and Feb and we need to get data for the last months of the previous year
    */
    SELECT LEDGERNAME
        , PeriodYear
        , PeriodMonth
        , Account
        , PeriodAmountBalanceSheet
        , PeriodAmountExpense
        , TransactionsInPeriod
    FROM financial.fnGLPeriodBalances(DATEPART(year, GETDATE()), DATEPART(MONTH, GETDATE()))
    
    UNION ALL
    
    SELECT LEDGERNAME
        , PeriodYear
        , PeriodMonth
        , Account
        , PeriodAmountBalanceSheet
        , PeriodAmountExpense
        , TransactionsInPeriod
    FROM financial.fnGLPeriodBalances((
                SELECT CASE DATEPART(MONTH, GETDATE())
                        WHEN 1
                            THEN DATEPART(year, GETDATE()) - 1
                        ELSE DATEPART(year, GETDATE())
                        END AS years
                ), DATEPART(month, DATEADD(month, - 1, GETDATE())))
    
    UNION ALL
    
    SELECT LEDGERNAME
        , PeriodYear
        , PeriodMonth
        , Account
        , PeriodAmountBalanceSheet
        , PeriodAmountExpense
        , TransactionsInPeriod
    FROM financial.fnGLPeriodBalances((
                SELECT CASE DATEPART(MONTH, GETDATE())
                        WHEN 1
                            THEN DATEPART(year, GETDATE()) - 1
                        WHEN 2
                            THEN DATEPART(year, GETDATE()) - 1
                        ELSE DATEPART(year, GETDATE())
                        END AS years
                ), DATEPART(month, DATEADD(month, - 2, GETDATE())))
    ) AS PB
    ON GL.LEDGERNAME = PB.LEDGERNAME
        AND GL.ACCOUNTDISPLAYVALUE = PB.Account
        AND PB.PeriodYear = P.FISCALYEAR
        AND PB.PeriodMonth = P.[MONTH]
INNER JOIN LedgerEntityStaging AS E
    ON GL.LEDGERNAME = E.LEGALENTITYID
-- no consolidated companies
WHERE GL.LEDGERNAME NOT LIKE 'C%' --Do not export consolidation companies
    AND A.MAINACCOUNTID <> 'HC'
    AND A.MAINACCOUNTID <> 'HCO' --Do not show headcount accounts (maybe future use account type to filter stat accounts?)
    -- order by Entity, Account
    -- s/b select *
    -- from LedgerEntityStaging
    -- where ACCOUNTSTRUCTURENAME1 = 'CONS' OR LEGALENTITYID LIKE 'C%'
GO