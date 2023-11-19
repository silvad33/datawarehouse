
CREATE proc [dbo].[spTotalingAccountExplosion] 
as 



select [TOTALINGMAINACCOUNTID]
		,COMPONENTMAINACCOUNTID
		,AccountCount
		,level
	into #tempNew
	from(
SELECT DISTINCT vw.[TOTALINGMAINACCOUNTID]
	,COMPONENTMAINACCOUNTID
	,AccountCount
	,DENSE_RANK() OVER (
		PARTITION BY COMPONENTMAINACCOUNTID ORDER BY AccountCount,vw.[TOTALINGMAINACCOUNTID]
		) Level
FROM [dbo].[vwtotalingAccountExplosion] vw
JOIN (
	SELECT count(*) AccountCount
		,[TOTALINGMAINACCOUNTID]
	FROM (
		SELECT DISTINCT [TOTALINGMAINACCOUNTID]
			,COMPONENTMAINACCOUNTID
		FROM [dbo].[vwtotalingAccountExplosion]
		WHERE len(COMPONENTMAINACCOUNTID) = 4
		) DistinctAccounts
	GROUP BY [TOTALINGMAINACCOUNTID]
	) Counts ON counts.[TOTALINGMAINACCOUNTID] = vw.[TOTALINGMAINACCOUNTID]
WHERE len(COMPONENTMAINACCOUNTID) = 4

		)z


select * into #Temphold from(
select distinct * from (
		select * from #tempNew

		)z)z


select [TOTALINGMAINACCOUNTID]
		,COMPONENTMAINACCOUNTID
		,AccountCount
		,level
	Into #level1
	from #TempHold
		where level = 1



select [TOTALINGMAINACCOUNTID]
		,COMPONENTMAINACCOUNTID
		,AccountCount
		,level
	Into #level2
	from(select * from #TempHold
		)z
		where level = 2


select [TOTALINGMAINACCOUNTID]
		,COMPONENTMAINACCOUNTID
		,AccountCount
		,level
	Into #level3
	from(select * from #TempHold
		)z
		where level = 3

		
select [TOTALINGMAINACCOUNTID]
		,COMPONENTMAINACCOUNTID
		,AccountCount
		,level
	Into #level4
	from(select * from #TempHold
		)z
		where level = 4

		select [TOTALINGMAINACCOUNTID]
		,COMPONENTMAINACCOUNTID
		,AccountCount
		,level
	Into #level5
	from(select * from #TempHold
		)z
		where level = 5

		select [TOTALINGMAINACCOUNTID]
		,COMPONENTMAINACCOUNTID
		,AccountCount
		,level
	Into #level6
	from(select * from #TempHold
		)z
		where level = 6

		select [TOTALINGMAINACCOUNTID]
		,COMPONENTMAINACCOUNTID
		,AccountCount
		,level
	Into #level7
	from(select * from #TempHold
		)z
		where level = 7

		select [TOTALINGMAINACCOUNTID]
		,COMPONENTMAINACCOUNTID
		,AccountCount
		,level
	Into #level8
	from(select * from #TempHold
		)z
		where level = 8

		select [TOTALINGMAINACCOUNTID]
		,COMPONENTMAINACCOUNTID
		,AccountCount
		,level
	Into #level9
	from(select * from #TempHold
		)z
		where level = 9

		select [TOTALINGMAINACCOUNTID]
		,COMPONENTMAINACCOUNTID
		,AccountCount
		,level
	Into #level10
	from(select * from #TempHold
		)z
		where level = 10


truncate table StageLevelExplosion

insert into StageLevelExplosion(Level1,
			Level2,
			Level3,
			Level4,
			Level5,
			Level6,
			Level7,
			Level8,
			Level9,
			Level10,
			Type)
