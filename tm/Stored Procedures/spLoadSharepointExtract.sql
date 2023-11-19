-- =============================================
-- Author:      Yassir Elyamani
-- Create date: 05/06/2021
-- Description: This proc will load [TM].[SharepointExtract]
-- =============================================

CREATE PROCEDURE [tm].[spLoadSharepointExtract]
AS
begin

merge [TM].[SharepointExtract] Target
				Using(
						select distinct 
								rp.ResearchProjectId
								,rp.ionisTargetName as ProjectName
								,irt.GeneTarget
								,rp.FranchiseName as Franchise
								,ind.ResearchIndicationName as Indication
								,case WHEN rpsn.ResearchProjectStatusName IN ('Pre-Target Sanction','Pre-Candidate Selection') 
										THEN rpsn.ResearchProjectStatusName 
									  WHEN rpsn.ResearchProjectStatusName = 'Dropped from Research File' AND isnull(ext.CurrentStatus,'') in('','Pre-Target Sanction','Pre-Candidate Selection') 
										THEN rpsn.ResearchProjectStatusName 
									  WHEN rpsn.ResearchProjectStatusName = 'Biomarker Only' AND isnull(ext.CurrentStatus,'') = ''
										THEN rpsn.ResearchProjectStatusName 
								 ELSE ext.CurrentStatus end as CurrentStatus
								,rm.MilestoneDesc ResearchMilestone
								,case when isnull(rm.MilestoneEstDate,'') > '' 
										then CONCAT('<a href="',rsource.SourceExcelPath,'">',rm.MilestoneEstDate,'</a>')
										else null end ResearchEstMilestoneDate
								,stg.biomarker
								,bm.MilestoneDesc BiomarkerMilestone
								,case when isnull(bm.MilestoneEstDate,'') > '' 
										then CONCAT('<a href="',bsource.SourceExcelPath,'">',bm.MilestoneEstDate,'</a>')
										else null end BiomarkerEstMilestoneDate
								,case when stg.[Target] is null then 0 else 1 end as SyncToSP
								,HASHBYTES('SHA2_256',CONCAT(rp.ResearchProjectId
															,'|',irt.GeneTarget
															,'|',ind.ResearchIndicationName
															,'|',case WHEN rpsn.ResearchProjectStatusName IN ('Pre-Target Sanction','Pre-Candidate Selection') 
																		THEN rpsn.ResearchProjectStatusName 
																	  WHEN rpsn.ResearchProjectStatusName = 'Dropped from Research File' AND isnull(ext.CurrentStatus,'') in('','Pre-Target Sanction','Pre-Candidate Selection') 
																		THEN rpsn.ResearchProjectStatusName 
																	  WHEN rpsn.ResearchProjectStatusName = 'Biomarker Only' AND isnull(ext.CurrentStatus,'') = ''
																		THEN rpsn.ResearchProjectStatusName 
																 ELSE ext.CurrentStatus end
															,'|',rm.MilestoneDesc 
															,'|',case when isnull(rm.MilestoneEstDate,'') > '' 
																	then CONCAT('<a href="',rsource.SourceExcelPath,'">',rm.MilestoneEstDate,'</a>')
																	else null end	
															,'|',stg.biomarker
															,'|',bm.MilestoneDesc 
															,'|',case when isnull(bm.MilestoneEstDate,'') > '' 
																then CONCAT('<a href="',bsource.SourceExcelPath,'">',bm.MilestoneEstDate,'</a>')
																else null end	
															,'|',case when stg.[Target] is null then 0 else 1 end	)) as dbHashValue	
						--select count(1)                                    
						from tm.ResearchProject rp
						Inner join tm.IonisResearchTargets irt on rp.ResearchProjectId = irt.ResearchProjectId
						Left join tm.ResearchProjectResearchIndications ri on rp.ResearchProjectId = ri.ResearchProjectId
						left JOIN tm.ResearchIndications ind on ri.ResearchIndicationId = ind.ResearchIndicationId
						inner join tm.ResearchProjectStatus rps on rp.ResearchProjectId = rps.ResearchProjectId 
						inner join tm.ResearchProjectStatusNames rpsn on rps.ResearchProjectStatusNameId = rpsn.ResearchProjectStatusNameId
						Inner join (SELECT DISTINCT SourceExcelPath,SourceFile FROM tm.adfConfig) rsource on rsource.SourceFile = 'Research'
						Inner join (SELECT DISTINCT SourceExcelPath,SourceFile FROM tm.adfConfig) bsource on bsource.SourceFile = 'Biomarkers'
						Left join [tm].[vw_ResearchProjectCurrentMilestone] rm on rp.ResearchProjectId = rm.ResearchProjectId and rm.ResearchProjectMilestoneTypeName = 'Reseach'
						Left join [tm].[vw_ResearchProjectCurrentMilestone] bm on rp.ResearchProjectId = bm.ResearchProjectId and bm.ResearchProjectMilestoneTypeName = 'Biomarker'
						Left join tm.StgResearchData stg on rp.ionisTargetName = stg.[Target] and stg.Franchise = rp.FranchiseName
						Left join tm.SharepointExtract ext on rp.ionisTargetName = ext.ProjectName and ext.Franchise = rp.FranchiseName
						where 
							rps.IsCurrent = 1
						--and rp.ionisTargetName = 'ATXN7'
						) Source
				on target.ProjectName = source.ProjectName
				   and Target.Franchise = Source.Franchise
				When Matched and isnull(cast(target.dbHashValue as varchar(100)),'') <> isnull(cast(Source.dbHashValue as varchar(100)),'') 
				Then 
					update set 
					target.ResearchProjectId = source.ResearchProjectId
					,target.GeneTarget = source.GeneTarget
					,Target.Indication = source.Indication
					,target.CurrentStatus = source.CurrentStatus
					,target.ResearchMilestone = source.ResearchMilestone
					,target.ResearchEstMilestoneDate = source.ResearchEstMilestoneDate
					,target.Biomarker = source.Biomarker
					,target.BiomarkerMilestone = source.BiomarkerMilestone
					,target.BiomarkerEstMilestoneDate = source.BiomarkerEstMilestoneDate
					,target.dbHashValue = Source.dbHashValue
					,target.dbLastModifiedDate = getdate()
					,target.SyncToSP = source.SyncToSP
				 WHEN NOT MATCHED 
				 THEN  
				  INSERT 
					(
					ResearchProjectId
					,ProjectName
					,GeneTarget
					,Franchise
					,Indication
					,CurrentStatus
					,ResearchMilestone
					,ResearchEstMilestoneDate
					,Biomarker
					,BiomarkerMilestone
					,BiomarkerEstMilestoneDate
					,dbLastModifiedDate
					,dbHashValue
					,SyncToSP)
					Values(
					source.ResearchProjectId
					,source.ProjectName
					,source.GeneTarget
					,source.Franchise
					,source.Indication
					,source.CurrentStatus
					,source.ResearchMilestone
					,source.ResearchEstMilestoneDate
					,source.Biomarker
					,source.BiomarkerMilestone
					,source.BiomarkerEstMilestoneDate
					,Getdate()
					,source.dbHashValue
					,source.SyncToSP)
					;

					update ext
					set ext.SyncToSp = 0 
					--SELECT * 
					FROM [TM].[SharepointExtract] ext 
					left join tm.StgResearchData stg on ext.ProjectName = stg.Target and ext.Franchise = stg.Franchise
					WHERE ext.SyncToSp is null  and stg.Target is null 

				--Merge Bio Marker records into Research Records 
				update Rsch
				set Rsch.Biomarker = COALESCE(Rsch.Biomarker,bio.Biomarker)
				,Rsch.BiomarkerMilestone = COALESCE(Rsch.BiomarkerMilestone,bio.BiomarkerMilestone)
				,Rsch.BiomarkerEstMilestoneDate = COALESCE(Rsch.BiomarkerEstMilestoneDate,bio.BiomarkerEstMilestoneDate)
				,Rsch.TMMilestone = COALESCE(Rsch.TMMilestone,bio.TMMilestone)
				,Rsch.TMEstMilestoneDate = COALESCE(Rsch.TMEstMilestoneDate,bio.TMEstMilestoneDate)
				,Rsch.NextTMMilestone = COALESCE(Rsch.NextTMMilestone,bio.NextTMMilestone)
				,Rsch.NextTMEstMilestoneDate = COALESCE(Rsch.NextTMEstMilestoneDate,bio.NextTMEstMilestoneDate)
				,dbLastModifiedDate = getdate()
				--select * 
				from tm.SharepointExtract Rsch 
				inner join tm.IonisResearchTargets rt on Rsch.projectName = rt.IonisTargetName
				inner join tm.SharepointExtract bio on rt.GeneTarget = bio.ProjectName and rsch.franchise = bio.franchise
				where rsch.projectName <> bio.ProjectName
				and 
				(Rsch.Biomarker <> COALESCE(Rsch.Biomarker,bio.Biomarker)
					OR Rsch.BiomarkerMilestone <> COALESCE(Rsch.BiomarkerMilestone,bio.BiomarkerMilestone)
					OR Rsch.BiomarkerEstMilestoneDate <> COALESCE(Rsch.BiomarkerEstMilestoneDate,bio.BiomarkerEstMilestoneDate)
					OR Rsch.TMMilestone <> COALESCE(Rsch.TMMilestone,bio.TMMilestone)
					OR Rsch.TMEstMilestoneDate <> COALESCE(Rsch.TMEstMilestoneDate,bio.TMEstMilestoneDate)
					OR Rsch.NextTMMilestone <> COALESCE(Rsch.NextTMMilestone,bio.NextTMMilestone)
					OR Rsch.NextTMEstMilestoneDate <> COALESCE(Rsch.NextTMEstMilestoneDate,bio.NextTMEstMilestoneDate))

				update bio
				set SyncToSP = 0
				from tm.SharepointExtract Rsch 
				inner join tm.IonisResearchTargets rt on Rsch.projectName = rt.IonisTargetName
				inner join tm.SharepointExtract bio on rt.GeneTarget = bio.ProjectName and rsch.franchise = bio.franchise
				where rsch.projectName <> bio.ProjectName


End