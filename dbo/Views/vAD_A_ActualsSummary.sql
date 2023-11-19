CREATE view vAD_A_ActualsSummary
as
select [Account],
	[Level],
	[Split Label],
	[Project],
	[Task],
	ISNULL([Supplier],'') as [Supplier],
	SUM([2021-01]) as [2021-01],
	SUM([2021-02]) as [2021-02],
	SUM([2021-03]) as [2021-03],
	SUM([2021-04]) as [2021-04],
	SUM([2021-05]) as [2021-05],
	SUM([2021-06]) as [2021-06],
	SUM([2021-07]) as [2021-07],
	SUM([2021-08]) as [2021-08],
	SUM([2021-09]) as [2021-09],
	SUM([2021-10]) as [2021-10],
	SUM([2021-11]) as [2021-11],
	SUM([2021-12]) as [2021-12]
from vAD_A_ActualsSummaryA
group by [Account],
	[Level],
	[Split Label],
	[Project],
	[Task],
	[Supplier]

