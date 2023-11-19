
CREATE view [dbo].[vAD_A_ActualsSummary_2019]
as
select [Account],
	[Level],
	[Split Label],
	[Project],
	[Task],
	ISNULL([Supplier],'') as [Supplier],
	SUM([2019-01]) as [2019-01],
	SUM([2019-02]) as [2019-02],
	SUM([2019-03]) as [2019-03],
	SUM([2019-04]) as [2019-04],
	SUM([2019-05]) as [2019-05],
	SUM([2019-06]) as [2019-06],
	SUM([2019-07]) as [2019-07],
	SUM([2019-08]) as [2019-08],
	SUM([2019-09]) as [2019-09],
	SUM([2019-10]) as [2019-10],
	SUM([2019-11]) as [2019-11],
	SUM([2019-12]) as [2019-12]
from vAD_A_ActualsSummaryA_2019
group by [Account],
	[Level],
	[Split Label],
	[Project],
	[Task],
	[Supplier]

