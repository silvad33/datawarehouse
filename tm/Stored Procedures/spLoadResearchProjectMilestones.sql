-- =============================================
-- Author:      Yassir Elyamani
-- Create date: 04/29/2021
-- Description: This proc will load ResearchProjectMilestones with type 2 updates
-- =============================================
CREATE  PROCEDURE [TM].[spLoadResearchProjectMilestones]
as 
BEGIN
drop table if exists #ResearchProjectMilestones_Updates
CREATE TABLE #ResearchProjectMilestones_Updates(
	Action varchar(50) null,
	[ResearchProjectMilestoneTypeId] [int] NOT NULL,
	[ResearchProjectId] [int] NULL,
	[MilestoneDesc] [varchar](255) NULL,
	[MilestoneEstDate] [varchar](255) NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[IsCurrent] [bit] NOT NULL,
	[CreatedBy] [varchar](100) NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [varchar](100) NULL,
	[LastModifiedDate] [datetime] NULL)


	Merge into tm.ResearchProjectMilestones 
	as Target 
	Using(
		select ResearchProjectMilestoneTypeId,rp.ResearchProjectId,ResearchMilestone as MilestoneDesc,ResearchEstMilestoneDate as MilestoneEstDate
			,Getdate() as StartDate ,'12-12-9999' EndDate ,1 IsCurrent ,SYSTEM_USER  CreatedBy	,GETDATE() CreatedDate,SYSTEM_USER LastModifiedBy,GETDATE() LastModifiedDate
		from tm.StgResearchData stg 
		inner join tm.ResearchProject rp on stg.Target = rp.ionisTargetName and stg.Franchise = rp.FranchiseName
		Inner join tm.ResearchProjectMilestoneType rpmt on rpmt.ResearchProjectMilestoneTypeName = 'Reseach'
		where ResearchMilestone is not null or ResearchEstMilestoneDate is not null
		union
		select ResearchProjectMilestoneTypeId,rp.ResearchProjectId,BiomarkerMilestone,BiomarkerEstMilestoneDate
			,Getdate() as StartDate ,'12-12-9999' EndDate ,1 IsCurrent ,SYSTEM_USER  CreatedBy	,GETDATE() CreatedDate,SYSTEM_USER LastModifiedBy,GETDATE() LastModifiedDate
		from tm.StgResearchData stg 
		inner join tm.ResearchProject rp on stg.Target = rp.ionisTargetName and stg.Franchise = rp.FranchiseName
		Inner join tm.ResearchProjectMilestoneType rpmt on rpmt.ResearchProjectMilestoneTypeName = 'Biomarker'
		where BiomarkerMilestone is not null or BiomarkerEstMilestoneDate is not null
		-- union
		-- select ResearchProjectMilestoneTypeId,rp.ResearchProjectId,PcddMilestone,PCddMilestoneDate
		-- 	,Getdate() as StartDate ,'12-12-9999' EndDate ,1 IsCurrent ,SYSTEM_USER  CreatedBy	,GETDATE() CreatedDate,SYSTEM_USER LastModifiedBy,GETDATE() LastModifiedDate
		-- from tm.StgResearchData stg 
		-- inner join tm.ResearchProject rp on stg.Target = rp.ionisTargetName and stg.Franchise = rp.FranchiseName
		-- Inner join tm.ResearchProjectMilestoneType rpmt on rpmt.ResearchProjectMilestoneTypeName = 'PCDD'
		-- where PcddMilestone is not null or PCddMilestoneDate is not null
        )
			as Source

		on (source.ResearchProjectId = target.ResearchProjectId and source.ResearchProjectMilestoneTypeId= target.ResearchProjectMilestoneTypeId)

		WHEN MATCHED and (isnull(target.MilestoneEstDate,'') <> isnull(source.MilestoneEstDate, '') or isnull(Target.MilestoneDesc,'') <> isnull(Source.MilestoneDesc,''))
					 and target.isCurrent=1
	 THEN 
	  UPDATE SET 
		EndDate=getdate(), 
		IsCurrent=0, 
		LastModifiedDate=getdate(), 
		LastModifiedBy=system_user
	 WHEN NOT MATCHED 
	 THEN  
	  INSERT 
	  (ResearchProjectMilestoneTypeId
		,ResearchProjectId
		,MilestoneDesc
		,MilestoneEstDate
		,StartDate
		,EndDate
		,IsCurrent
		,CreatedBy
		,CreatedDate
		,LastModifiedBy
		,LastModifiedDate)
		Values
		(Source.ResearchProjectMilestoneTypeId
		,Source.ResearchProjectId
		,Source.MilestoneDesc
		,Source.MilestoneEstDate
		,Source.StartDate
		,Source.EndDate
		,Source.IsCurrent
		,Source.CreatedBy
		,Source.CreatedDate
		,Source.LastModifiedBy
		,Source.LastModifiedDate 
		)
	OUTPUT $action
		, Source.ResearchProjectMilestoneTypeId
		,Source.ResearchProjectId
		,Source.MilestoneDesc
		,Source.MilestoneEstDate
		,Source.StartDate
		,Source.EndDate
		,Source.IsCurrent
		,Source.CreatedBy
		,Source.CreatedDate
		,Source.LastModifiedBy
		,Source.LastModifiedDate into #ResearchProjectMilestones_Updates ;	


		insert into tm.ResearchProjectMilestones 
		 (ResearchProjectMilestoneTypeId
		,ResearchProjectId
		,MilestoneDesc
		,MilestoneEstDate
		,StartDate
		,EndDate
		,IsCurrent
		,CreatedBy
		,CreatedDate
		,LastModifiedBy
		,LastModifiedDate)
		select  ResearchProjectMilestoneTypeId
		,ResearchProjectId
		,MilestoneDesc
		,MilestoneEstDate
		,StartDate
		,EndDate
		,IsCurrent
		,CreatedBy
		,CreatedDate
		,LastModifiedBy
		,LastModifiedDate
		from #ResearchProjectMilestones_Updates
		where action = 'UPDATE'

