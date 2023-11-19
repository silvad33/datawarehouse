



CREATE PROCEDURE [dbo].[spFactTransaction] as

--select * from FactTransaction where FCastQ1Amount<>0

truncate table facttransaction
insert into FACTTRANSACTION ([AccountString]
      ,[TransactionDate]
      ,[Scenario]
	  ,SubScenario
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
	  ,FCastQ1Amount
	  ,FCastQ2Amount
	  ,FCastQ3Amount
	  ,FCastQ4Amount
      )
-- Normal actual transaction records (not headcount)
SELECT z.DisplayValue AccountString
		,z.Date TransactionDate
		,z.TransactionType Scenario 
		,z.SubScenario
		,z.InvoiceNumber
		,DESCRIPTION TransactionDescription
		,REPORTINGCURRENCYAMOUNT
		,ACCOUNTINGCURRENCYAMOUNT
		,TRANSACTIONCURRENCYAMOUNT
		,z.BudgetAmount
		,IsAllocated
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
		,FCastQ1
		,FCastQ2
		,FCastQ3
		,FCastQ4
FROM (
SELECT DISTINCT ACCOUNTDISPLAYVALUE DisplayValue
	,[MainAccount] Account
    ,[Department] Department
    ,[Project] Project
    ,[Task] Task
	,ACCOUNTINGDATE Date
	,[FiscalPeriodKey] AS FiscalPeriodKey
	,'Actual' TransactionType
	,'Actual' SubScenario
	,case when a.DESCRIPTION like 'Purchase Invoice%' then DOCUMENTNUMBER end InvoiceNumber
	,CASE WHEN ac.MainAccountType in ('Liability','Revenue') THEN -1 ELSE 1 END *
		REPORTINGCURRENCYAMOUNT ReportingCurrencyAmount
	,CASE WHEN ac.MainAccountType in ('Liability','Revenue') THEN -1 ELSE 1 END *
		ACCOUNTINGCURRENCYAMOUNT AccountingCurrencyAmount
	,CASE WHEN ac.MainAccountType in ('Liability','Revenue') THEN -1 ELSE 1 END *
		TRANSACTIONCURRENCYAMOUNT TransactionCurrencyAmount
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
	  ,0 as FCastQ1
		,0 as FCastQ2
		,0 as FCastQ3
		,0 as FCastQ4
FROM GeneralJournalAccountEntryStaging a
left JOIN [dbo].[DisplayValueExplosion] d ON d.DisplayValue = a.ACCOUNTDISPLAYVALUE
			and d.DataAreaID = a.DataAreaID
			and d.Partition = a.PARTITION
	left join dimaccount ac on ac.MainAccountNumber = d.MainAccount and ac.partition = d.partition
	left join DimDepartment dep on dep.DepartmentNumber = d.Department --and d.partition = z.partition
	left join dimproject pro on pro.dataareaid = a.DATAAREAID and pro.ProjectNumber = d.Project and pro.partition = a.partition
	left join dimtask t on t.dataareaid = a.DATAAREAID and t.TaskNumber = d.task and t.partition = a.partition
	left join dimentity e on e.entityID = a.DATAAREAID
	left 	 JOIN DimFinancialCalendar P ON P.FullDate = ACCOUNTINGDATE and p.EntityKey = e.EntityKey
	left join [dbo].[LedgerEntityStaging] l on l.[LEGALENTITYID] = a.dataareaid 
	where LEDGERACCOUNT not LIKE 'hc%'

	union 

	
SELECT DISTINCT  ACCOUNTDISPLAYVALUE DisplayValue
	,[MainAccount] Account
    ,[Department] Department
    ,[Project] Project
    ,[Task] Task
	,FullDate Date
	,[FiscalPeriodKey] AS FiscalPeriodKey
	,'Actual' TransactionType
	,'Actual' SubScenario
	,'' InvoiceNumber
	,0 ReportingCurrencyAmount
	,0 AccountingCurrencyAmount
	,0 TransactionCurrencyAmount
	,null BudgetAmount
	,'N/A' IsAllocated
	, '' DESCRIPTION
	,[FiscalPeriodKey]
	,a.PARTITION Partition
	,a.DataAreaID LegalEntity
	,AccountKey
	,ProjectKey
	,DepartmentKey
	,TaskKey
	,e.EntityKey
	,'' [REPORTINGCURRENCYCODE]
      ,'' [ACCOUNTINGCURRENCYCODE]
	  ,'' TRANSACTIONCURRENCYCODE,
	  '' VOUCHER
	  ,0 as FCastQ1
		,0 as FCastQ2
		,0 as FCastQ3
		,0 as FCastQ4
		
FROM (select distinct dataareaid, accountdisplayvalue,PARTITION from GeneralJournalAccountEntryStaging
where -- dataareaid = 'ions' and
	 accountdisplayvalue not LIKE 'hc%') a
left JOIN [dbo].[DisplayValueExplosion] d ON d.DisplayValue = a.ACCOUNTDISPLAYVALUE
			and d.DataAreaID = a.DataAreaID
			and d.Partition = a.PARTITION
	left join DimAccount ac on ac.MainAccountNumber = d.MainAccount and ac.partition = d.partition
	left join DimDepartment dep on dep.DepartmentNumber = d.Department --and d.partition = z.partition
	left join dimproject pro on pro.dataareaid = a.DATAAREAID and pro.ProjectNumber = d.Project and pro.partition = a.partition
	left join dimtask t on t.dataareaid = a.DATAAREAID and t.TaskNumber = d.task and t.partition = a.partition
	left join dimentity e on e.entityID = a.DATAAREAID
	left JOIN (select distinct FullDate ,[FiscalPeriodKey],EntityKey from DimFinancialCalendar where FullDate = eomonth(fulldate)) P ON  p.EntityKey = e.EntityKey
	--left join [dbo].[LedgerEntityStaging] l on l.[LEGALENTITYID] = a.dataareaid 
	where year(fulldate) >2017
	and year(fulldate) >= year(getdate())-2

	union

	
-- Normal baseline budget entries
SELECT DISTINCT DIMENSIONDISPLAYVALUE
	,[MainAccount]
    ,[Department]
    ,[Project]
    ,[Task]
	,DATE
	,[FiscalPeriodKey] AS FISCALPERIODKEY
	,'Budget' TransactionType
	,BUDGETMODELID SubScenario
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
	,0 as FCastQ1
	,0 as FCastQ2
	,0 as FCastQ3
	,0 as FCastQ4
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
	where b.DIMENSIONDISPLAYVALUE not LIKE 'hc%' and ( BUDGETMODELID like 'GP%' or budgetmodelid ='BUDGET')-- Baseline budgets

union


SELECT DISTINCT  DIMENSIONDISPLAYVALUE DisplayValue
	,[MainAccount] Account
    ,[Department] Department
    ,[Project] Project
    ,[Task] Task
	,FullDate Date
	,[FiscalPeriodKey] AS FiscalPeriodKey
	,'Budget' TransactionType
	,'Budget' SubScenario
	,'' InvoiceNumber
	,0 ReportingCurrencyAmount
	,0 AccountingCurrencyAmount
	,0 TransactionCurrencyAmount
	,0 BudgetAmount
	,'N/A' IsAllocated
	, '' DESCRIPTION
	,[FiscalPeriodKey]
	,a.PARTITION Partition
	,a.DataAreaID LegalEntity
	,AccountKey
	,ProjectKey
	,DepartmentKey
	,TaskKey
	,e.EntityKey
	,'' [REPORTINGCURRENCYCODE]
      ,'' [ACCOUNTINGCURRENCYCODE]
	  ,'' TRANSACTIONCURRENCYCODE,
	  '' VOUCHER
	  ,0 as FCastQ1
		,0 as FCastQ2
		,0 as FCastQ3
		,0 as FCastQ4
		
FROM (select distinct dataareaid, DIMENSIONDISPLAYVALUE,PARTITION 
from BudgetRegisterEntryStaging
where --dataareaid = 'ions' and
	 DIMENSIONDISPLAYVALUE not LIKE 'hc%') a
left JOIN [dbo].[DisplayValueExplosion] d ON d.DisplayValue = a.DIMENSIONDISPLAYVALUE
			and d.DataAreaID = a.DataAreaID
			and d.Partition = a.PARTITION
	left join DimAccount ac on ac.MainAccountNumber = d.MainAccount and ac.partition = d.partition
	left join DimDepartment dep on dep.DepartmentNumber = d.Department --and d.partition = z.partition
	left join dimproject pro on pro.dataareaid = a.DATAAREAID and pro.ProjectNumber = d.Project and pro.partition = a.partition
	left join dimtask t on t.dataareaid = a.DATAAREAID and t.TaskNumber = d.task and t.partition = a.partition
	left join dimentity e on e.entityID = a.DATAAREAID
	left JOIN (select distinct FullDate ,[FiscalPeriodKey],EntityKey from DimFinancialCalendar where FullDate = eomonth(fulldate)) P ON  p.EntityKey = e.EntityKey
	--left join [dbo].[LedgerEntityStaging] l on l.[LEGALENTITYID] = a.dataareaid 
	where year(fulldate) >2017
	and year(fulldate) >= year(getdate())-2
						
union
-- Actual Headcount journal entries
SELECT DISTINCT ACCOUNTDISPLAYVALUE DisplayValue
	,[MainAccount] Account
    ,[Department] Department
    ,[Project] Project
    ,[Task] Task
	,ACCOUNTINGDATE Date
	,[FiscalPeriodKey] AS FiscalPeriodKey
	,'Actual Headcount' TransactionType
	,'Actual Headcount' SubScenario
	,null
	,TRANSACTIONCURRENCYAMOUNT
	,null
	,null
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
	,0 as FCastQ1
	,0 as FCastQ2
	,0 as FCastQ3
	,0 as FCastQ4
FROM GeneralJournalAccountEntryStaging a
 JOIN [dbo].[DisplayValueExplosion] d ON d.DisplayValue = a.ACCOUNTDISPLAYVALUE
			and d.DataAreaID = a.DataAreaID
			and d.Partition = a.PARTITION
	left join DimAccount ac on ac.MainAccountNumber = d.MainAccount and ac.partition = d.partition
	left join DimDepartment dep on dep.DepartmentNumber = d.Department --and d.partition = z.partition
	left join dimproject pro on pro.dataareaid = a.DATAAREAID and pro.ProjectNumber = d.Project and pro.partition = a.partition
	left join dimtask t on t.dataareaid = a.DATAAREAID and t.TaskNumber = d.task and t.partition = a.partition
	left join dimentity e on e.entityID = a.DATAAREAID
	left 	 JOIN DimFinancialCalendar P ON P.FullDate = ACCOUNTINGDATE and p.EntityKey = e.EntityKey
						
		 where LEDGERACCOUNT LIKE 'hc-%'
UNION
-- Headcount baseline budget entries
SELECT DISTINCT DIMENSIONDISPLAYVALUE
	,[MainAccount]
    ,[Department]
    ,[Project]
    ,[Task]
	,DATE
	,[FiscalPeriodKey] AS FISCALPERIODKEY
	,'Budget Headcount' TransactionType
	,BUDGETMODELID SubScenario
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
	,0 as FCastQ1
	,0 as FCastQ2
	,0 as FCastQ3
	,0 as FCastQ4
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
	where DIMENSIONDISPLAYVALUE LIKE 'hc-%' and ( BUDGETMODELID like 'GP%' or budgetmodelid ='BUDGET') -- Baseline budgets

UNION
-- Normal forecast entries
SELECT DISTINCT DIMENSIONDISPLAYVALUE
	,[MainAccount]
    ,[Department]
    ,[Project]
    ,[Task]
	,DATE
	,[FiscalPeriodKey] AS FISCALPERIODKEY
	,'Forecast' TransactionType
	,BUDGETMODELID SubScenario
	,null
	,null
	,null
	,null
	,0
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
	,Case When BUDGETMODELID='FCSTQ1' THen TRANSACTIONCURRENCYAMOUNT ELSE 0 END as FCastQ1
	,Case When BUDGETMODELID='FCSTQ2' THen TRANSACTIONCURRENCYAMOUNT ELSE 0 END as FCastQ2
	,Case When BUDGETMODELID='FCSTQ3' THen TRANSACTIONCURRENCYAMOUNT ELSE 0 END as FCastQ3
	,Case When BUDGETMODELID='FCSTQ4' THen TRANSACTIONCURRENCYAMOUNT ELSE 0 END as FCastQ4
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
	where b.DIMENSIONDISPLAYVALUE not LIKE 'hc%' and BUDGETMODELID like 'FCSTQ%' -- Forecast budgets

UNION
-- Headcount forecast entries
SELECT DISTINCT DIMENSIONDISPLAYVALUE
	,[MainAccount]
    ,[Department]
    ,[Project]
    ,[Task]
	,DATE
	,[FiscalPeriodKey] AS FISCALPERIODKEY
	,'Forecast' TransactionType
	,BUDGETMODELID SubScenario
	,null
	,null
	,null
	,null
	,0
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
	,Case When BUDGETMODELID='FCSTQ1' THen QUANTITY ELSE 0 END as FCastQ1
	,Case When BUDGETMODELID='FCSTQ2' THen QUANTITY ELSE 0 END as FCastQ2
	,Case When BUDGETMODELID='FCSTQ3' THen QUANTITY ELSE 0 END as FCastQ3
	,Case When BUDGETMODELID='FCSTQ4' THen QUANTITY ELSE 0 END as FCastQ4
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
	where b.DIMENSIONDISPLAYVALUE  LIKE 'hc%' and BUDGETMODELID like 'FCSTQ%' -- Forecast budgets
		)Z
	where [FiscalPeriodKey] is not null
UPDATE FactTransaction
SET SecurityKey=
	(SELECT SecurityMasterID
	FROM D365SecurityMaster sm
	WHERE sm.DepartmentKey=FactTransaction.DepartmentKey and
		sm.EntityKey=FactTransaction.EntityKey)

--Load Adaptive Budget data to the FactTransaction table - hard coded for Budget Pass 5, 2021
Insert into mdr.RSMLogit (RunTS,RunProcess)
Values (getdate(),'spAdaptiveImport')
EXEC [dbo].[spAdaptiveImport] '2021 Budget Pass 5', 'Budget', '2021 Budget Pass 5', '1/1/2021', '12/31/2021',''