CREATE  PROCEDURE [tm].[spPostStgTransform]
AS
BEGIN

--Try to find new matches 
    drop table if exists #GeneMapping

    select distinct ts.Target, gt.PrimarySymbol 
    into #GeneMapping
    from [tm].[StgResearchData] ts 
    inner join [research].[GeneTerms] gt on trim(ts.Target) = trim(gt.PrimarySymbol)
    left join tm.stgTargetSymbolMapping m on ts.Target = m.ResearchTarget
    where m.ResearchTarget is null 

    --Missing
    insert into #GeneMapping
    select distinct ts.Target,  gt.PrimarySymbol 
    from [tm].[StgResearchData] ts 
    Left join #GeneMapping gm on ts.Target = gm.target
    Inner join [research].[GeneTerms] gt on trim(substring(ts.Target,1, charindex(' (',ts.Target,1))) = trim(gt.PrimarySymbol)
    left join tm.stgTargetSymbolMapping m on ts.Target = m.ResearchTarget
    where gm.PrimarySymbol is null 
    and  m.ResearchTarget is null 
    and ts.Target like '% (%'

    insert into tm.stgTargetSymbolMapping 
    select distinct gm.Target,  gm.PrimarySymbol 
    from  #GeneMapping gm 
    where gm.PrimarySymbol is not null

    drop table if exists #GeneMapping


    --Translate dates

    update tm.StgNeuroCandidateSelection
    set [DC ID Deadline for BIIB#6] = cast(CAST([DC ID Deadline for BIIB#6] - 2 as datetime) as date)
    where [DC ID Deadline for BIIB#6] > '' 
	and isnumeric([DC ID Deadline for BIIB#6]) = 1

    update tm.StgBiomarkersData
    set [Date requested] = cast(CAST([Date requested] - 2 as datetime) as date)
    where [Date requested] > '' 
	and isnumeric([Date requested]) = 1

    update tm.StgBiomarkersData
    set [When desired] = cast(CAST([When desired] - 2 as datetime) as date)
    where [When desired] > '' 
	and isnumeric([When desired]) = 1

    update tm.StgBiomarkersData
    set [Expected projection completion] = cast(CAST([Expected projection completion] - 2 as datetime) as date)
    where [Expected projection completion] > '' 
	and isnumeric([Expected projection completion] ) = 1

	--update GeneTarget from sharepoint when different
	update rt 
	set rt.GeneTarget= ext.GeneTarget
	--SELECT ext.ProjectName, ext.GeneTarget,ext.Franchise, rt.GeneTarget
	FROM [TM].[SharepointExtract] EXT
	INNER JOIN TM.ResearchProject RP ON ext.ProjectName = rp.ionisTargetName and ext.Franchise = rp.FranchiseName
	inner join [TM].[IonisResearchTargets] rt on rp.ResearchProjectId = rt.ResearchProjectId
	WHERE EXT.ProjectName IN (
	select ProjectName 
	from [TM].[SharepointExtract] 
	where ProjectName > '' and GeneTarget > '' AND Franchise > ''
	group by ProjectName 
	having count(1) = 1)
	AND EXT.ProjectName > '' and ext.GeneTarget > '' AND Franchise > ''
	and ext.GeneTarget > ''
	and isnull(rt.GeneTarget,'') <> isnull(ext.GeneTarget,'')	

 END
  