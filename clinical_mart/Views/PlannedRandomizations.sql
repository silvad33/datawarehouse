/****** Object:  View [clinical_mart].[PlannedRandomizations]    Script Date: 4/29/2021 7:10:52 AM ******/

create view [clinical_mart].[PlannedRandomizations] as 

with 
SubjectPlans as (
  select *  
 ,row_number() over(partition by ClinicalStudyID order by case [Status] when 'Planning 2' then 3 when 'Planning 1' then 2 when 'Baseline' then 1 end desc) PlanRank
 from 
[clinical].[StudyRecruitment] sr
where PlanType = 'SubjectPlan'
and exists 
	(select 1 from 
	[clinical].[SiteSubjectRecruitment] ssr 
	inner join
	[clinical].[ScenarioStudySites] sss
	on ssr.ScenarioStudySitesID = sss.ScenarioStudySitesID
	where sss.StudyRecruitmentID = sr.StudyRecruitmentID)
)

,PlannedRandomizations as (
SELECT sp.PlanLevel,cst.ClinicalStudyName
,case when sp.PlanLevel in ('Site','Country') then
	case when ScenerioSiteName = '9999' then '9999' else SiteCountry end
else null end as Country
,case when PlanLevel = 'Site' then
	ScenerioSiteName 
else null end as ClinicalSiteNumber
,ssr.PatientRecruitmentDate as PatientRecruitmentStartDate
,dateadd(DAY,-1,dateadd(MONTH,1,ssr.PatientRecruitmentDate)) as PatientRecruitmentEndDate
,ssr.NumberofSubjects
,spl.ScenarioName as PlanName,spl.Status as PlanType,spl.PlanRank
,isnull(sp.ScreenFailureRate,0.00)/100.00 as ScreenFailureRate
,isnull(sp.EarlyTermination_pct,0.00)/100.00 as EarlyTerminationRate
FROM [clinical].[SiteSubjectRecruitment] ssr---Planned subject randomizations
inner join
[clinical].[ScenarioStudySites] sss
on ssr.ScenarioStudySitesID = sss.ScenarioStudySitesID
	left join
	SubjectPlans spl
	on sss.StudyRecruitmentID = spl.StudyRecruitmentID
		left join
		clinical.ClinicalStudy cst
		on spl.ClinicalStudyID = cst.ClinicalStudyID
	left join
	clinical.ScenarioParameters sp
	on spl.StudyRecruitmentID = sp.StudyRecruitmentID
)

select * 
,case when ScreenFailureRate  = 1 then 0.00 else
	NumberofSubjects/(1- ScreenFailureRate)
	end as TotalScreensNeeded
from PlannedRandomizations
