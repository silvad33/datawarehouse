/****** Object:  View [clinical_mart].[Study]    Script Date: 4/29/2021 7:10:52 AM ******/

CREATE view [clinical_mart].[Study] as 

with SubjectPlans as 
(select sr.ClinicalStudyID,sr.ScenarioName as LatestPlanName,sr.Status as LatestPlanType
 ,sp.ScreenFailureRate/100.00 as LatestPlanScreenFailureRate
 ,sp.EarlyTermination_pct/100.00 as LatestPlanEarlyTerminationRate
 ,sp.TotalSubjectsRequired  as LatestPlanTotalSubjectsRequired
 ,sp.PlanLevel as LatestPlanLevel
 ,row_number() over(partition by ClinicalStudyID order by case [Status] when 'Planning 2' then 3 when 'Planning 1' then 2 when 'Baseline' then 1 end desc) _rank
 from 
[clinical].[ScenarioParameters] sp
inner join
[clinical].[StudyRecruitment] sr
on sp.StudyRecruitmentID = sr.StudyRecruitmentID
where sr.PlanType = 'SubjectPlan'
) 

select cs.[ClinicalStudyName]
      ,cs.[Description]
      ,cs.[Status]
      ,cs.[Phase]
      ,cs.[ClinicalStudyID]
      ,cs.[Indication]
      ,cs.[ClinicalProgramsID]
      ,cs.[ETMFStatus]
      ,cs.[ShortDescription]
      ,cs.[CTMSStatus]
,cp.ProgramName
,sp.ClinicalStudyID as ClinicalStudyID2
,sp.LatestPlanName
,sp.LatestPlanType
 ,sp.LatestPlanScreenFailureRate
 ,sp.LatestPlanEarlyTerminationRate
 ,sp.LatestPlanTotalSubjectsRequired
 ,sp.LatestPlanLevel
,sp._rank
from 
[clinical].[ClinicalStudy] cs
	left join
	SubjectPlans sp 
	on cs.ClinicalStudyID = sp.ClinicalStudyID
	and sp._rank = 1
inner join
clinical.ClinicalPrograms cp
on cs.ClinicalProgramsID = cp.ClinicalProgramsID