drop table if exists #ResearchProjectMilestones_Updates

--Close Research miletones for prjects dropped from research file 
update trg
	set trg.EndDate=getdate(), 
		trg.IsCurrent=0, 
		trg.LastModifiedDate=getdate(), 
		trg.LastModifiedBy=system_user
--select *
from tm.ResearchProject rp
	inner join tm.ResearchProjectStatus rps on rp.ResearchProjectId = rps.ResearchProjectId 
	inner join tm.ResearchProjectStatusNames rpsn on rps.ResearchProjectStatusNameId = rpsn.ResearchProjectStatusNameId
	inner join tm.ResearchProjectMilestones trg on rp.ResearchProjectId = trg.ResearchProjectId
	Inner join tm.ResearchProjectMilestoneType rpmt on rpmt.ResearchProjectMilestoneTypeId = trg.ResearchProjectMilestoneTypeId
where rpsn.ResearchProjectStatusName = 'Dropped from Research File'
	and rpmt.ResearchProjectMilestoneTypeName = 'Reseach'
	and trg.IsCurrent = 1

--Close Biomarker miletones for prjects dropped from research file and bioamrkers
update trg
	set trg.EndDate=getdate(), 
		trg.IsCurrent=0, 
		trg.LastModifiedDate=getdate(), 
		trg.LastModifiedBy=system_user
--select trg.*
from tm.ResearchProject rp
	inner join tm.ResearchProjectStatus rps on rp.ResearchProjectId = rps.ResearchProjectId 
	inner join tm.ResearchProjectStatusNames rpsn on rps.ResearchProjectStatusNameId = rpsn.ResearchProjectStatusNameId
	inner join tm.ResearchProjectMilestones trg on rp.ResearchProjectId = trg.ResearchProjectId
	inner join tm.ResearchProjectStatus rpsbio on rp.ResearchProjectId = rpsbio.ResearchProjectId 
	inner join tm.ResearchProjectStatusNames rpsnbio on rpsbio.ResearchProjectStatusNameId = rpsnbio.ResearchProjectStatusNameId
	Inner join tm.ResearchProjectMilestoneType rpmt on rpmt.ResearchProjectMilestoneTypeId = trg.ResearchProjectMilestoneTypeId
where rpsn.ResearchProjectStatusName = 'Dropped from Research File'
	and rpsnbio.ResearchProjectStatusName = 'Biomarker Only'	
	and rpmt.ResearchProjectMilestoneTypeName = 'Biomarker'
	and trg.IsCurrent = 1

--Close Biomarker miletones for prjects dropped from biomarkers 
update trg
	set trg.EndDate=getdate(), 
		trg.IsCurrent=0, 
		trg.LastModifiedDate=getdate(), 
		trg.LastModifiedBy=system_user
--select *
from tm.ResearchProject rp
	inner join tm.ResearchProjectStatus rps on rp.ResearchProjectId = rps.ResearchProjectId 
	inner join tm.ResearchProjectStatusNames rpsn on rps.ResearchProjectStatusNameId = rpsn.ResearchProjectStatusNameId
	inner join tm.ResearchProjectMilestones trg on rp.ResearchProjectId = trg.ResearchProjectId
	Inner join tm.ResearchProjectMilestoneType rpmt on rpmt.ResearchProjectMilestoneTypeId = trg.ResearchProjectMilestoneTypeId
	left join tm.IonisResearchTargets gt on rp.ResearchProjectId = gt.ResearchProjectId
	Left join tm.StgResearchData stg on coalesce(gt.GeneTarget,rp.ionisTargetName) = stg.target and rp.FranchiseName = stg.Franchise --and stg.CurrentStatus = 'Biomarker Only'	
	Left join tm.StgResearchData stg2 on coalesce(rp.ionisTargetName,gt.GeneTarget) = stg2.target and rp.FranchiseName = stg2.Franchise --and stg.CurrentStatus = 'Biomarker Only'	
where rpmt.ResearchProjectMilestoneTypeName = 'Biomarker'
	and trg.IsCurrent = 1
	and( stg.target is null and stg2.target is null )

--Close Biomarker miletones for projects dropped from biomarkers but not from research
update trg
	set trg.EndDate=getdate(), 
		trg.IsCurrent=0, 
		trg.LastModifiedDate=getdate(), 
		trg.LastModifiedBy=system_user
--select *
from tm.ResearchProject rp
	inner join tm.ResearchProjectStatus rps on rp.ResearchProjectId = rps.ResearchProjectId 
	inner join tm.ResearchProjectStatusNames rpsn on rps.ResearchProjectStatusNameId = rpsn.ResearchProjectStatusNameId
	inner join tm.ResearchProjectMilestones trg on rp.ResearchProjectId = trg.ResearchProjectId
	Inner join tm.ResearchProjectMilestoneType rpmt on rpmt.ResearchProjectMilestoneTypeId = trg.ResearchProjectMilestoneTypeId
	Inner join tm.IonisResearchTargets gt on rp.ResearchProjectId = gt.ResearchProjectId
	inner join tm.StgResearchData stg on coalesce(gt.GeneTarget,rp.ionisTargetName) = stg.target and rp.FranchiseName = stg.Franchise --and stg.CurrentStatus = 'Biomarker Only'	
where rpmt.ResearchProjectMilestoneTypeName = 'Biomarker'
	and trg.IsCurrent = 1
	and stg.BiomarkerMilestone is null 
End
 