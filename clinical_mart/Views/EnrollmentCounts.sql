
CREATE view [clinical_mart].[EnrollmentCounts] as 

with 
Months as (
SELECT  MonthYear,min(Date) as StartDate,max(Date) as EndDate
FROM [dbo].[DimDate]
group by MonthYear)

/**** Calculate Actual vs Plan To Date for Realistic Projection Adjustment ****/
,AVPTD as (
select a.ClinicalStudyName,isnull(ActualToDate,0) ActualToDate,LatestPlanToDate 
,case when LatestPlanToDate = 0 then 0 else isnull(ActualToDate,0)/LatestPlanToDate end AVPTD
from 
	(select ClinicalStudyName,sum(NumberofSubjects*1.00) as LatestPlanToDate
	from clinical_mart.PlannedRandomizations
	where PlanRank = 1 and PatientRecruitmentStartDate < getdate()
	group by ClinicalStudyName) a 
left join
	(select ClinicalStudyName,sum(Randomized*1.00) as ActualToDate
	from clinical_mart.SubjectScreening 
	where Randomized = 1
	group by ClinicalStudyName) b
	on a.ClinicalStudyName = b.ClinicalStudyName)

,PlanActualData as (
select PatientRecruitmentStartDate as ReportingDate,ClinicalStudyName,PlanType as Measure,sum(NumberofSubjects) as Amount 
from clinical_mart.PlannedRandomizations
group by  PatientRecruitmentStartDate,ClinicalStudyName,PlanType
UNION ALL
select SiteRecruitmentStartDate,ClinicalStudyName,'Site Current Plan',sum(NumberOfSites) 
from clinical_mart.PlannedSiteActivations where SitePlanRank = 1
group by SiteRecruitmentStartDate,ClinicalStudyName,SitePlanType
UNION ALL
select PatientRecruitmentStartDate as ReportingDate,ClinicalStudyName,'Optimistic Projection',sum(NumberofSubjects) as Amount 
from clinical_mart.PlannedRandomizations
where PlanRank = 1 and PatientRecruitmentStartDate > getdate()
group by  PatientRecruitmentStartDate,ClinicalStudyName,PlanType
UNION ALL
select PatientRecruitmentStartDate as ReportingDate,a.ClinicalStudyName,'Realistic Projection',sum(NumberofSubjects*isnull(AVPTD,0)) as Amount 
from clinical_mart.PlannedRandomizations a
left join
AVPTD b
on a.ClinicalStudyName = b.ClinicalStudyName
where PlanRank = 1 and PatientRecruitmentStartDate > getdate()
group by  PatientRecruitmentStartDate,a.ClinicalStudyName,PlanType
UNION ALL
select b.StartDate,ClinicalStudyName,'Site Actuals' as Measure,sum(SiteActivated) as Amount
from clinical_mart.SiteActivation a
inner join
Months b
on a.SiteInitiationDate between b.StartDate and b.EndDate
where SiteActivated = 1
group by b.StartDate,ClinicalStudyName
UNION ALL
select b.StartDate,ClinicalStudyName,'Actual',sum(Randomized) 
from clinical_mart.SubjectScreening a
inner join
Months b
on a.RandomizationDate between b.StartDate and b.EndDate
where Randomized = 1
group by b.StartDate,ClinicalStudyName)

/*** Create records for TotalSubjectsRequired line ***/
,TotalSubjectsRequired as (
select StartDate as ReportingDate,a.ClinicalStudyName,'Total Subjects Required' as Measure, isnull(LatestPlanTotalSubjectsRequired,0) as Amount from 
	(select ClinicalStudyName,min(ReportingDate) as MinReportingDate,max(ReportingDate) as MaxReportingDate
	from PlanActualData
	group by ClinicalStudyName) a
inner join
Months b
on a.MinReportingDate < b.EndDate
and a.MaxReportingDate >= b.StartDate
inner join
clinical_mart.Study c
on a.ClinicalStudyName = c.ClinicalStudyName)

,PlanActualwTotalSubjects as (
select * from PlanActualData
UNION ALL
select * from TotalSubjectsRequired
UNION ALL
/**** Add Actuals to first projection month ***/
select ReportingDate,ClinicalStudyName,Measure,ActualsAmount from 
	(select ReportingDate,ClinicalStudyName,Measure
	,ROW_NUMBER() over(partition by ClinicalStudyName,Measure order by ReportingDate asc) as rownum
	,sum(case when Measure = 'Actual' then Amount else 0 end) over(partition by ClinicalStudyName) as ActualsAmount  
	from 
	PlanActualData ) a
where Measure in ('Optimistic Projection','Realistic Projection') 
and rownum = 1
)
,MaxAmountsForAdhocEvents as (
select [ClinicalStudyName], max(amount) as MaxAmount from (
	select ClinicalStudyName,LatestPlanTotalSubjectsRequired as Amount
	from [clinical_mart].[Study]
	where LatestPlanTotalSubjectsRequired is not null
	UNION ALL
	select [ClinicalStudyName],sum([NumberofSubjects])
	from [clinical_mart].[PlannedRandomizations]
	where planrank = 1
	group by [ClinicalStudyName]) a
group by [ClinicalStudyName])


select ReportingDate as MonthYear,ClinicalStudyName,Measure,sum(Amount) as Amount 
FROM
	(select * from PlanActualwTotalSubjects 
	UNION ALL 
	/*** Fill gaps where 0 count not captured in db ****/
	select ReportingDate,ClinicalStudyName,'Site Current Plan',0 from PlanActualwTotalSubjects group by ReportingDate,ClinicalStudyName
	UNION ALL 
	select ReportingDate,ClinicalStudyName,'Site Actuals',0 from PlanActualwTotalSubjects where Reportingdate < getdate() group by ReportingDate,ClinicalStudyName
	UNION ALL 
	select ReportingDate,ClinicalStudyName,'Actual',0 from PlanActualwTotalSubjects where Reportingdate < getdate() group by ReportingDate,ClinicalStudyName
	UNION ALL
	SELECT cast([MilestoneActualDate] as date) as MonthYear
	  ,sm.[ClinicalStudyName]
	  ,'AdHoc Event' as Measure
	  ,MaxAmount*.75 as Amount
	  FROM [clinical_mart].[StudyMilestones] sm
	  inner join
	MaxAmountsForAdhocEvents ma
	on sm.ClinicalStudyName = ma.ClinicalStudyName
	where adhocEvent = 1
) a
GROUP BY ReportingDate,ClinicalStudyName,Measure



GO


