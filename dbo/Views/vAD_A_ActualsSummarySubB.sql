

CREATE view [dbo].[vAD_A_ActualsSummarySubB]
as
select A.MainAccountNumber as [Account], 
	ISNULL(D.DepartmentNumber,'NA') + ' - ' + E.EntityID as [Level],
	'' as [Split Label],
	P.ProjectNumber as [Project],
	T.TaskNumber as [Task],
	--ISNULL(S.SubLedgerPartyNumber,'') as [Supplier],
	CASE WHEN ISNULL(S.SubLedgerPartyNumber,'') = '' THEN '' ELSE CONCAT(S.SubLedgerPartyNumber,' - ',SUP.VENDORORGANIZATIONNAME,' - ',SUP.DATAAREAID) END as [Supplier],

--select top 10 VENDORACCOUNTNUMBER, VENDORORGANIZATIONNAME, DATAAREAID
--from VendVendorV2Staging

	CONVERT(varchar(2),FC.MonthNumer) + '-' + CONVERT(char(4),FC.[Year]) as [Period],
	sum(F.AccountingCurrencyAmount) as [PeriodAmount]
from FactTransaction as F
  inner join DimAccount as A on F.AccountKey = A.AccountKey
  inner join DimEntity as E on F.EntityKey = E.EntityKey
  inner join DimProject as P on F.ProjectKey = P.ProjectKey AND E.EntityID = P.DataAreaID
  inner join DimTask as T on F.TaskKey = T.TaskKey AND E.EntityID = T.DataAreaID
  inner join DimFinancialCalendar as FC on F.[FiscalPeriodKey] = FC.[FiscalPeriodKey]
  left outer join (select distinct FactTransactionKey, SubLedgerPartyNumber
		from FactAccountingSourceExplorer
		where ISNULL(SubLedgerPartyNumber,'') <> ''
		) as S on F.RecID = S.FactTransactionKey
  left outer join VendVendorV2Staging as SUP on S.SubLedgerPartyNumber = SUP.VENDORACCOUNTNUMBER
  left outer join DimDepartment as D on F.DepartmentKey = D.DepartmentKey
where F.Scenario = 'Actual'
  and A.MainAccountType in ('Cost','Profit and loss','Revenue')
  and F.TransactionDate >= '1/1/2019'
group by A.MainAccountNumber, 
	ISNULL(D.DepartmentNumber,'NA') + ' - ' + E.EntityID,
	P.ProjectNumber,
	T.TaskNumber,
	S.SubLedgerPartyNumber,
	SUP.VENDORORGANIZATIONNAME,
	SUP.DATAAREAID,
	CONVERT(varchar(2),FC.MonthNumer) + '-' + CONVERT(char(4),FC.[Year])
