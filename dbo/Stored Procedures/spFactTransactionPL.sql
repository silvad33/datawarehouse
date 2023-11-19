
CREATE PROCEDURE [dbo].[spFactTransactionPL] as


truncate table facttransactionPL
insert into FACTTRANSACTIONPL ([AccountString]
      ,[TransactionDate]
      ,[Scenario]
	  ,InvoiceNumber
      ,[TransactionDescription]
      ,REPORTINGCURRENCYAMOUNT
		,ACCOUNTINGCURRENCYAMOUNT
		,TRANSACTIONAMOUNT
      ,[BudgetAmount]
      ,[IsAllocated]
      ,[RecID]
      ,[Partition]
      ,[AccountKey]
      ,[DepartmentKey]
      ,[ProjectKey]
      ,[TaskKey]
	  ,EntityKey
      ,[FiscalPeriodKey]
	  ,ReportingCurrencyCode 
	  ,AccountingCurrencyCode 
	  ,TransactionCurrencyCode
	  ,Voucher
      )
SELECT z.DisplayValue AccountString
		,z.Date TransactionDate
		,z.TransactionType Scenario 
		,z.InvoiceNumber
		,DESCRIPTION TransactionDescription
		,REPORTINGCURRENCYAMOUNT
		,ACCOUNTINGCURRENCYAMOUNT
		,TRANSACTIONCURRENCYAMOUNT
		,z.BudgetAmount
		,IsAllocated
		--,z.legalentity Entity
		--,le.EntityDescription
		--,le.EntityDescriptionID
		,z.RECID RecID
		,z.partition Partition
		,AccountKey
		,DepartmentKey
		,ProjectKey
		,TaskKey
		,entitykey
		,z.[FiscalPeriodKey]
		,ReportingCurrencyCode 
	    ,AccountingCurrencyCode 
	    ,TransactionCurrencyCode,
		VOUCHER
