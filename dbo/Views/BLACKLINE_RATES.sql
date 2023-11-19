﻿CREATE VIEW [dbo].[BLACKLINE_RATES]
AS
SELECT CASE RATES.RATETYPENAME WHEN 'Average' THEN CONCAT(LEFT(RATES.FROMCURRENCY,2),'1') ELSE RATES.FROMCURRENCY END AS [ISO Currency Code]
	, RATES.RATE AS [Conversion Rate]
	, FORMAT(EOMONTH(RATES.STARTDATE),'M/d/yyyy') AS [Period End Date]
	, 'M' AS [Conversion Method]
FROM (
SELECT RATETYPENAME
		, FROMCURRENCY
		, TOCURRENCY
		, RATE
		, STARTDATE
		, ENDDATE
	FROM (
	SELECT RATETYPENAME
		, FROMCURRENCY
		, TOCURRENCY
		, RATE
		, STARTDATE
		, ENDDATE
		, DATEPART(YEAR,ENDDATE) AS PeriodYear
		, DATEPART(MONTH,ENDDATE) AS PeriodMonth
		, ROW_NUMBER() OVER(PARTITION BY RATETYPENAME,FROMCURRENCY ORDER BY STARTDATE DESC) AS STARTDATE_ROWNUM		
		, ROW_NUMBER() OVER(PARTITION BY RATETYPENAME,FROMCURRENCY ORDER BY ENDDATE DESC) AS ENDDATE_ROWNUM
		FROM ExchangeRateEntityStaging
		WHERE TOCURRENCY = 'USD'
			AND RATETYPENAME IN ('Default','Average')) AS ONE
	WHERE STARTDATE_ROWNUM = 1
		AND ENDDATE_ROWNUM = 1) AS RATES
UNION ALL
SELECT CASE RATES.RATETYPENAME WHEN 'Average' THEN CONCAT(LEFT(RATES.TOCURRENCY,2),'1') ELSE RATES.TOCURRENCY END AS [ISO Currency Code]
	, RATES.RATE AS [Conversion Rate]
	, FORMAT(P.ENDDATE,'M/d/yyyy') AS [Period End Date]
	,'D' AS [Conversion Method]
FROM (
	SELECT STARTDATE, ENDDATE, [MONTH] + 1 AS FISCALMONTH, FISCALYEAR
	FROM FiscalPeriodStaging
	WHERE TYPE=1
	) AS P
	INNER JOIN (
	SELECT RATETYPENAME
		, FROMCURRENCY
		, TOCURRENCY
		, RATE
		, STARTDATE
		, ENDDATE
		, DATEPART(YEAR,ENDDATE) AS PeriodYear
		, DATEPART(MONTH,ENDDATE) AS PeriodMonth
		, ROW_NUMBER() OVER(PARTITION BY RATETYPENAME,TOCURRENCY ORDER BY ENDDATE DESC) AS ROWNUM
	FROM ExchangeRateEntityStaging
	WHERE FROMCURRENCY = 'USD'
	) AS RATES ON P.ENDDATE >= RATES.STARTDATE AND P.ENDDATE <= RATES.ENDDATE AND ROWNUM = 1
WHERE RATES.ROWNUM = 1
  AND RATES.RATETYPENAME IN ('Default','Average')
  AND DATEPART(YEAR,P.ENDDATE) = DATEPART(YEAR,GETDATE())
  AND (DATEPART(MONTH,P.ENDDATE) = DATEPART(MONTH,GETDATE()) OR DATEPART(MONTH,P.ENDDATE) = DATEPART(MONTH,GETDATE())-1)