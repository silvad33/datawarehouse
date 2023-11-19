
/* =============================================
-- Author:      Yassir Elyamani
-- Create date: 04/27/2021
-- Description: This proc will load data from stg view into StgResearchData table

Change Date    Changed by       Description
05/04/2021     Yassir E         Changed to use [adfConfig] table
05/06/2021	   Yassir E			Added Biomarker field
-- =============================================*/
CREATE  PROCEDURE [TM].[spLoadStgResearchData]
AS
BEGIN

Truncate table [TM].[StgResearchData]

insert into [TM].[StgResearchData]
(Target ,
Franchise ,
Indication ,
CurrentStatus ,
ResearchMilestone ,
ResearchEstMilestoneDate ,
Biomarker,
BiomarkerMilestone  ,
BiomarkerEstMilestoneDate  ,
SourceFile ) 
SELECT  trim(rsc.Target) as [TARGET]
        ,Conf.FranchiseName as Franchise
        ,rsc.Indication
        ,Conf.CurrentStatus as CurrentStatus
        ,Conf.ResearchMilestone as ResearchMilestone
        , rsc.[Earliest CS Date] as ResearchEstMilestoneDate
		,isnull(bio.Biomarker, bio2.Biomarker) as Biomarker
		,[tm].[fnBiomarkerMilestone](COALESCE(bio.[Method Validation],bio2.[Method Validation])
									,COALESCE(bio.[Method Development],bio2.[Method Development])
									,COALESCE(bio.[Reagent Procurement],bio2.[Reagent Procurement])
									,COALESCE(bio.[Contract],bio2.[Contract])
									,COALESCE(bio.[Bidding],bio2.[Bidding])) as BiomarkerMilestone
        ,COALESCE(bio.[Expected projection completion],bio2.[Expected projection completion]) as BiomarkerEstMilestoneDate
		,Conf.SourceFile
from tm.StgNeuroCandidateSelection rsc
	inner join [TM].[adfConfig] conf on conf.TargetTable = 'StgNeuroCandidateSelection'
    left join tm.StgBiomarkersData bio on trim(rsc.[Target]) = trim(bio.[Target]) AND bio.Franchise ='Neuro' and  bio.[Context of Use] = 'Direct Target Engagement' and bio.[True/False]= 'True'
	left join [TM].[IonisResearchTargets] mp on rsc.Target = mp.IonisTargetName
    left join tm.StgBiomarkersData bio2 on trim(mp.GeneTarget) = trim(bio2.[Target]) and bio2.Franchise ='Neuro' and  bio2.[Context of Use] = 'Direct Target Engagement' and bio2.[True/False]= 'True'
where isnull(rsc.[Target],'')> ''    

UNION
SELECT  trim(rsc.Target) as [TARGET]
        ,Conf.FranchiseName as Franchise
        ,rsc.Indication
        ,Conf.CurrentStatus as CurrentStatus
        ,Conf.ResearchMilestone as ResearchMilestone
		, rsc.[Earliest TS Date] as ResearchEstMilestoneDate
		,isnull(bio.Biomarker, bio2.Biomarker) as Biomarker
		,[tm].[fnBiomarkerMilestone](COALESCE(bio.[Method Validation],bio2.[Method Validation])
									,COALESCE(bio.[Method Development],bio2.[Method Development])
									,COALESCE(bio.[Reagent Procurement],bio2.[Reagent Procurement])
									,COALESCE(bio.[Contract],bio2.[Contract])
									,COALESCE(bio.[Bidding],bio2.[Bidding])) as BiomarkerMilestone
        ,COALESCE(bio.[Expected projection completion],bio2.[Expected projection completion]) as BiomarkerEstMilestoneDate
		,conf.SourceFile
