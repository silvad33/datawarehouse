CREATE proc [dbo].[spTotalAccountsCheck] as DECLARE @Level1 VARCHAR(20) 

TRUNCATE TABLE TotalingAccountExplosion
INSERT INTO TotalingAccountExplosion
SELECT *  FROM [dbo].[vwTotalingAccountExplosion]

DECLARE @Level2 VARCHAR(20) 
DECLARE @Level3 VARCHAR(20) 
DECLARE @Level4 VARCHAR(20) 
DECLARE @Level5 VARCHAR(20) 
DECLARE @Level6 VARCHAR(20) 
DECLARE @Level7 VARCHAR(20) 
DECLARE @Level8 VARCHAR(20) 
DECLARE @Level9 VARCHAR(20) 
DECLARE @Level10 VARCHAR(20) 

DECLARE Level1 CURSOR FOR 

  SELECT distinct [Level1]
  FROM [dbo].[StageLevelExplosion]
	where type = 'insert'

OPEN Level1  
FETCH NEXT FROM Level1 INTO @Level1  

WHILE @@FETCH_STATUS = 0  
BEGIN  

set @Level2 = (select top 1 level2 from [dbo].[StageLevelExplosion] where type = 'insert' and level1 = @Level1)
set @Level3 = (select top 1 level3 from [dbo].[StageLevelExplosion] where type = 'insert' and level1 = @Level1)
set @Level4 = (select top 1 level4 from [dbo].[StageLevelExplosion] where type = 'insert' and level1 = @Level1)
set @Level5 = (select top 1 level5 from [dbo].[StageLevelExplosion] where type = 'insert' and level1 = @Level1)
set @Level6 = (select top 1 level6 from [dbo].[StageLevelExplosion] where type = 'insert' and level1 = @Level1)
set @Level7 = (select top 1 level7 from [dbo].[StageLevelExplosion] where type = 'insert' and level1 = @Level1)
set @Level8 = (select top 1 level8 from [dbo].[StageLevelExplosion] where type = 'insert' and level1 = @Level1)
set @Level9 = (select top 1 level9 from [dbo].[StageLevelExplosion] where type = 'insert' and level1 = @Level1)
set @Level10 = (select top 1 level10 from [dbo].[StageLevelExplosion] where type = 'insert' and level1 = @Level1)

		insert into [dbo].[StageLevelExplosion] (
		level1,
		level2,
		level3,
		level4,
		level5,
		level6,
		level7,
		level8,
		level9,
		level10
		,[Level1vLevel2]
      ,[Level1vLevel3]
      ,[Level1vLevel4]
      ,[Level1vLevel5]
      ,[Level1vLevel6]
      ,[Level1vLevel7]
      ,[Level1vLevel8]
      ,[Level1vLevel9]
      ,[Level1vLevel10]
      ,[Level2vLevel3]
      ,[Level2vLevel4]
      ,[Level2vLevel5]
      ,[Level2vLevel6]
      ,[Level2vLevel7]
      ,[Level2vLevel8]
      ,[Level2vLevel9]
      ,[Level2vLevel10]
      ,[Level3vLevel4]
      ,[Level3vLevel5]
      ,[Level3vLevel6]
      ,[Level3vLevel7]
      ,[Level3vLevel8]
      ,[Level3vLevel9]
      ,[Level3vLevel10]
      ,[Level4vLevel5]
      ,[Level4vLevel6]
      ,[Level4vLevel7]
      ,[Level4vLevel8]
      ,[Level4vLevel9]
      ,[Level4vLevel10]
      ,[Level5vLevel6]
      ,[Level5vLevel7]
      ,[Level5vLevel8]
      ,[Level5vLevel9]
      ,[Level5vLevel10]
      ,[Level6vLevel7]
      ,[Level6vLevel8]
      ,[Level6vLevel9]
      ,[Level6vLevel10]
      ,[Level7vLevel8]
      ,[Level7vLevel9]
      ,[Level7vLevel10]
      ,[Level8vLevel9]
      ,[Level8vLevel10]
      ,[Level9vLevel10]
      ,[Type])


   select level1,level2,level3,level4,level5,level6,level7,level8,level9,level10,
   (select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level1 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level2 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e) lvl1v2,

	(select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level1 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level3 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e),

	(select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level1 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level4 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e),

	(select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level1 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level5 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e),

	(select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level1 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level6 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e),

	(select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level1 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level7 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e),

	(select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level1 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level8 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e),

	(select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level1 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level9 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e),

	(select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level1 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level10 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e),

	(select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level2 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level3 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e),

	(select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level2 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level4 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e),

	(select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level2 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level5 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e),

	(select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level2 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level6 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e),

	(select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level2 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level7 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e),

	(select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level2 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level8 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e),

	(select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level2 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level9 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e),

	(select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level2 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level10 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e),

	(select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level3 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level4 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e),

	(select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level3 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level5 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e),

	(select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level3 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level6 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e),

	(select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level3 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level7 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e),

	(select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level3 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level8 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e),

	(select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level3 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level9 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e),

	(select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level3 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level10 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e),

	(select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level4 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level5 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e),

	(select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level4 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level6 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e),

	(select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level4 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level7 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e),

	(select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level4 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level8 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e),

	(select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level4 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level9 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e),

	(select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level4 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level10 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e),

	(select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level5 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level6 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e),

	(select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level5 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level7 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e),

	(select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level5 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level8 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e),

	(select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level5 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level9 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e),

	(select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level5 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level10 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e),

	(select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level6 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level7 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e),

	(select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level6 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level8 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e),

	(select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level6 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level9 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e),

	(select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level6 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level10 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e),

	(select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level7 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level8 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e),

	(select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level7 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level9 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e),

	(select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level7 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level10 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e),

	(select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level8 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level9 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e),

	(select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level8 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level10 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e),

	(select count(*) from (
	  SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @Level9 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4
		
	except 

	SELECT [COMPONENTMAINACCOUNTID]
	  FROM [dbo].[TotalingAccountExplosion]
			where @level10 = TOTALINGMAINACCOUNTID
			and len([COMPONENTMAINACCOUNTID]) = 4) e)
			,'Check'


		from [dbo].[StageLevelExplosion]
			where @Level1 = level1
			and type = 'insert'

      FETCH NEXT FROM Level1 INTO @Level1 
END 

CLOSE Level1  
DEALLOCATE Level1 

