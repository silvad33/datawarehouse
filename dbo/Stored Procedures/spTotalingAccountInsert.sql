--/****** Object:  StoredProcedure [dbo].[spTotalingAccountInsert]    Script Date: 7/14/2020 1:18:32 PM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

CREATE Proc [dbo].[spTotalingAccountInsert] as

select * into #tempLevels from (
SELECT level1
	,CASE 
		WHEN Level1vLevel2 = 0
			THEN level2
		END Level2
	,CASE 
		WHEN level2 < level3
			AND level1vlevel3 = 0
			AND level2vlevel3 = 0
			THEN level3
		END Level3
	,NULL Level4
	,null Level5
from [StageLevelExplosion]
WHERE type = 'check'
	AND level4 IS NULL
	AND level5 IS NULL
	AND level6 IS NULL
	AND level7 IS NULL
	AND level8 IS NULL
	AND level9 IS NULL
	AND level10 IS NULL

UNION

select level1,case when lvl2>level1 then lvl2 end 
,case when case when lvl2>level1 then lvl2 end  is not null and lvl3 > case when lvl2>level1 then lvl2 end  then lvl3 end
,case when case when case when lvl2>level1 then lvl2 end  is not null and lvl3 > case when lvl2>level1 then lvl2 end  then lvl3 end is not null then lvl4 end
	,null
from(
SELECT level1
	,CASE 
		WHEN Level1vLevel2 = 0
			THEN level2
		END lvl2
	,CASE 
		WHEN level2 < level3
			AND level1vlevel3 = 0
			AND level2vlevel3 = 0
			THEN level3
		END lvl3
	,CASE 
		WHEN level3 < level4
			AND level1vlevel4 = 0
			AND level2vlevel4 = 0
			AND level3vlevel4 = 0
			THEN level4
		END lvl4
FROM [dbo].[StageLevelExplosion]
WHERE type = 'check'
	AND level4 IS NOT NULL
	AND level5 IS NULL
	AND level6 IS NULL
	AND level7 IS NULL
	AND level8 IS NULL
	AND level9 IS NULL
	AND level10 IS NULL)z

UNION

select level1,lvl2,lvl3,
case when lvl3 is not null and lvl4=lvl3 and lvl5>lvl3 then lvl5
	when lvl3 is not null and lvl4 is null and lvl5>lvl3  then lvl5 else lvl4 end lvl4
	,null
from(
SELECT level1
	,lvl2
	,CASE 
		WHEN lvl3 IS NULL
			AND lvl4 IS NOT NULL
			AND lvl4 > lvl2
			THEN lvl4
		WHEN lvl3 IS NULL
			AND lvl4 IS NULL
			AND lvl5 > lvl2
			THEN lvl5
		ELSE lvl3
		END lvl3
		,lvl4
		,lvl5
FROM (
	SELECT level1
		,CASE 
			WHEN Level1vLevel2 = 0
				THEN level2
			END Lvl2
		,CASE 
			WHEN level2 < level3
				AND level1vlevel3 = 0
				AND level2vlevel3 = 0
				THEN level3
			END Lvl3
		,CASE 
			WHEN level3 < level4
				AND level1vlevel4 = 0
				AND level2vlevel4 = 0
				AND level3vlevel4 = 0
				THEN level4
			END Lvl4
		,CASE 
			WHEN level4 < level5
				AND level1vlevel5 = 0
				AND level2vlevel5 = 0
				AND level3vlevel5 = 0
				AND level4vlevel5 = 0
				THEN level5
			END lvl5
	FROM [dbo].[StageLevelExplosion]
	WHERE type = 'check'
		AND level4 IS NOT NULL
		AND level5 IS NOT NULL
		AND level6 IS NULL
		AND level7 IS NULL
		AND level8 IS NULL
		AND level9 IS NULL
		AND level10 IS NULL
	) z)z


union

select level1,lvl2,case when lvl3 is null and lvl4 is null and lvl5 is null and lvl6 >lvl2 then lvl6 
						when lvl3 is null and lvl4 is null and lvl5 >lvl2 then lvl5 
						when lvl3 is null and lvl4 > lvl2 then lvl4 else lvl3 end
		,null
	,null
from(
SELECT level1
		,CASE 
			WHEN Level1vLevel2 = 0
				THEN level2
			END Lvl2
		,CASE 
			WHEN level2 < level3
				AND level1vlevel3 = 0
				AND level2vlevel3 = 0
				THEN level3
			END Lvl3
		,CASE 
			WHEN level3 < level4
				AND level1vlevel4 = 0
				AND level2vlevel4 = 0
				AND level3vlevel4 = 0
				THEN level4
			END Lvl4
		,CASE 
			WHEN level4 < level5
				AND level1vlevel5 = 0
				AND level2vlevel5 = 0
				AND level3vlevel5 = 0
				AND level4vlevel5 = 0
				THEN level5
			END lvl5
		,CASE 
			WHEN level5 < level6
				AND level1vlevel6 = 0
				AND level2vlevel6 = 0
				AND level3vlevel6 = 0
				AND level4vlevel6 = 0
				AND level5vlevel6 = 0
				THEN level6 end lvl6
	FROM [dbo].[StageLevelExplosion]
	WHERE type = 'check'
		AND level4 IS NOT NULL
		AND level5 IS NOT NULL
		AND level6 IS not NULL
		AND level7 IS NULL
		AND level8 IS NULL
		AND level9 IS NULL
		AND level10 IS NULL)z

		union 

	select level1,lvl2,lvl3,null
	,null from(
SELECT level1
		,CASE 
			WHEN Level1vLevel2 = 0
				THEN level2
			END Lvl2
		,CASE 
			WHEN level2 < level3
				AND level1vlevel3 = 0
				AND level2vlevel3 = 0
				THEN level3
			END Lvl3
		,CASE 
			WHEN level3 < level4
				AND level1vlevel4 = 0
				AND level2vlevel4 = 0
				AND level3vlevel4 = 0
				THEN level4
			END Lvl4
		,CASE 
			WHEN level4 < level5
				AND level1vlevel5 = 0
				AND level2vlevel5 = 0
				AND level3vlevel5 = 0
				AND level4vlevel5 = 0
				THEN level5
			END lvl5
		,CASE 
			WHEN level5 < level6
				AND level1vlevel6 = 0
				AND level2vlevel6 = 0
				AND level3vlevel6 = 0
				AND level4vlevel6 = 0
				AND level5vlevel6 = 0
				THEN level6 end lvl6
		,CASE 
			WHEN level6 < level7
				AND level1vlevel7 = 0
				AND level2vlevel7 = 0
				AND level3vlevel7 = 0
				AND level4vlevel7 = 0
				AND level5vlevel7 = 0
				AND level6vlevel7 = 0
				THEN level6 end lvl7
	FROM [dbo].[StageLevelExplosion]
	WHERE type = 'check'
		AND level4 IS NOT NULL
		AND level5 IS NOT NULL
		AND level6 IS not NULL
		AND level7 IS not NULL
		AND level8 IS NULL
		AND level9 IS NULL
		AND level10 IS NULL)z


		union 

		select level1,lvl2,case when lvl3 is null and lvl4 is not null then lvl4 else lvl3 end ,
		case when lvl4 != case when lvl3 is null and lvl4 is not null then lvl4 else lvl3 end then lvl4 end 
	,null from(
		SELECT level1
		,CASE 
			WHEN Level1vLevel2 = 0
				THEN level2
			END Lvl2
		,CASE 
			WHEN level2 < level3
				AND level1vlevel3 = 0
				AND level2vlevel3 = 0
				THEN level3
			END Lvl3
		,CASE 
			WHEN level3 < level4
				AND level1vlevel4 = 0
				AND level2vlevel4 = 0
				AND level3vlevel4 = 0
				THEN level4
			END Lvl4
		,CASE 
			WHEN level4 < level5
				AND level1vlevel5 = 0
				AND level2vlevel5 = 0
				AND level3vlevel5 = 0
				AND level4vlevel5 = 0
				THEN level5
			END lvl5
		,CASE 
			WHEN level5 < level6
				AND level1vlevel6 = 0
				AND level2vlevel6 = 0
				AND level3vlevel6 = 0
				AND level4vlevel6 = 0
				AND level5vlevel6 = 0
				THEN level6 end lvl6
		,CASE 
			WHEN level6 < level7
				AND level1vlevel7 = 0
				AND level2vlevel7 = 0
				AND level3vlevel7 = 0
				AND level4vlevel7 = 0
				AND level5vlevel7 = 0
				AND level6vlevel7 = 0
				THEN level6 end lvl7
			,CASE 
			WHEN level7 < level8
				AND level1vlevel8 = 0
				AND level2vlevel8 = 0
				AND level3vlevel8 = 0
				AND level4vlevel8 = 0
				AND level5vlevel8 = 0
				AND level6vlevel8 = 0
				THEN level8 end lvl8
	FROM [dbo].[StageLevelExplosion]
	WHERE type = 'check'
		AND level4 IS NOT NULL
		AND level5 IS NOT NULL
		AND level6 IS not NULL
		AND level7 IS not NULL
		AND level8 IS not NULL
		AND level9 IS NULL
		AND level10 IS NULL)z


	union 

	select level1,lvl2,lvl3,lvl4,lvl5 from(
		SELECT level1
		,CASE 
			WHEN Level1vLevel2 = 0
				THEN level2
			END Lvl2
		,CASE 
			WHEN level2 < level3
				AND level1vlevel3 = 0
				AND level2vlevel3 = 0
				THEN level3
			END Lvl3
		,CASE 
			WHEN level3 < level4
				AND level1vlevel4 = 0
				AND level2vlevel4 = 0
				AND level3vlevel4 = 0
				THEN level4
			END Lvl4
		,CASE 
			WHEN level4 < level5
				AND level1vlevel5 = 0
				AND level2vlevel5 = 0
				AND level3vlevel5 = 0
				AND level4vlevel5 = 0
				THEN level5
			END lvl5
		,CASE 
			WHEN level5 < level6
				AND level1vlevel6 = 0
				AND level2vlevel6 = 0
				AND level3vlevel6 = 0
				AND level4vlevel6 = 0
				AND level5vlevel6 = 0
				THEN level6 end lvl6
		,CASE 
			WHEN level6 < level7
				AND level1vlevel7 = 0
				AND level2vlevel7 = 0
				AND level3vlevel7 = 0
				AND level4vlevel7 = 0
				AND level5vlevel7 = 0
				AND level6vlevel7 = 0
				THEN level7 end lvl7
			,CASE 
			WHEN level7 < level8
				AND level1vlevel8 = 0
				AND level2vlevel8 = 0
				AND level3vlevel8 = 0
				AND level4vlevel8 = 0
				AND level5vlevel8 = 0
				AND level6vlevel8 = 0
				THEN level8 end lvl8
			,CASE 
			WHEN level8 < level9
				AND level1vlevel9 = 0
				AND level2vlevel9 = 0
				AND level3vlevel9 = 0
				AND level4vlevel9 = 0
				AND level5vlevel9 = 0
				AND level6vlevel9 = 0
				AND level7vlevel9 = 0
				AND level8vlevel9 = 0
				THEN level9 end lvl9
	FROM [dbo].[StageLevelExplosion]
	WHERE type = 'check'
		AND level4 IS NOT NULL
		AND level5 IS NOT NULL
		AND level6 IS not NULL
		AND level7 IS not NULL
		AND level8 IS not NULL
		AND level9 IS not NULL
		AND level10 IS NULL)z)z


	insert into TotalingAccountTree
		
select LeafAccount,Level1,Level2,Level3,Level4,Level5 from(
	 select distinct 
		FROMVALUE LeafAccount
		, levels.Level1 Level1
		,Level2
		,Level3
		,Level4
		,Level5
		, case when level5 is not null and level4 is not null and level3 is not null and level2 is not null and level1 is not null then 5	
	when level5 is  null and level4 is not null and level3 is not null and level2 is not null and level1 is not null then 4	
	when level5 is  null and level4 is  null and level3 is not null and level2 is not null and level1 is not null then 3
	when level5 is  null and level4 is  null and level3 is  null and level2 is not null and level1 is not null then 2
	when level5 is  null and level4 is  null and level3 is  null and level2 is  null and level1 is not null then 1 else 0 end ct
	from(

	select[TOTALINGMAINACCOUNTID] MainAccountID, * from  [dbo].[vwtotalingAccountExplosion]
  where
  TOVALUE = FROMVALUE
  and COMPONENTMAINACCOUNTID = TOVALUE



		)z
		join #tempLevels levels on levels.Level1 = MAINACCOUNTID
join (
	select leafaccount,max(ct)  ct
	from (
	 select distinct 
		FROMVALUE LeafAccount
		, levels.Level1 Level1
		,Level2
		,Level3
		,Level4
		,Level5
		, case when level5 is not null and level4 is not null and level3 is not null and level2 is not null and level1 is not null then 5	
	when level5 is  null and level4 is not null and level3 is not null and level2 is not null and level1 is not null then 4	
	when level5 is  null and level4 is  null and level3 is not null and level2 is not null and level1 is not null then 3
	when level5 is  null and level4 is  null and level3 is  null and level2 is not null and level1 is not null then 2
	when level5 is  null and level4 is  null and level3 is  null and level2 is  null and level1 is not null then 1 else 0 end ct
	from(

	select[TOTALINGMAINACCOUNTID] MainAccountID, * from  [dbo].[vwtotalingAccountExplosion]
  where
  TOVALUE = FROMVALUE
  and COMPONENTMAINACCOUNTID = TOVALUE


		)z
		join #tempLevels levels on levels.Level1 = MAINACCOUNTID

	)z
	group by leafaccount)a on a.ct = case when level5 is not null and level4 is not null and level3 is not null and level2 is not null and level1 is not null then 5	
	when level5 is  null and level4 is not null and level3 is not null and level2 is not null and level1 is not null then 4	
	when level5 is  null and level4 is  null and level3 is not null and level2 is not null and level1 is not null then 3
	when level5 is  null and level4 is  null and level3 is  null and level2 is not null and level1 is not null then 2
	when level5 is  null and level4 is  null and level3 is  null and level2 is  null and level1 is not null then 1 else 0 end
	and a.LeafAccount = FROMVALUE

	)z
	where LeafAccount  in (
select distinct MainAccountNumber from DimAccount
where level5 is null)
		drop table #tempLevels

		--delete from TotalingAccountTree
		--where concat(LeafAccount,level1) = (
		--select concat(LeafAccount,lvl1) from(
		--select min(level1)lvl1,t.LeafAccount from TotalingAccountTree t
		--join (
		--select count(*)ct,LeafAccount from TotalingAccountTree
		--group by LeafAccount
		--having count(*)>1) z on z.LeafAccount = t.leafaccount
		--group by t.LeafAccount )r)

	--	delete from TotalingAccountTree
	--	where level1 is null

