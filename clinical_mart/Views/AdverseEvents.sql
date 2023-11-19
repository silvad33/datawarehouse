/****** Object:  View clinical_mart.AdverseEvents    Script Date: 4/29/2021 7:10:52 AM ******/

create view clinical_mart.AdverseEvents as 

      select sae.StudyAdverseEventsID
            ,sae.AESequenceNumber
            ,sae.AEOutcome
            ,sae.AEDecodedTerm
            ,sae.AEDescription
            ,sae.AEHighLevelGroupTermCode
            ,sae.AEHighLevelGroupTerm
            ,sae.AEHighLevelTermCode
            ,sae.AEHighLevelTerm
            ,sae.AELowLevelTermCode
            ,sae.AELowLevelTerm
            ,sae.AEComment
            ,sae.AEStartDate
            ,sae.AEEndDate
            ,sae.AESeverity
            ,sae.AESerious
            ,sae.AEConcominantTreatment
            ,sae.AEDrugRelated
      	,sss.StudySubjectID
      	,sss.StudySiteScreeningID
      	,cs.ClinicalStudyName
      	,isnull(sl.Country,'Unknown') as Country
      	,csi.ClinicalSiteNumber
      from clinical.StudyAdverseEvents sae
      inner join clinical.StudySiteSubjects sss on sae.StudySiteSubjectsID = sss.StudySiteSubjectsID
      inner join clinical.ClinicalStudySites css on sss.ClinicalStudySitesID = css.ClinicalStudySitesID
      inner join clinical.ClinicalStudy cs on css.ClinicalStudyID = cs.ClinicalStudyID
      inner join clinical.ClinicalSite csi on css.ClinicalSiteID = csi.ClinicalSiteID
      left join clinical_mart.Site sl on css.ClinicalSiteID = sl.ClinicalSiteID
;