from tm.StgNeuroTargetValidation rsc
	inner join [TM].[adfConfig] conf on conf.TargetTable = 'StgNeuroTargetValidation'
    left join tm.StgBiomarkersData bio on trim(rsc.[Target]) = trim(bio.[Target]) and bio.Franchise ='Neuro' and bio.[Context of Use] = 'Direct Target Engagement' and bio.[True/False]= 'True'
	left join [TM].[IonisResearchTargets] mp on rsc.Target = mp.IonisTargetName
    left join tm.StgBiomarkersData bio2 on trim(mp.GeneTarget)  = trim(bio2.[Target]) and bio2.Franchise ='Neuro' and  bio2.[Context of Use] = 'Direct Target Engagement' and bio2.[True/False]= 'True'
where isnull(rsc.[Target],'')> ''    
UNION
--Cardiovascular
SELECT  trim(rsc.Target) as [TARGET]
        ,Conf.FranchiseName as Franchise
        ,rsc.Indication
        ,Conf.CurrentStatus as CurrentStatus
        ,Conf.ResearchMilestone as ResearchMilestone
        , rsc.[Earliest CS Date] as ResearchEstMilestoneDate
		,isnull(bio.Biomarker, bio2.Biomarker) as Biomarker
		,[tm].[fnBiomarkerMilestone](COALESCE(bio.[Method Validation],bio2.[Method Validation])
									,COALESCE(bio.[Method Development],bio2.[Method Development])
									,COALESCE(bio.[Reagent Procurement],bio2.[Reagent Procurement])
									,COALESCE(bio.[Contract],bio2.[Contract])
									,COALESCE(bio.[Bidding],bio2.[Bidding])) as BiomarkerMilestone
        ,COALESCE(bio.[Expected projection completion],bio2.[Expected projection completion]) as BiomarkerEstMilestoneDate
		,conf.SourceFile
from tm.StgCVRCandidateSelection rsc
	inner join [TM].[adfConfig] conf on conf.TargetTable = 'StgCVRCandidateSelection'
    left join tm.StgBiomarkersData bio on trim(rsc.[Target]) = trim(bio.[Target]) and bio.Franchise ='Cardio-Renal' and  bio.[Context of Use] = 'Direct Target Engagement' and bio.[True/False]= 'True'
	left join [TM].[IonisResearchTargets] mp on rsc.Target = mp.IonisTargetName
    left join tm.StgBiomarkersData bio2 on trim(mp.GeneTarget)  = trim(bio2.[Target]) and bio2.Franchise ='Cardio-Renal' and  bio2.[Context of Use] = 'Direct Target Engagement' and bio2.[True/False]= 'True'
where isnull(rsc.[Target],'')> ''    
UNION
SELECT  trim(rsc.Target) as [TARGET]
        ,Conf.FranchiseName as Franchise
        ,rsc.Indication
        ,Conf.CurrentStatus as CurrentStatus
        ,Conf.ResearchMilestone as ResearchMilestone
        , rsc.[Earliest TS Date] as ResearchEstMilestoneDate
		,isnull(bio.Biomarker, bio2.Biomarker) as Biomarker
		,[tm].[fnBiomarkerMilestone](COALESCE(bio.[Method Validation],bio2.[Method Validation])
									,COALESCE(bio.[Method Development],bio2.[Method Development])
									,COALESCE(bio.[Reagent Procurement],bio2.[Reagent Procurement])
									,COALESCE(bio.[Contract],bio2.[Contract])
									,COALESCE(bio.[Bidding],bio2.[Bidding])) as BiomarkerMilestone
		,COALESCE(bio.[Expected projection completion],bio2.[Expected projection completion]) as BiomarkerEstMilestoneDate
		,conf.SourceFile
