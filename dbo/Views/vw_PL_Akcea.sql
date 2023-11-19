


CREATE view [dbo].[vw_PL_Akcea]

as 

select f.* , cw.TotalingAccount,TotalingAccountDescription,PLType,PLGroup,PLOrder,Factor from FactTransactionPL f
left join PL_Crosswalk_Akcea cw on cw.mainAccount = left(accountstring,4) and cw.DepartmentKey = f.DepartmentKey

where plgroup is not null
and pltype = 'internal proforma'
and IsAllocated in ('Allocated','N/A')

