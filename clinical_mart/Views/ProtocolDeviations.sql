/****** Object:  View clinical_mart.ProtocolDeviations    Script Date: 4/29/2021 7:10:52 AM ******/

create view clinical_mart.ProtocolDeviations as 

select spd.StudyProtocolDeviationsID
      ,spd.DVSequenceNumber
      ,spd.DVCategory
      ,spd.DVTypeDecoded
      ,spd.DVDescription
      ,spd.DVDeviationDate
      ,spd.DVDeviationDiscoveryDate
      ,spd.DVProjectTeamLead
      ,spd.DVDateSentforReview
      ,spd.DVDateReviewed
      ,spd.DVAction
	,sss.StudySubjectID
	,sss.StudySiteScreeningID
	,cs.ClinicalStudyName
	,isnull(sl.Country,'Unknown') as Country
	,csi.ClinicalSiteNumber
from clinical.StudyProtocolDeviations spd
inner join clinical.StudySiteSubjects sss on spd.StudySiteSubjectsID = sss.StudySiteSubjectsID
inner join clinical.ClinicalStudySites css on sss.ClinicalStudySitesID = css.ClinicalStudySitesID
inner join clinical.ClinicalStudy cs on css.ClinicalStudyID = cs.ClinicalStudyID
inner join clinical.ClinicalSite csi on css.ClinicalSiteID = csi.ClinicalSiteID
left join clinical_mart.Site sl on css.ClinicalSiteID = sl.ClinicalSiteID