from [TM].[StgCVRTargetValidation]  rsc
	inner join [TM].[adfConfig] conf on conf.TargetTable = 'StgCVRTargetValidation'
    left join tm.StgBiomarkersData bio on trim(rsc.[Target]) = trim(bio.[Target]) and bio.Franchise ='Cardio-Renal' and  bio.[Context of Use] = 'Direct Target Engagement' and bio.[True/False]= 'True'
	left join [TM].[IonisResearchTargets] mp on rsc.Target = mp.IonisTargetName
    left join tm.StgBiomarkersData bio2 on trim(mp.GeneTarget)  = trim(bio2.[Target]) and bio2.Franchise ='Cardio-Renal' and  bio2.[Context of Use] = 'Direct Target Engagement' and bio2.[True/False]= 'True'
where isnull(rsc.[Target],'')> ''    
UNION
--Metabolics
SELECT  trim(rsc.Target) as [TARGET]
        ,Conf.FranchiseName as Franchise
        ,rsc.Indication
        ,Conf.CurrentStatus as CurrentStatus
        ,Conf.ResearchMilestone as ResearchMilestone
        , rsc.[Earliest CS Date] as ResearchEstMilestoneDate
		,isnull(bio.Biomarker, bio2.Biomarker) as Biomarker
		,[tm].[fnBiomarkerMilestone](COALESCE(bio.[Method Validation],bio2.[Method Validation])
									,COALESCE(bio.[Method Development],bio2.[Method Development])
									,COALESCE(bio.[Reagent Procurement],bio2.[Reagent Procurement])
									,COALESCE(bio.[Contract],bio2.[Contract])
									,COALESCE(bio.[Bidding],bio2.[Bidding])) as BiomarkerMilestone
		,COALESCE(bio.[Expected projection completion],bio2.[Expected projection completion]) as BiomarkerEstMilestoneDate
		,conf.SourceFile
from [TM].[StgMetabolicDCSelection] rsc
	inner join [TM].[adfConfig] conf on conf.TargetTable = 'StgMetabolicDCSelection'
    left join tm.StgBiomarkersData bio on trim(rsc.[Target]) = trim(bio.[Target]) and bio.Franchise ='Metabolic & Liver Disease' and  bio.[Context of Use] = 'Direct Target Engagement' and bio.[True/False]= 'True'
	left join [TM].[IonisResearchTargets] mp on rsc.Target = mp.IonisTargetName
    left join tm.StgBiomarkersData bio2 on trim(mp.GeneTarget) = trim(bio2.[Target]) and bio2.Franchise ='Metabolic & Liver Disease' and  bio2.[Context of Use] = 'Direct Target Engagement' and bio2.[True/False]= 'True'
where isnull(rsc.[Target],'')> ''    
UNION
SELECT  trim(rsc.Target) as [TARGET]
        ,Conf.FranchiseName as Franchise
        ,rsc.Indication
        ,Conf.CurrentStatus as CurrentStatus
        ,Conf.ResearchMilestone as ResearchMilestone
        , rsc.[Earliest TS Date] as ResearchEstMilestoneDate
		,isnull(bio.Biomarker, bio2.Biomarker) as Biomarker
		,[tm].[fnBiomarkerMilestone](COALESCE(bio.[Method Validation],bio2.[Method Validation])
									,COALESCE(bio.[Method Development],bio2.[Method Development])
									,COALESCE(bio.[Reagent Procurement],bio2.[Reagent Procurement])
									,COALESCE(bio.[Contract],bio2.[Contract])
									,COALESCE(bio.[Bidding],bio2.[Bidding])) as BiomarkerMilestone
        ,COALESCE(bio.[Expected projection completion],bio2.[Expected projection completion]) as BiomarkerEstMilestoneDate
		,conf.SourceFile
from [TM].[StgMetabolicTargetValidation] rsc
	inner join [TM].[adfConfig] conf on conf.TargetTable = 'StgMetabolicTargetValidation'
    left join tm.StgBiomarkersData bio on trim(rsc.[Target]) = trim(bio.[Target]) and bio.Franchise ='Metabolic & Liver Disease'and bio.[Context of Use] = 'Direct Target Engagement' and bio.[True/False]= 'True'
	left join [TM].[IonisResearchTargets] mp on rsc.Target = mp.IonisTargetName
    left join tm.StgBiomarkersData bio2 on trim(mp.GeneTarget) = trim(bio2.[Target]) and bio2.Franchise ='Metabolic & Liver Disease' and  bio2.[Context of Use] = 'Direct Target Engagement' and bio2.[True/False]= 'True'
