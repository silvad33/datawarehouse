/****** Object:  View [clinical_mart].[PlannedSiteActivations]    Script Date: 4/29/2021 7:10:52 AM ******/

create view [clinical_mart].[PlannedSiteActivations] as 

with 
SitePlans as (
 select *  
 ,row_number() over(partition by ClinicalStudyID order by case [Status] when 'Site-Plan' then 2 when 'Site-Baseline' then 1 end desc) PlanRank
 from 
[clinical].[StudyRecruitment] sr
where PlanType = 'SitePlan'
and exists 
	(select 1 from [clinical].[StudySiteRecruitment] ssr where ssr.StudyRecruitmentID = sr.StudyRecruitmentID)
)

select ssr.SiteRecruitmentDate as SiteRecruitmentStartDate
,dateadd(DAY,-1,dateadd(MONTH,1,SiteRecruitmentDate)) as SiteRecruitmentEndDate
,ssr.NumberOfSites
,spl.ScenarioName as SitePlanName
,spl.Status as SitePlanType
,spl.PlanRank as SitePlanRank
,cs.ClinicalStudyName
from 
[clinical].[StudySiteRecruitment] ssr--- Planned Site Activations at study level
inner join
SitePlans spl
on ssr.StudyRecruitmentID = spl.StudyRecruitmentID
inner join
clinical.ClinicalStudy cs
on spl.ClinicalStudyID = cs.ClinicalStudyID