FROM (
SELECT DISTINCT ACCOUNTDISPLAYVALUE DisplayValue
	,[MainAccount] Account
    ,[Department] Department
    ,[Project] Project
    ,[Task] Task
	,ACCOUNTINGDATE Date
	,[FiscalPeriodKey] AS FiscalPeriodKey
	,'Actual' TransactionType
	,case when a.DESCRIPTION like 'Purchase Invoice%' then DOCUMENTNUMBER end InvoiceNumber
	--,CASE WHEN [MainAccount] LIKE '1%' OR [MainAccount] LIKE '3%' OR [MainAccount] LIKE '4%' THEN -1 ELSE 1 END *
	--	TRANSACTIONCURRENCYAMOUNT ActualAmount
	,--CASE WHEN ac.MainAccountType in ('Liability','Revenue') THEN -1 ELSE 1 END *
		REPORTINGCURRENCYAMOUNT ReportingCurrencyAmount
	,--CASE WHEN ac.MainAccountType in ('Liability','Revenue') THEN -1 ELSE 1 END *
		ACCOUNTINGCURRENCYAMOUNT AccountingCurrencyAmount
	,--CASE WHEN ac.MainAccountType in ('Liability','Revenue') THEN -1 ELSE 1 END *
		TRANSACTIONCURRENCYAMOUNT TransactionCurrencyAmount
		--TRANSACTIONCURRENCYAMOUNT,ACCOUNTINGCURRENCYAMOUNT,REPORTINGCURRENCYAMOUNT
	,null BudgetAmount
	,'N/A' IsAllocated
	,a.DESCRIPTION
	,a.RECID
	,a.PARTITION Partition
	,a.DataAreaID LegalEntity
	,AccountKey
	,ProjectKey
	,DepartmentKey
	,TaskKey
	,e.EntityKey
	,l.[REPORTINGCURRENCY] [REPORTINGCURRENCYCODE]
      ,l.[ACCOUNTINGCURRENCY] [ACCOUNTINGCURRENCYCODE]
	  ,a.TRANSACTIONCURRENCYCODE,
	  a.VOUCHER
FROM GeneralJournalAccountEntryStaging a
left JOIN [dbo].[DisplayValueExplosion] d ON d.DisplayValue = a.ACCOUNTDISPLAYVALUE
			and d.DataAreaID = a.DataAreaID
			and d.Partition = a.PARTITION
	left join DimAccount ac on ac.MainAccountNumber = d.MainAccount and ac.partition = d.partition
	left join DimDepartment dep on dep.DepartmentNumber = d.Department --and d.partition = z.partition
	left join dimproject pro on pro.dataareaid = a.DATAAREAID and pro.ProjectNumber = d.Project and pro.partition = a.partition
	left join dimtask t on t.dataareaid = a.DATAAREAID and t.TaskNumber = d.task and t.partition = a.partition
	left join dimentity e on e.entityID = a.DATAAREAID
	left 	 JOIN DimFinancialCalendar P ON P.FullDate = ACCOUNTINGDATE and p.EntityKey = e.EntityKey
	left join [dbo].[LedgerEntityStaging] l on l.[LEGALENTITYID] = a.dataareaid 
		
	--where a.RECID > (select max(recid) from RecordLog 
	--					where sourceTable = 'FactTransaction' 
	--						and type = 'Actual' )
						
--		 where DisplayValue = '1001---'
	where LEDGERACCOUNT not LIKE 'hc%'
UNION

SELECT DISTINCT DIMENSIONDISPLAYVALUE
	,[MainAccount]
    ,[Department]
    ,[Project]
    ,[Task]
	,DATE
	,[FiscalPeriodKey] AS FiscalPeriodKey
	,'Budget' TransactionType
	,null
	,null
	,null
	,null
	,TRANSACTIONCURRENCYAMOUNT
	,'N/A' IsAllocated
	,b.COMMENT_
	,b.RECID
	,b.PARTITION
	,b.DataAreaID
	,AccountKey
	,ProjectKey
	,DepartmentKey
	,TaskKey
	,e.entitykey
	,null
	,null
	,null
	,null
FROM BudgetRegisterEntryStaging b
 JOIN [dbo].[DisplayValueExplosion] d ON d.DisplayValue = b.DIMENSIONDISPLAYVALUE
			and d.DataAreaID = b.DataAreaID
			and d.Partition = b.PARTITION
	left join DimAccount ac on ac.MainAccountNumber = d.MainAccount and ac.partition = d.partition
	left join DimDepartment dep on dep.DepartmentNumber = d.Department --and d.partition = z.partition
	left join dimproject pro on pro.dataareaid = b.DATAAREAID and pro.ProjectNumber = d.Project and pro.partition = b.partition
	left join dimtask t on t.dataareaid = b.DATAAREAID and t.TaskNumber = d.task and t.partition = b.partition
	left join dimentity e on e.entityID = b.DATAAREAID	
	left 	 JOIN DimFinancialCalendar P ON P.FullDate = DATE and p.EntityKey = e.EntityKey
	--where b.RECID > (select max(recid) from RecordLog 
	--					where sourceTable = 'FactTransaction' 
	--						and type = 'Budget' )
	where b.DIMENSIONDISPLAYVALUE not LIKE 'hc%'
						
union
SELECT DISTINCT ACCOUNTDISPLAYVALUE DisplayValue
	,[MainAccount] Account
    ,[Department] Department
    ,[Project] Project
    ,[Task] Task
	,ACCOUNTINGDATE Date
	,[FiscalPeriodKey] AS FiscalPeriodKey
	,'Actual Headcount' TransactionType
	,null
	--,CASE WHEN [MainAccount] LIKE '1%' OR [MainAccount] LIKE '3%' OR [MainAccount] LIKE '4%' THEN -1 ELSE 1 END *
	--	TRANSACTIONCURRENCYAMOUNT ActualAmount
	,QUANTITY
	,null
	,null
		--TRANSACTIONCURRENCYAMOUNT,ACCOUNTINGCURRENCYAMOUNT,REPORTINGCURRENCYAMOUNT
	,null BudgetAmount
	,'N/A' IsAllocated
	,a.DESCRIPTION
	,a.RECID
	,a.PARTITION Partition
	,a.DataAreaID LegalEntity
	,AccountKey
	,ProjectKey
	,DepartmentKey
	,TaskKey
	,e.EntityKey
	,null
	,null
	,null
	,null
FROM GeneralJournalAccountEntryStaging a
 JOIN [dbo].[DisplayValueExplosion] d ON d.DisplayValue = a.ACCOUNTDISPLAYVALUE
			and d.DataAreaID = a.DataAreaID
			and d.Partition = a.PARTITION
	left join DimAccount ac on ac.MainAccountNumber = d.MainAccount and ac.partition = d.partition
	left join DimDepartment dep on dep.DepartmentNumber = d.Department --and d.partition = z.partition
	left join dimproject pro on pro.dataareaid = a.DATAAREAID and pro.ProjectNumber = d.Project and pro.partition = a.partition
	left join dimtask t on t.dataareaid = a.DATAAREAID and t.TaskNumber = d.task and t.partition = a.partition
	left join dimentity e on e.entityID = a.DATAAREAID
	--where a.RECID > (select max(recid) from RecordLog 
	--					where sourceTable = 'FactTransaction' 
	--						and type = 'Actual' )
	left 	 JOIN DimFinancialCalendar P ON P.FullDate = ACCOUNTINGDATE and p.EntityKey = e.EntityKey
						
		 where LEDGERACCOUNT LIKE 'hc-%'
UNION

SELECT DISTINCT DIMENSIONDISPLAYVALUE
	,[MainAccount]
    ,[Department]
    ,[Project]
    ,[Task]
	,DATE
	,[FiscalPeriodKey] AS FiscalPeriodKey
	,'Budget Headcount' TransactionType
	,null
	,null
	,null
	,null
	,QUANTITY
	,'N/A' IsAllocated
	,b.COMMENT_
	,b.RECID
	,b.PARTITION
	,b.DataAreaID
	,AccountKey
	,ProjectKey
	,DepartmentKey
	,TaskKey
	,e.entitykey
	,null
	,null
	,null
	,null
FROM BudgetRegisterEntryStaging b
 JOIN [dbo].[DisplayValueExplosion] d ON d.DisplayValue = b.DIMENSIONDISPLAYVALUE
			and d.DataAreaID = b.DataAreaID
			and d.Partition = b.PARTITION
	left join DimAccount ac on ac.MainAccountNumber = d.MainAccount and ac.partition = d.partition
	left join DimDepartment dep on dep.DepartmentNumber = d.Department --and d.partition = z.partition
	left join dimproject pro on pro.dataareaid = b.DATAAREAID and pro.ProjectNumber = d.Project and pro.partition = b.partition
	left join dimtask t on t.dataareaid = b.DATAAREAID and t.TaskNumber = d.task and t.partition = b.partition
	left join dimentity e on e.entityID = b.DATAAREAID
	left 	 JOIN DimFinancialCalendar P ON P.FullDate = DATE and p.EntityKey = e.EntityKey
	where DIMENSIONDISPLAYVALUE LIKE 'hc-%'
	)Z
	where [FiscalPeriodKey] is not null

UPDATE FACTTRANSACTIONPL
SET SecurityKey=
	(SELECT SecurityMasterID
	FROM D365SecurityMaster sm
	WHERE sm.DepartmentKey=FACTTRANSACTIONPL.DepartmentKey and
		sm.EntityKey=FACTTRANSACTIONPL.EntityKey)