select distinct lvl1.TOTALINGMAINACCOUNTID Level1
			,lvl2.TOTALINGMAINACCOUNTID Level1
			,lvl3.TOTALINGMAINACCOUNTID Level1
			,lvl4.TOTALINGMAINACCOUNTID Level1
			,lvl5.TOTALINGMAINACCOUNTID Level1
			,lvl6.TOTALINGMAINACCOUNTID Level1
			,lvl7.TOTALINGMAINACCOUNTID Level1
			,lvl8.TOTALINGMAINACCOUNTID Level1
			,lvl9.TOTALINGMAINACCOUNTID Level1
			,lvl10.TOTALINGMAINACCOUNTID Level1
		--,case when lvl2.TOTALINGMAINACCOUNTID = lvl1.TOTALINGMAINACCOUNTID
		--	then null else lvl2.TOTALINGMAINACCOUNTID end  Level2
		--,case when lvl3.TOTALINGMAINACCOUNTID = lvl2.TOTALINGMAINACCOUNTID 
		--	then null 
		--	when lvl3.TOTALINGMAINACCOUNTID = lvl1.TOTALINGMAINACCOUNTID 
		--		then null 
		--			else lvl3.TOTALINGMAINACCOUNTID end Level3
		--,case when lvl4.TOTALINGMAINACCOUNTID = lvl3.TOTALINGMAINACCOUNTID 
		--		then null
		--	when lvl4.TOTALINGMAINACCOUNTID = lvl2.TOTALINGMAINACCOUNTID 
		--		then null 
		--	when lvl4.TOTALINGMAINACCOUNTID = lvl1.TOTALINGMAINACCOUNTID 
		--		then null else lvl4.TOTALINGMAINACCOUNTID end Level4
		--,case when lvl5.TOTALINGMAINACCOUNTID = lvl4.TOTALINGMAINACCOUNTID 
		--		then null
		--when lvl5.TOTALINGMAINACCOUNTID = lvl3.TOTALINGMAINACCOUNTID 
		--		then null
		--	when lvl5.TOTALINGMAINACCOUNTID = lvl2.TOTALINGMAINACCOUNTID 
		--		then null 
		--	when lvl5.TOTALINGMAINACCOUNTID = lvl1.TOTALINGMAINACCOUNTID 
		--		then null else lvl5.TOTALINGMAINACCOUNTID end Level5
		--,case when lvl6.TOTALINGMAINACCOUNTID = lvl5.TOTALINGMAINACCOUNTID 
		--		then null
		--when lvl6.TOTALINGMAINACCOUNTID = lvl4.TOTALINGMAINACCOUNTID 
		--		then null
		--when lvl6.TOTALINGMAINACCOUNTID = lvl3.TOTALINGMAINACCOUNTID 
		--		then null
		--	when lvl6.TOTALINGMAINACCOUNTID = lvl2.TOTALINGMAINACCOUNTID 
		--		then null 
		--	when lvl6.TOTALINGMAINACCOUNTID = lvl1.TOTALINGMAINACCOUNTID 
		--		then null else lvl6.TOTALINGMAINACCOUNTID end Level6
		--,case when lvl7.TOTALINGMAINACCOUNTID = lvl6.TOTALINGMAINACCOUNTID 
		--		then null
		--when lvl7.TOTALINGMAINACCOUNTID = lvl5.TOTALINGMAINACCOUNTID 
		--		then null
		--when lvl7.TOTALINGMAINACCOUNTID = lvl4.TOTALINGMAINACCOUNTID 
		--		then null
		--when lvl7.TOTALINGMAINACCOUNTID = lvl3.TOTALINGMAINACCOUNTID 
		--		then null
		--	when lvl7.TOTALINGMAINACCOUNTID = lvl2.TOTALINGMAINACCOUNTID 
		--		then null 
		--	when lvl7.TOTALINGMAINACCOUNTID = lvl1.TOTALINGMAINACCOUNTID 
		--		then null else lvl7.TOTALINGMAINACCOUNTID end Level7
		--,case when lvl8.TOTALINGMAINACCOUNTID = lvl7.TOTALINGMAINACCOUNTID 
		--		then null
		--when lvl8.TOTALINGMAINACCOUNTID = lvl6.TOTALINGMAINACCOUNTID 
		--		then null
		--when lvl8.TOTALINGMAINACCOUNTID = lvl5.TOTALINGMAINACCOUNTID 
		--		then null
		--when lvl8.TOTALINGMAINACCOUNTID = lvl4.TOTALINGMAINACCOUNTID 
		--		then null
		--when lvl8.TOTALINGMAINACCOUNTID = lvl3.TOTALINGMAINACCOUNTID 
		--		then null
		--	when lvl8.TOTALINGMAINACCOUNTID = lvl2.TOTALINGMAINACCOUNTID 
		--		then null 
		--	when lvl8.TOTALINGMAINACCOUNTID = lvl1.TOTALINGMAINACCOUNTID 
		--		then null else lvl8.TOTALINGMAINACCOUNTID end Level8
		--,case when lvl9.TOTALINGMAINACCOUNTID = lvl8.TOTALINGMAINACCOUNTID 
		--		then null
		--when lvl9.TOTALINGMAINACCOUNTID = lvl7.TOTALINGMAINACCOUNTID 
		--		then null
		--when lvl9.TOTALINGMAINACCOUNTID = lvl6.TOTALINGMAINACCOUNTID 
		--		then null
		--when lvl9.TOTALINGMAINACCOUNTID = lvl5.TOTALINGMAINACCOUNTID 
		--		then null
		--when lvl9.TOTALINGMAINACCOUNTID = lvl4.TOTALINGMAINACCOUNTID 
		--		then null
		--when lvl9.TOTALINGMAINACCOUNTID = lvl3.TOTALINGMAINACCOUNTID 
		--		then null
		--	when lvl9.TOTALINGMAINACCOUNTID = lvl2.TOTALINGMAINACCOUNTID 
		--		then null 
		--	when lvl9.TOTALINGMAINACCOUNTID = lvl1.TOTALINGMAINACCOUNTID 
		--		then null else lvl9.TOTALINGMAINACCOUNTID end Level9
		--,case when lvl10.TOTALINGMAINACCOUNTID = lvl9.TOTALINGMAINACCOUNTID 
		--		then null
		--when lvl10.TOTALINGMAINACCOUNTID = lvl8.TOTALINGMAINACCOUNTID 
		--		then null
		--when lvl10.TOTALINGMAINACCOUNTID = lvl7.TOTALINGMAINACCOUNTID 
		--		then null
		--when lvl10.TOTALINGMAINACCOUNTID = lvl6.TOTALINGMAINACCOUNTID 
		--		then null
		--when lvl10.TOTALINGMAINACCOUNTID = lvl5.TOTALINGMAINACCOUNTID 
		--		then null
		--when lvl10.TOTALINGMAINACCOUNTID = lvl4.TOTALINGMAINACCOUNTID 
		--		then null
		--when lvl10.TOTALINGMAINACCOUNTID = lvl3.TOTALINGMAINACCOUNTID 
		--		then null
		--	when lvl10.TOTALINGMAINACCOUNTID = lvl2.TOTALINGMAINACCOUNTID 
		--		then null 
		--	when lvl10.TOTALINGMAINACCOUNTID = lvl1.TOTALINGMAINACCOUNTID 
		--		then null else lvl10.TOTALINGMAINACCOUNTID end Level10
		,'Insert'
			--Into StageLevelExplosion
 from #level1 lvl1
	left join #level2 lvl2 on lvl1.COMPONENTMAINACCOUNTID = lvl2.COMPONENTMAINACCOUNTID
	left join #level3 lvl3 on lvl1.COMPONENTMAINACCOUNTID = lvl3.COMPONENTMAINACCOUNTID 
	left join #level4 lvl4 on lvl1.COMPONENTMAINACCOUNTID = lvl4.COMPONENTMAINACCOUNTID 
	left join #level5 lvl5 on lvl1.COMPONENTMAINACCOUNTID = lvl5.COMPONENTMAINACCOUNTID 
	left join #level6 lvl6 on lvl1.COMPONENTMAINACCOUNTID = lvl6.COMPONENTMAINACCOUNTID 
	left join #level7 lvl7 on lvl1.COMPONENTMAINACCOUNTID = lvl7.COMPONENTMAINACCOUNTID 
	left join #level8 lvl8 on lvl1.COMPONENTMAINACCOUNTID = lvl8.COMPONENTMAINACCOUNTID 
	left join #level9 lvl9 on lvl1.COMPONENTMAINACCOUNTID = lvl9.COMPONENTMAINACCOUNTID 
	left join #level10 lvl10 on lvl1.COMPONENTMAINACCOUNTID = lvl10.COMPONENTMAINACCOUNTID 
