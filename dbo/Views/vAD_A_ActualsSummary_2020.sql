CREATE view vAD_A_ActualsSummary_2020
as
select [Account],
	[Level],
	[Split Label],
	[Project],
	[Task],
	ISNULL([Supplier],'') as [Supplier],
	SUM([2020-01]) as [2020-01],
	SUM([2020-02]) as [2020-02],
	SUM([2020-03]) as [2020-03],
	SUM([2020-04]) as [2020-04],
	SUM([2020-05]) as [2020-05],
	SUM([2020-06]) as [2020-06],
	SUM([2020-07]) as [2020-07],
	SUM([2020-08]) as [2020-08],
	SUM([2020-09]) as [2020-09],
	SUM([2020-10]) as [2020-10],
	SUM([2020-11]) as [2020-11],
	SUM([2020-12]) as [2020-12]
from vAD_A_ActualsSummaryA_2020
group by [Account],
	[Level],
	[Split Label],
	[Project],
	[Task],
	[Supplier]

