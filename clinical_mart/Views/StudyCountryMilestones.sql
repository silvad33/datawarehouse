/****** Object:  View clinical_mart.StudyCountryMilestones    Script Date: 4/29/2021 7:10:52 AM ******/

create view clinical_mart.StudyCountryMilestones as 

with StudyCountryMilestones as (
select cs.ClinicalStudyName
      ,cscm.ClinicalStudyID
      ,ltrim(substring(cscm.Country,charindex('-',cscm.Country)+1,len(cscm.Country))) as Country
      ,isnull(cmn.MilestoneName,cscm.MilestoneName) as MilestoneName
      ,MilestoneOrder
      ,MilestonePlannedDate
      ,MilestoneActualDate
      ,MilestoneBaselineDate
      ,CriticalMilestone
	  ,cmn.MilestoneLevel
	  ,cmg.ClinicalMilestoneGroup
	  ,cmg.ClinicalMilestoneAbbreviation
  from clinical.ClinicalStudyCountryMilestones cscm
  inner join clinical.ClinicalStudy cs on cscm.ClinicalStudyID = cs.ClinicalStudyID
  left join clinical.ClinicalMilestoneNames cmn on cscm.ClinicalMilestoneNamesID = cmn.ClinicalMilestoneNamesID
  left join clinical.ClinicalMilestoneGroups cmg on cmn.ClinicalMilestoneGroupsID = cmg.ClinicalMilestoneGroupsID)

  select ClinicalStudyName
	  /**** temp fix until Country is normalized out ****/
	  ,case country 
		when 'Korea, South' then 'South Korea' 
		when 'Czech Rep.' then 'Czech Republic' 
		when 'USA' then 'United States' 
		else country end as Country
      ,MilestoneName
      ,MilestoneOrder
      ,MilestonePlannedDate
      ,MilestoneActualDate
      ,MilestoneBaselineDate
      ,CriticalMilestone
	  ,MilestoneLevel
	  ,ClinicalMilestoneGroup
	  ,ClinicalMilestoneAbbreviation
	from StudyCountryMilestones
;