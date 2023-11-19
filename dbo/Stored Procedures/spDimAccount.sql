
--select * from DimAccount where MainAccountNumber = '9307'



CREATE PROCEDURE  [dbo].[spDimAccount] as
/****** Script for SelectTopNRows command from SSMS  ******/
TRUNCATE TABLE DimAccount

INSERT INTO dimaccount
( [MainAccountNumber]
      ,[MainAccountDescription]
      ,[MainAccountNumberDescription]
      ,[MainAccountDescriptionNumber]
      ,[MainAccountType]
      ,[MainAccountCategoryDescription]
      ,[level5]
      ,[level5Description]
      ,[level4]
      ,[level4Description]
      ,[level3]
      ,[level3Description]
      ,[Level2]
      ,[Level2Description]
      ,[Level1]
      ,[Level1Description]
      ,[IsGAAP]
      ,[IsControlled]
      ,[IsFTE]
      ,[PARTITION]
      ,[IsActive])
SELECT distinct MainAccountNumber,MainAccountDescription,MainAcountNumberDescription MainAccountNumberDescription, MainAccountDescriptionNumber
,MainAccountType,MainAccountCategoryDescription
		,case when level5 is not null then level5  
				when level4 is not null and level5 is null then level4
				when level3 is not null and level5 is null and level4 is null then level3
				when level2 is not null and level5 is null and level4 is null and level3 is null then level2
				when level5 is null and level4 is null and level3 is null and level2 is null then level1 end level5
			,case when level5 is not null then Level5Description
				when level4 is not null and level5 is null then level4Description
				when level3 is not null and level5 is null and level4 is null then level3Description
				when level2 is not null and level5 is null and level4 is null and level3 is null then level2Description
				when level5 is null and level4 is null and level3 is null and level2 is null then level1Description end level5Description
			,case  when level5 is not null then level4
					when level5 is null and level4 is not null then level3
					when level5 is null and level4 is null and level3 is not null then level2
					when level5 is null and level4 is null and level3 is null then level1
					when level3 is null then level1	 end level4
			,case  when level5 is not null then level4Description
					when level5 is null and level4 is not null then level3Description
					when level5 is null and level4 is null and level3 is not null then level2Description
					when level5 is null and level4 is null and level3 is null then level1Description
					when level3 is null then level1	 end level4Description
			,case when level5 is not null then level3
				when level4 is not null then level2
				when level3 is not null then level1 end level3
			,case when level5 is not null then level3Description
				when level4 is not null then level2Description
				when level3 is not null then level1Description end level3Description
			,case when level5 is not null then level2 
				when level4 is not null then level1 end Level2
			,case when level5 is not null then level2Description 
				when level4 is not null then level1Description end Level2Description
			,case when level5 is not null then level1 end Level1
			,case when level5 is not null then level1Description end Level1Description
			,IsGAAP
			,IsControlled
			,IsFTE
			,PARTITION
			,IsActive
		FROM(
	SELECT a.[MAINACCOUNTID] MainAccountNumber
		,a.[NAME] MainAccountDescription
		,CONCAT (
			a.[MAINACCOUNTID]
			,' - '
			,a.[NAME]
			) MainAcountNumberDescription
		,CONCAT (
			a.[NAME]
			,' ('
			,a.[MAINACCOUNTID]
			,')'
			) MainAccountDescriptionNumber
		,CASE 
			WHEN a.MAINACCOUNTTYPE = 0
				THEN 'Profit and loss'
			WHEN a.MAINACCOUNTTYPE = 1
				THEN 'Revenue'
			WHEN a.MAINACCOUNTTYPE = 2
				THEN 'Cost'
			WHEN a.MAINACCOUNTTYPE = 3
				THEN 'Balance'
			WHEN a.MAINACCOUNTTYPE = 4
				THEN 'Asset'
			WHEN a.MAINACCOUNTTYPE = 5
				THEN 'Liability'
			WHEN a.MAINACCOUNTTYPE = 6
				THEN 'Header'
			WHEN a.MAINACCOUNTTYPE = 7
				THEN 'Empty header'
			WHEN a.MAINACCOUNTTYPE = 8
				THEN 'Page header'
			END MainAccountType
		,a.[ACCOUNTCATEGORYDESCRIPTION] MainAccountCategoryDescription
		,[Level1] Level1
		,l1.NAME Level1Description
		,[Level2] Level2
		,l2.NAME Level2Description
		,[Level3] Level3
		,l3.NAME Level3Description
		,level4 Level4
		,l4.NAME Level4Description
		,[Level5] Level5
		,l5.NAME Level5Description
		,CASE 
			WHEN a.MAINACCOUNTID = '9805'
				THEN NULL
			ELSE 1
			END IsGAAP
		,CASE 
			WHEN Level2 = '739999'
				THEN 1
			ELSE NULL
			END IsControlled
		,CASE 
			WHEN fte.MAINACCOUNTID IS NOT NULL
				THEN 1
			ELSE NULL
			END IsFTE
		,a.[PARTITION]
		,case when a.DONOTALLOWMANUALENTRY = 0 THEN 1 ELSE 0 END as IsActive
	FROM [dbo].[MainAccountStaging] a
	LEFT JOIN [dbo].[TotalingAccountTree] T ON a.mainaccountid = t.LeafAccount
	LEFT JOIN [dbo].[vwFTEAccounts] FTE ON fte.MAINACCOUNTID = a.MAINACCOUNTID
		AND fte.PARTITION = a.PARTITION
	LEFT JOIN [dbo].[MainAccountStaging] l1 ON l1.MAINACCOUNTID = t.[Level1]
		AND l1.PARTITION = a.PARTITION
	LEFT JOIN [dbo].[MainAccountStaging] l2 ON l2.MAINACCOUNTID = t.[Level2]
		AND l2.PARTITION = a.PARTITION
	LEFT JOIN [dbo].[MainAccountStaging] l3 ON l3.MAINACCOUNTID = t.[Level3]
		AND l3.PARTITION = a.PARTITION
	LEFT JOIN [dbo].[MainAccountStaging] l4 ON l4.MAINACCOUNTID = t.[Level4]
		AND l4.PARTITION = a.PARTITION
	LEFT JOIN [dbo].[MainAccountStaging] l5 ON l5.MAINACCOUNTID = t.[Level5]
		AND l5.PARTITION = a.PARTITION
	WHERE len(a.MAINACCOUNTID) <= 4
	) z

		delete from DimAccount where len(MainAccountNumber) > 4


update dimaccount
set Level2 = level3,
Level2Description = level3Description
where MainAccountNumber like '46%'




update dimaccount
set Level1 = 500011,
Level1Description = 'Total Car & Housing Allowance',
 Level5 = 999999,
Level5Description = 'Total Operating Expenses',
 Level4 = 739999,
Level4Description = 'Total Controllable Expenses',
 Level3 = 731999,
Level3Description = 'Total Controllable (excl. COGS)',
 Level2 = 500999,
Level2Description = 'Total Population Expenses'
where MainAccountNumber like  '5026'

update dimaccount
set Level2 = level3,
Level2Description = level3Description
where MainAccountNumber like '46%'
or MainAccountNumber = '9805'




--update dimaccount
--set --Level1 = 500011,
----Level1Description = 'Total Car & Housing Allowance',
-- Level5 = null--,
----Level5Description = 'Total Operating Expenses',
---- Level4 = 899999,
----Level4Description = 'Total Corporate Expense',
---- Level3 = 892999,
----Level3Description = 'Total Corporate (non-GAAP)',
---- Level2 = 892004,
----Level2Description = 'Total Depreciation & Amortization'
--where MainAccountNumber like  '9307'


