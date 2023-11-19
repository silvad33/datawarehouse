
CREATE view vAD_A_ActualsSummaryA_2020
as
select [Account],
	[Level],
	[Split Label],
	[Project],
	[Task],
	[Supplier],
	CASE [Period] WHEN '1-2020' THEN SUM(PeriodAmount) ELSE 0 END AS '2020-01',
	CASE [Period] WHEN '2-2020' THEN SUM(PeriodAmount) ELSE 0 END AS '2020-02',
	CASE [Period] WHEN '3-2020' THEN SUM(PeriodAmount) ELSE 0 END AS '2020-03',
	CASE [Period] WHEN '4-2020' THEN SUM(PeriodAmount) ELSE 0 END AS '2020-04',
	CASE [Period] WHEN '5-2020' THEN SUM(PeriodAmount) ELSE 0 END AS '2020-05',
	CASE [Period] WHEN '6-2020' THEN SUM(PeriodAmount) ELSE 0 END AS '2020-06',
	CASE [Period] WHEN '7-2020' THEN SUM(PeriodAmount) ELSE 0 END AS '2020-07',
	CASE [Period] WHEN '8-2020' THEN SUM(PeriodAmount) ELSE 0 END AS '2020-08',
	CASE [Period] WHEN '9-2020' THEN SUM(PeriodAmount) ELSE 0 END AS '2020-09',
	CASE [Period] WHEN '10-2020' THEN SUM(PeriodAmount) ELSE 0 END AS '2020-10',
	CASE [Period] WHEN '11-2020' THEN SUM(PeriodAmount) ELSE 0 END AS '2020-11',
	CASE [Period] WHEN '12-2020' THEN SUM(PeriodAmount) ELSE 0 END AS '2020-12'
from vAD_A_ActualsSummarySubB
where [Period] LIKE '%-2020'
group by [Account],
	[Level],
	[Split Label],
	[Project],
	[Task],
	[Supplier],
	[Period]
