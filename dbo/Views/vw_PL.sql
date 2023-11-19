





CREATE view [dbo].[vw_PL]

as 

select f.* , cw.TotalingAccount,TotalingAccountDescription,PLType,PLGroup,PLOrder,Factor from facttransaction f
left join PL_Crosswalk cw on cw.AccountKey = f.AccountKey and cw.DepartmentKey = f.DepartmentKey
where plgroup is not null
and month(transactiondate) = 9
--where accountstring = '9821-899-000-000'
and month(TransactionDate) = 9 
and year(TransactionDate) = 2019

--select * from PLCrosswalk

