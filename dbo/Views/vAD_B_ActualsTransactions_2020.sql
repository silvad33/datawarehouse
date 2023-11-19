


CREATE VIEW [dbo].[vAD_B_ActualsTransactions_2020]
AS

select ISNULL(D.DepartmentNumber,'NA') + ' - ' + E.EntityID as [Level],
	TRIM(A.MainAccountNumber) as [Account], 
	FORMAT(F.TransactionDate,'yyyy-MM-dd') as [Posting Date],
	F.AccountingCurrencyAmount as [Transaction Amount],
	'D365' as [GL System],
	S.VOUCHER as [Transaction ID],
	CASE WHEN ISNULL(S.SubLedgerPartyNumber,'') = '' THEN '' ELSE CONCAT(ISNULL(S.SubLedgerPartyNumber,''),' - ',SUP.VENDORORGANIZATIONNAME, ' - ', SUP.DATAAREAID) END as [Supplier],
	P.ProjectNumber as [Project],
	T.TaskNumber as [Task],
	PT.PostingTypeDescription as [Transaction Type],
	F.TransactionDescription as [Description1],
	S.SubLedgerDocumentDescription as [Description2]
from FactTransaction as F
  inner join DimAccount as A on F.AccountKey = A.AccountKey
  inner join DimEntity as E on F.EntityKey = E.EntityKey
  inner join DimProject as P on F.ProjectKey = P.ProjectKey AND E.EntityID = P.DataAreaID
  inner join DimTask as T on F.TaskKey = T.TaskKey
  inner join DimFinancialCalendar as FC on F.[FiscalPeriodKey] = FC.[FiscalPeriodKey]
  left outer join (select distinct DestinationCompany, FactTransactionKey, SubLedgerPartyNumber, PostingType, SubLedgerDocumentDescription, VOUCHER
		from FactAccountingSourceExplorer
		where ISNULL(SubLedgerPartyNumber,'') <> ''
		) as S on F.RecID = S.FactTransactionKey and E.EntityID = S.DestinationCompany
  left outer join VendVendorV2Staging as SUP on S.SubLedgerPartyNumber = SUP.VENDORACCOUNTNUMBER
  left outer join PostingTypeCrossReference as PT on S.PostingType = PT.PostingType
  left outer join DimDepartment as D on F.DepartmentKey = D.DepartmentKey
where FC.Year = 2020
  and E.EntityID NOT LIKE 'C%'
  and F.Scenario = 'Actual'
  and A.MainAccountType in ('Cost','Profit and loss','Revenue')
