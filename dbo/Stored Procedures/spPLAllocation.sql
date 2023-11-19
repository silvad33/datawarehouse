CREATE proc [dbo].[spPLAllocation]

as

UPDATE facttransactionpl
SET isallocated = 'Not Allocated'
WHERE CONCAT (
		recid
		,'-'
		,entitykey
		) IN (
		SELECT DISTINCT CONCAT (
				recid
				,'-'
				,a.entitykey
				)
		FROM FactTransactionpl a
		JOIN DimEntity e ON e.EntityKey = a.EntityKey
		JOIN [dbo].[DisplayValueExplosion] d ON d.DisplayValue = a.AccountString
			AND d.DataAreaID = e.EntityID
			AND d.PARTITION = a.PARTITION
		JOIN [dbo].[ProjectAllocation] pa ON pa.department = d.Department
			AND pa.DataAreaID = e.EntityID
			AND a.TransactionDate >= StartDate
			AND a.TransactionDate <= EndDate
			AND d.Project = '000'
		WHERE mainaccount IN (
				SELECT DISTINCT MainAccountNumber
				FROM DimAccount
				WHERE mainaccounttype IN (
						'Cost'
					--	,'Revenue'
						)
				and MainAccountNumber not in 
				(select distinct account 
				from PLExclusionAccount 
				where include = 'n')
				)
			AND IsAllocated = 'N/A'
		)



INSERT INTO FactTransactionpl (
	[AccountString]
	,[TransactionDate]
	,[Scenario]
	,[TransactionDescription]
	,[BudgetAmount]
	,[IsAllocated]
	,[RecID]
	,[Partition]
	,[AccountKey]
	,[DepartmentKey]
	,[ProjectKey]
	,[TaskKey]
	,[FiscalPeriodKey]
	,[EntityKey]
	,[TransactionAmount]
	,[ReportingCurrencyAmount]
	,[AccountingCurrencyAmount]
	,[ReportingCurrencyCode]
	,[AccountingCurrencyCode]
	,[TransactionCurrencyCode]
	,[InvoiceNumber]
	,[SecurityKey]
	,[Voucher]
	)
SELECT DISTINCT CONCAT (
		d.MainAccount
		,'-'
		,d.department
		,'-'
		,pa.Project
		,'-'
		,'000'
		)
	,a.TransactionDate
	,'Actual'
	,a.TransactionDescription
	,NULL
	,'Allocated'
	,a.recid
	,a.PARTITION
	,a.accountkey
	,a.DepartmentKey
	,dp.ProjectKey
	,(
		SELECT taskkey
		FROM dimtask t
		WHERE TaskNumber = '000'
			AND t.DataAreaID = e.EntityID
		)
	,a.FiscalPeriodKey
	,a.EntityKey
	,round(a.TransactionAmount * AllocationPercentage, 2) AllocatedTransactionCurrencyAmount
	,round(a.ReportingCurrencyAmount * AllocationPercentage, 2) AllocatedReportingCurrencyAmount
	,round(a.AccountingCurrencyAmount * AllocationPercentage, 2) AllocatedAccountingCurrencyAmount
	,a.ReportingCurrencyCode
	,a.AccountingCurrencyCode
	,a.TransactionCurrencyCode
	,a.InvoiceNumber
	,a.SecurityKey
	,a.Voucher
FROM FactTransactionpl a
JOIN DimEntity e ON e.EntityKey = a.EntityKey
JOIN [dbo].[DisplayValueExplosion] d ON d.DisplayValue = a.AccountString
	AND d.DataAreaID = e.EntityID
	AND d.PARTITION = a.PARTITION
JOIN [dbo].[ProjectAllocation] pa ON pa.department = d.Department
	AND pa.DataAreaID = e.EntityID
	AND a.TransactionDate >= StartDate
	AND a.TransactionDate <= EndDate
	AND d.Project = '000'
left join DimProject dp on dp.ProjectNumber = pa.Project
	and pa.DataAreaID = dp.DataAreaID
WHERE mainaccount IN (SELECT DISTINCT MainAccountNumber
				FROM DimAccount
				WHERE mainaccounttype IN (
						'Cost'
					--	,'Revenue'
						)
				and MainAccountNumber not in 
				(select distinct account 
				from PLExclusionAccount 
				where include = 'n')
		)
	AND IsAllocated = 'Not Allocated'
	
	update facttransactionpl
	set [TransactionAmount] = [TransactionAmount] + TA,
	[ReportingCurrencyAmount] = [ReportingCurrencyAmount] + RA
	,[AccountingCurrencyAmount] = [AccountingCurrencyAmount]+AA
	from(
SELECT pl.recid
	,pl.entitykey
	,proj.ProjectKey
	,sum(pl.[TransactionAmount]) - al.TransactionAmount TA
	,sum(pl.[ReportingCurrencyAmount]) - ReportingAmount RA
	,sum(pl.[AccountingCurrencyAmount]) -AccountingAmoint AA
FROM FactTransactionpl pl
JOIN (
	SELECT recid
		,entitykey
		,sum([TransactionAmount]) TransactionAmount
		,sum([ReportingCurrencyAmount]) ReportingAmount
		,sum([AccountingCurrencyAmount]) AccountingAmoint
	FROM FactTransactionpl
	WHERE isallocated = 'Allocated'
	GROUP BY recid
		,entitykey
	) al ON al.recid = pl.recid
	AND al.entitykey = pl.entitykey
	join (	select recid,entitykey,max(projectkey) ProjectKey from facttransactionpl
	where isallocated = 'allocated'
	group by recid,entitykey)Proj on proj.recid = pl.recid and proj.entitykey = pl.entitykey
WHERE isallocated = 'Not Allocated'
GROUP BY pl.recid
	,pl.entitykey
	,al.TransactionAmount
	,al.ReportingAmount
	,al.AccountingAmoint
	,proj.ProjectKey
	) Recon 
	where recon.recid  = facttransactionpl.recid 
	and facttransactionpl.entitykey = Recon.entitykey 
	and Recon.ProjectKey = facttransactionpl.projectkey



	update FactTransactionPL 
set FactTransactionPL.ProjectKey = z.projectkey
from (select projectkey,ProjectNumber,DataAreaID ,e.EntityKey
from DimProject p
join DimEntity e on p.DataAreaID = e.EntityID
where ProjectNumber = '000')z
where FactTransactionPL.ProjectKey in (select projectkey from DimProject
where 
ProjectDescription is null)
and FactTransactionPL.EntityKey = z.EntityKey