where isnull(rsc.[Target],'')> ''    
UNION
--Pulmonary
SELECT  trim(rsc.Target) as [TARGET]
        ,Conf.FranchiseName as Franchise
        ,rsc.Indication
        ,Conf.CurrentStatus as CurrentStatus
        ,Conf.ResearchMilestone as ResearchMilestone
        , rsc.[Earliest CS Date] as ResearchEstMilestoneDate
		,isnull(bio.Biomarker, bio2.Biomarker) as Biomarker
		,[tm].[fnBiomarkerMilestone](COALESCE(bio.[Method Validation],bio2.[Method Validation])
									,COALESCE(bio.[Method Development],bio2.[Method Development])
									,COALESCE(bio.[Reagent Procurement],bio2.[Reagent Procurement])
									,COALESCE(bio.[Contract],bio2.[Contract])
									,COALESCE(bio.[Bidding],bio2.[Bidding])) as BiomarkerMilestone
        ,COALESCE(bio.[Expected projection completion],bio2.[Expected projection completion]) as BiomarkerEstMilestoneDate
		,conf.SourceFile
from [TM].[StgPulmonaryDCSelection] rsc
	inner join [TM].[adfConfig] conf on conf.TargetTable = 'StgPulmonaryDCSelection'
    left join tm.StgBiomarkersData bio on trim(rsc.[Target]) = trim(bio.[Target]) and bio.Franchise ='Pulmonology & Immunology' and  bio.[Context of Use] = 'Direct Target Engagement' and bio.[True/False]= 'True'
	left join [TM].[IonisResearchTargets] mp on rsc.Target = mp.IonisTargetName
    left join tm.StgBiomarkersData bio2 on trim(mp.GeneTarget)  = trim(bio2.[Target]) and bio2.Franchise ='Pulmonology & Immunology'  and  bio2.[Context of Use] = 'Direct Target Engagement' and bio2.[True/False]= 'True'
where isnull(rsc.[Target],'')> ''    
UNION
SELECT  trim(rsc.Target) as [TARGET]
        ,Conf.FranchiseName as Franchise
        ,rsc.Indication
        ,Conf.CurrentStatus as CurrentStatus
        ,Conf.ResearchMilestone as ResearchMilestone
        , rsc.[Earliest TS Date] as ResearchEstMilestoneDate
		,isnull(bio.Biomarker, bio2.Biomarker) as Biomarker
		,[tm].[fnBiomarkerMilestone](COALESCE(bio.[Method Validation],bio2.[Method Validation])
									,COALESCE(bio.[Method Development],bio2.[Method Development])
									,COALESCE(bio.[Reagent Procurement],bio2.[Reagent Procurement])
									,COALESCE(bio.[Contract],bio2.[Contract])
									,COALESCE(bio.[Bidding],bio2.[Bidding])) as BiomarkerMilestone
        ,COALESCE(bio.[Expected projection completion],bio2.[Expected projection completion]) as BiomarkerEstMilestoneDate
		,conf.SourceFile
from [TM].[stgPulmonaryTargetValidation] rsc
	inner join [TM].[adfConfig] conf on conf.TargetTable = 'stgPulmonaryTargetValidation'
    left join tm.StgBiomarkersData bio on trim(rsc.[Target]) = trim(bio.[Target]) and bio.Franchise ='Pulmonology & Immunology' and bio.[Context of Use] = 'Direct Target Engagement' and bio.[True/False]= 'True'
	left join [TM].[IonisResearchTargets] mp on rsc.Target = mp.IonisTargetName
    left join tm.StgBiomarkersData bio2 on trim(mp.GeneTarget) = trim(bio2.[Target]) and bio2.Franchise ='Pulmonology & Immunology'  and  bio2.[Context of Use] = 'Direct Target Engagement' and bio2.[True/False]= 'True'
