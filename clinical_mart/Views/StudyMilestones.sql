/****** Object:  View clinical_mart.StudyMilestones    Script Date: 4/29/2021 7:10:52 AM ******/

create view clinical_mart.StudyMilestones as 

      select cs.ClinicalStudyName
             ,csm.ClinicalStudyID 
             ,isnull(cmn.MilestoneName,csm.MilestoneName) as MilestoneName
             ,MilestoneOrder
             ,MilestonePlannedDate
             ,MilestoneActualDate
             ,MilestoneBaselineDate
             ,CriticalMilestone
             ,adhocEvent
       	 ,cmn.MilestoneLevel
       	 ,cmg.ClinicalMilestoneGroup
       	 ,cmg.ClinicalMilestoneAbbreviation
      from clinical.ClinicalStudyMilestones csm
      inner join clinical.ClinicalStudy cs on csm.ClinicalStudyID = cs.ClinicalStudyID
      left join clinical.ClinicalMilestoneNames cmn on csm.ClinicalMilestoneNamesID = cmn.ClinicalMilestoneNamesID
      left join clinical.ClinicalMilestoneGroups cmg on cmn.ClinicalMilestoneGroupsID = cmg.ClinicalMilestoneGroupsID
;