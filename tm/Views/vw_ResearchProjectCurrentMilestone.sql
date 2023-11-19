CREATE VIEW [tm].[vw_ResearchProjectCurrentMilestone]
	AS 
	SELECT rmd.researchprojectmilestonetypename,
       rpm.researchprojectid,
       rpm.milestonedesc,
       rpm.milestoneestdate
    FROM   tm.researchprojectmilestones rpm
           INNER JOIN tm.researchprojectmilestonetype rmd
                   ON rpm.researchprojectmilestonetypeid =
                      rmd.researchprojectmilestonetypeid
    WHERE  rpm.iscurrent = 1 