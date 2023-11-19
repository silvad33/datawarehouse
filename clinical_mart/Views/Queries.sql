
create view clinical_mart.Queries as 

      select csq.StudyQueryGUID as QueryID
            ,csq.EDCCRFFormName as CRF
            ,csq.StudySiteScreeningNumber as ScreeningNumber
            ,csq.StudyVisitName as Visit
            ,csq.StudyPlannedTimePoint as SubVisit
            ,csq.CRFFieldName as CRFField
            ,csq.EDCQueryCode as QueryCode
            ,csq.EDCQueryDescription as Query
            ,csq.EDCQueryCreationDate as QueryDate
            ,csq.EDCQueryAnswerDate as AnswerDate
            ,csq.EDCQueryReviewDate as ReviewDate
            ,csq.EDCAuditStatus as QueryStatus
      	,cs.ClinicalStudyName
      	,isnull(sl.Country, 'Unknown') as Country
      	,csi.ClinicalSiteNumber
      from clinical.ClinicalStudyQueries csq
      inner join clinical.ClinicalStudySites css on csq.ClinicalStudySitesID = css.ClinicalStudySitesID
      inner join clinical.ClinicalStudy cs on css.ClinicalStudyID = cs.ClinicalStudyID
      inner join clinical.ClinicalSite csi on css.ClinicalSiteID = csi.ClinicalSiteID
      left join clinical_mart.Site sl on css.ClinicalSiteID = sl.ClinicalSiteID
;