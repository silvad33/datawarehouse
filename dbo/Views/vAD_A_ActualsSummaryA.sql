
CREATE view vAD_A_ActualsSummaryA
as
select [Account],
	[Level],
	[Split Label],
	[Project],
	[Task],
	[Supplier],
	CASE [Period] WHEN '1-2021' THEN SUM(PeriodAmount) ELSE 0 END AS '2021-01',
	CASE [Period] WHEN '2-2021' THEN SUM(PeriodAmount) ELSE 0 END AS '2021-02',
	CASE [Period] WHEN '3-2021' THEN SUM(PeriodAmount) ELSE 0 END AS '2021-03',
	CASE [Period] WHEN '4-2021' THEN SUM(PeriodAmount) ELSE 0 END AS '2021-04',
	CASE [Period] WHEN '5-2021' THEN SUM(PeriodAmount) ELSE 0 END AS '2021-05',
	CASE [Period] WHEN '6-2021' THEN SUM(PeriodAmount) ELSE 0 END AS '2021-06',
	CASE [Period] WHEN '7-2021' THEN SUM(PeriodAmount) ELSE 0 END AS '2021-07',
	CASE [Period] WHEN '8-2021' THEN SUM(PeriodAmount) ELSE 0 END AS '2021-08',
	CASE [Period] WHEN '9-2021' THEN SUM(PeriodAmount) ELSE 0 END AS '2021-09',
	CASE [Period] WHEN '10-2021' THEN SUM(PeriodAmount) ELSE 0 END AS '2021-10',
	CASE [Period] WHEN '11-2021' THEN SUM(PeriodAmount) ELSE 0 END AS '2021-11',
	CASE [Period] WHEN '12-2021' THEN SUM(PeriodAmount) ELSE 0 END AS '2021-12'
from vAD_A_ActualsSummarySubB
where [Period] LIKE '%-2021'
group by [Account],
	[Level],
	[Split Label],
	[Project],
	[Task],
	[Supplier],
	[Period]
