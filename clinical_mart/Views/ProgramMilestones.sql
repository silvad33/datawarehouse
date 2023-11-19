/****** Object:  View [clinical_mart].[ProgramMilestones]    Script Date: 4/29/2021 7:10:52 AM ******/

create view [clinical_mart].[ProgramMilestones] as 

SELECT cp.ProgramName
	  ,cp.ClinicalProgramsID
      ,isnull(cmn.MilestoneName,cpm.[MilestoneName]) as MilestoneName
      ,[MilestoneOrder]
      ,[MilestonePlannedDate]
      ,[MilestoneActualDate]
      ,[MilestoneBaselineDate]
      ,[CriticalMilestone]
	  ,cmn.MilestoneLevel
	  ,cmg.ClinicalMilestoneGroup
	  ,cmg.ClinicalMilestoneAbbreviation
  FROM [clinical].[ClinicalProgramMilestones] cpm
  inner join
  clinical.ClinicalPrograms cp
  on cpm.ClinicalProgramID = cp.ClinicalProgramsID
  left join
  clinical.ClinicalMilestoneNames cmn
  on cpm.ClinicalMilestoneNamesID = cmn.ClinicalMilestoneNamesID
  left join
  [clinical].[ClinicalMilestoneGroups] cmg
  on cmn.ClinicalMilestoneGroupsID = cmg.ClinicalMilestoneGroupsID
