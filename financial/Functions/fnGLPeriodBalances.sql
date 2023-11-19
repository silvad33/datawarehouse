CREATE FUNCTION [financial].[fnGLPeriodBalances]
(
    @Year CHAR(4),
    @Period VARCHAR(2)
)
RETURNS TABLE
AS
RETURN
(
    --TEST VALUES
    -- DECLARE @Year CHAR(4)
    -- DECLARE @Period VARCHAR(2)

    -- SET @Year = '2021'
    -- SET @Period = '2'


    --SELECT TYPE 'A' Accounts and summarize balance as sum of period amounts to period provided

    SELECT GL.LEDGERNAME,
           @Year AS PeriodYear,
           @Period AS PeriodMonth,
           GL.ACCOUNTDISPLAYVALUE AS Account,
           SUM(GL.ACCOUNTINGCURRENCYAMOUNT) AS PeriodAmountBalanceSheet,
           SUM(   CASE DATEPART(MONTH, GL.ACCOUNTINGDATE)
                      WHEN @Period THEN
                          GL.ACCOUNTINGCURRENCYAMOUNT
                      ELSE
                          0
                  END
              ) AS PeriodAmountExpense,
           SUM(   CASE
                      WHEN DATEPART(MONTH, GL.ACCOUNTINGDATE) = @Period
                           AND GL.ACCOUNTINGCURRENCYAMOUNT <> 0 THEN
                          1
                      ELSE
                          0
                  END
              ) AS TransactionsInPeriod
    FROM GeneralJournalAccountEntryStaging AS GL
        INNER JOIN MainAccountStaging AS A
            ON dbo.IONIS_FIELD(GL.ACCOUNTDISPLAYVALUE, '-', 1) = A.MAINACCOUNTID
    WHERE GL.ACCOUNTINGDATE >= CONCAT(   '1/1/',
                               (
                                   SELECT CASE
                                              WHEN
                                              (
                                                  SELECT COUNT(*)
                                                  FROM [dbo].[GeneralJournalAccountEntryStaging]
                                                  WHERE description LIKE 'Opening%'
                                                        AND voucher = CONCAT('YE', convert(char(4), convert(int,@Year) - 1 ))
                                              ) > 0 THEN
                                                  @Year
                                              ELSE
                                                  DATEPART(year, GETDATE()) - 1
                                          END AS outyear
                               )
                                     )
          AND GL.ACCOUNTINGDATE <= EOMONTH(CONVERT(DATE, (CONCAT(CONCAT(CONCAT(@Year, '-'), @Period), '-01'))))
    --   AND DATEPART(MONTH,GL.ACCOUNTINGDATE) <= @Period
    --   and GL.ACCOUNTINGDATE < eomonth(getdate()) 
    GROUP BY GL.LEDGERNAME,
             GL.ACCOUNTDISPLAYVALUE
);
GO
