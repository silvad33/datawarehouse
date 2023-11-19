

CREATE view [dbo].[vAD_A_ActualsSummaryA_2019]
as
select [Account],
	[Level],
	[Split Label],
	[Project],
	[Task],
	[Supplier],
	CASE [Period] WHEN '1-2019' THEN SUM(PeriodAmount) ELSE 0 END AS '2019-01',
	CASE [Period] WHEN '2-2019' THEN SUM(PeriodAmount) ELSE 0 END AS '2019-02',
	CASE [Period] WHEN '3-2019' THEN SUM(PeriodAmount) ELSE 0 END AS '2019-03',
	CASE [Period] WHEN '4-2019' THEN SUM(PeriodAmount) ELSE 0 END AS '2019-04',
	CASE [Period] WHEN '5-2019' THEN SUM(PeriodAmount) ELSE 0 END AS '2019-05',
	CASE [Period] WHEN '6-2019' THEN SUM(PeriodAmount) ELSE 0 END AS '2019-06',
	CASE [Period] WHEN '7-2019' THEN SUM(PeriodAmount) ELSE 0 END AS '2019-07',
	CASE [Period] WHEN '8-2019' THEN SUM(PeriodAmount) ELSE 0 END AS '2019-08',
	CASE [Period] WHEN '9-2019' THEN SUM(PeriodAmount) ELSE 0 END AS '2019-09',
	CASE [Period] WHEN '10-2019' THEN SUM(PeriodAmount) ELSE 0 END AS '2019-10',
	CASE [Period] WHEN '11-2019' THEN SUM(PeriodAmount) ELSE 0 END AS '2019-11',
	CASE [Period] WHEN '12-2019' THEN SUM(PeriodAmount) ELSE 0 END AS '2019-12'
from vAD_A_ActualsSummarySubB
where [Period] LIKE '%-2019'
group by [Account],
	[Level],
	[Split Label],
	[Project],
	[Task],
	[Supplier],
	[Period]