/*	
--truncate table StageTotalingAccountsOld
--insert into StageTotalingAccountsOld	
select distinct [TOTALINGMAINACCOUNTID]
		,COMPONENTMAINACCOUNTID
		,AccountCount
		,level
	from(
SELECT DISTINCT vw.[TOTALINGMAINACCOUNTID]
	,COMPONENTMAINACCOUNTID
	,AccountCount
	,DENSE_RANK() OVER (
		PARTITION BY COMPONENTMAINACCOUNTID ORDER BY AccountCount,vw.[TOTALINGMAINACCOUNTID]
		) Level
FROM [dbo].[vwtotalingAccountExplosion] vw
JOIN (
	SELECT count(*) AccountCount
		,[TOTALINGMAINACCOUNTID]
	FROM (
		SELECT DISTINCT [TOTALINGMAINACCOUNTID]
			,COMPONENTMAINACCOUNTID
		FROM [dbo].[vwtotalingAccountExplosion]
		WHERE len(COMPONENTMAINACCOUNTID) = 4
		) DistinctAccounts
	GROUP BY [TOTALINGMAINACCOUNTID]
	) Counts ON counts.[TOTALINGMAINACCOUNTID] = vw.[TOTALINGMAINACCOUNTID]
WHERE len(COMPONENTMAINACCOUNTID) = 4

		)z
		
*/


drop table #level1
drop table #level2
drop table #level3
drop table #level4
drop table #level5
drop table #level6
drop table #level7
drop table #level8
drop table #level9
drop table #level10
drop table #TempHold
drop table #tempNew