where isnull(rsc.[Target],'')> ''    
UNION
--Oncology
SELECT  trim(rsc.Target) as [TARGET]
        ,Conf.FranchiseName as Franchise
        ,rsc.Indication
        ,Conf.CurrentStatus as CurrentStatus
        ,Conf.ResearchMilestone as ResearchMilestone
        , rsc.[Earliest CS Date] as ResearchEstMilestoneDate
		,isnull(bio.Biomarker, bio2.Biomarker) as Biomarker
		,[tm].[fnBiomarkerMilestone](COALESCE(bio.[Method Validation],bio2.[Method Validation])
									,COALESCE(bio.[Method Development],bio2.[Method Development])
									,COALESCE(bio.[Reagent Procurement],bio2.[Reagent Procurement])
									,COALESCE(bio.[Contract],bio2.[Contract])
									,COALESCE(bio.[Bidding],bio2.[Bidding])) as BiomarkerMilestone
        ,COALESCE(bio.[Expected projection completion],bio2.[Expected projection completion]) as BiomarkerEstMilestoneDate
		,conf.SourceFile
from  [TM].[StgOncologyCandidateSelection] rsc
	inner join [TM].[adfConfig] conf on conf.TargetTable = 'StgOncologyCandidateSelection'
    left join tm.StgBiomarkersData bio on trim(rsc.[Target]) = trim(bio.[Target]) and bio.Franchise ='Oncology' and bio.[Context of Use] = 'Direct Target Engagement' and bio.[True/False]= 'True'
	left join [TM].[IonisResearchTargets] mp on rsc.Target = mp.IonisTargetName
    left join tm.StgBiomarkersData bio2 on trim(mp.GeneTarget)  = trim(bio2.[Target]) and bio2.Franchise ='Oncology' and  bio2.[Context of Use] = 'Direct Target Engagement' and bio2.[True/False]= 'True'
where isnull(rsc.[Target],'')> ''    
UNION
SELECT  trim(rsc.Target) as [TARGET]
        ,Conf.FranchiseName as Franchise
        ,rsc.Indication
        ,Conf.CurrentStatus as CurrentStatus
        ,Conf.ResearchMilestone as ResearchMilestone
        , rsc.[Earliest TS Date] as ResearchEstMilestoneDate
		,isnull(bio.Biomarker, bio2.Biomarker) as Biomarker
		,[tm].[fnBiomarkerMilestone](COALESCE(bio.[Method Validation],bio2.[Method Validation])
									,COALESCE(bio.[Method Development],bio2.[Method Development])
									,COALESCE(bio.[Reagent Procurement],bio2.[Reagent Procurement])
									,COALESCE(bio.[Contract],bio2.[Contract])
									,COALESCE(bio.[Bidding],bio2.[Bidding])) as BiomarkerMilestone
        ,COALESCE(bio.[Expected projection completion],bio2.[Expected projection completion]) as BiomarkerEstMilestoneDate
		,conf.SourceFile
from [TM].[stgOncologyTargetValidation] rsc
	inner join [TM].[adfConfig] conf on conf.TargetTable = 'stgOncologyTargetValidation'
    left join tm.StgBiomarkersData bio on trim(rsc.[Target]) = trim(bio.[Target]) and bio.Franchise ='Oncology'  and  bio.[Context of Use] = 'Direct Target Engagement' and bio.[True/False]= 'True'
	left join [TM].[IonisResearchTargets] mp on rsc.Target = mp.IonisTargetName
    left join tm.StgBiomarkersData bio2 on trim(mp.GeneTarget)  = trim(bio2.[Target]) and bio2.Franchise ='Oncology' and  bio2.[Context of Use] = 'Direct Target Engagement' and bio2.[True/False]= 'True'
