
CREATE proc [dbo].[sp_LoadPLStage]
as
Truncate table PLStage
insert into PLStage

select distinct [TOTALINGMAINACCOUNTID] TotalingAccount
			,ms.name TotalingAccountDescription
			,ae.COMPONENTMAINACCOUNTID MainAccount
			,DA.AccountKey
			,dd.DepartmentKey
			,dd.DepartmentNumber  FROM [dbo].[vwtotalingAccountExplosion] AE
		left join [MainAccountStaging] ms on ms.MAINACCOUNTID = ae.[TOTALINGMAINACCOUNTID]
		left join [MainAccountStaging] ms2 on ms2.MAINACCOUNTID = ae.COMPONENTMAINACCOUNTID
		join DimAccount da on da.MainAccountNumber = COMPONENTMAINACCOUNTID
		left join FactTransaction ft on ft.AccountKey =da.AccountKey
		JOIN DimDepartment DD on DD.DepartmentKey = ft.DepartmentKey
		and DepartmentNumber != 'FACILITIES'
		WHERE len(ae.COMPONENTMAINACCOUNTID) = 4