where isnull(rsc.[Target],'')> ''    

insert into [TM].[StgResearchData]
(Target ,
Franchise ,
Indication ,
CurrentStatus ,
ResearchMilestone ,
ResearchEstMilestoneDate ,
Biomarker,
BiomarkerMilestone  ,
BiomarkerEstMilestoneDate  ,
SourceFile ) 
--Targets in Biomarker and not Research 
SELECT  trim(bio.Target) as [TARGET]
        ,bio.Franchise
        ,null Indication
        ,conf.CurrentStatus
        , null as ResearchMilestone
        , null as ResearchEstMilestoneDate
		,bio.Biomarker
		,[tm].[fnBiomarkerMilestone](bio.[Method Validation]
									,bio.[Method Development]
									,bio.[Reagent Procurement]
									,bio.[Contract]
									,bio.[Bidding]) as BiomarkerMilestone
        ,bio.[Expected projection completion] as BiomarkerEstMilestoneDate
		,conf.SourceFile
from tm.StgBiomarkersData bio
	inner join [TM].[adfConfig] conf on conf.TargetTable = 'StgBiomarkersData'
    left join [TM].[StgResearchData] rsc on trim(rsc.[Target]) = trim(bio.[Target]) and trim(rsc.[Franchise]) = trim(bio.[Franchise]) 
where   bio.[Context of Use] = 'Direct Target Engagement' and bio.[True/False]= 'True'
		and isnull(bio.[Target],'')> ''  and isnull(bio.[Franchise],'')> ''   and rsc.[Target] is null 

--UPDATE duplicates
UPDATE stg2
SET STG2.Biomarker = stg.Biomarker
	,stg2.BiomarkerMilestone = stg.BiomarkerMilestone
	,stg2.BiomarkerEstMilestoneDate = stg.BiomarkerEstMilestoneDate
--select stg2.* 
from [TM].[StgResearchData] stg 
inner join [TM].[IonisResearchTargets] m on stg.Target = m.GeneTarget 
inner join [TM].[StgResearchData] stg2 on m.IonisTargetName =  stg2.Target
inner join [TM].[adfConfig] conf on conf.TargetTable = 'StgBiomarkersData' and stg.currentStatus = conf.CurrentStatus
where stg.Target <> stg2.Target 
	and stg.currentStatus <> stg2.currentStatus  


--Delete duplicates
Delete stg 
--select * 
from [TM].[StgResearchData] stg 
inner join [TM].[IonisResearchTargets] m on stg.Target = m.GeneTarget 
inner join [TM].[StgResearchData] stg2 on m.IonisTargetName =  stg2.Target
inner join [TM].[adfConfig] conf on conf.TargetTable = 'StgBiomarkersData' and stg.currentStatus = conf.CurrentStatus
where stg.Target <> stg2.Target 
	and stg.currentStatus <> stg2.currentStatus  

--Update biomarker records that previously dropped from research 

update stg
set stg.CurrentStatus = 'Dropped from Research File'
--select *
from [TM].[StgResearchData] stg
	inner join tm.Franchise fr on isnull(stg.[Franchise], 'Unkown') = fr.FranchiseName
	inner join tm.ResearchProject rp on stg.Target = rp.ionisTargetName
	and isnull(rp.FranchiseId, '') = isnull(
		fr.FranchiseId,
		(
			Select FranchiseId
			from tm.Franchise
			where FranchiseName = 'Unkown'
		)
	)
	inner join tm.ResearchProjectStatus trg on rp.ResearchProjectId = trg.ResearchProjectId and trg.iscurrent = 1
	inner join tm.ResearchProjectStatusNames sn on trg.ResearchProjectStatusNameId = sn.ResearchProjectStatusNameId
where stg.CurrentStatus = 'Biomarker Only' and sn.ResearchProjectStatusName <>'Biomarker Only'

END
