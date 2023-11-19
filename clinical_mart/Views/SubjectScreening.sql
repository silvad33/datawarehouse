create view clinical_mart.SubjectScreening as 

    select cs.ClinicalStudyName
    	,isnull(sl.Country,'Unknown') as Country
    	,csi.ClinicalSiteNumber
     	,ctms.SubjectNumber
        ,ctms.ScreeningDate
        ,ctms.ScreeningPass
        ,ctms.SubjectEnrollmentDate
        ,ctms.SiteScreeningNumber
        ,ctms.SubjectDiscontinuationDate
        ,ctms.SubjectStudyCompleted
        ,ctms.CTMSStatus
        ,ctms.ScreenFailureReason
        ,ctms.RandomizationDate
        ,ctms.BaselineDate
        ,ctms.StudyDiscontinuationDate
        ,ctms.StudyDiscontinuationReason
        ,ctms.TreatmentCompletionDate
        ,ctms.TreatmentDiscontinuationDate
        ,ctms.TreatmentDiscontinuationReason
        ,ctms.SubjectTreatmentCompleted
        ,ctms.CTMSDataID
        ,ctms.ClinicalStudySitesID
        ,ctms.ClinicalStudyCohortsID
        ,css.ClinicalStudyID
        ,css.ClinicalSiteID
    	,1 as Screened
    	,case when ctms.TreatmentCompletionDate is not null and ctms.SubjectTreatmentCompleted = 1 then 1 else 0 end as CompletedTreatment
    	,case when ctms.TreatmentDiscontinuationDate is not null and ctms.SubjectTreatmentCompleted = 0 then 1 else 0 end as EarlyTermination
        ,case when ctms.SubjectDiscontinuationDate is not null then 1 else 0 end as OffStudy
        ,case when (ctms.TreatmentCompletionDate is not null or ctms.TreatmentDiscontinuationDate is not null) and SubjectDiscontinuationDate is null then 1 else 0 end as FollowUp
    	,case when ctms.RandomizationDate is not null or ctms.SubjectNumber is not null then 1 else 0 end as Randomized
    	,case when ctms.ScreeningPass = 0 then 1 else 0 end as ScreenFailure
    	,case when ctms.ScreeningDate is not null and ctms.SiteScreeningNumber is not null
    			then case when ctms.ScreeningPass = 1 and (ctms.RandomizationDate is not null or ctms.SubjectNumber is not null) then 1 --screen pass, randomized
    				 	  when ctms.ScreeningPass is null then 1
    				 	  else 0 end
    		 else 0
    		 end as InScreen
        ,case when ctms.ScreeningPass = 1 and (ctms.RandomizationDate is null or ctms.SubjectNumber is null) then 1 
            else 0
            end as ScreenPass

    from clinical.CTMSData ctms
    inner join clinical.ClinicalStudySites css on ctms.ClinicalStudySitesID = css.ClinicalStudySitesID
    inner join clinical.ClinicalStudy cs on css.ClinicalStudyID = cs.ClinicalStudyID
    inner join clinical.ClinicalSite csi on css.ClinicalSiteID = csi.ClinicalSiteID
    left join clinical_mart.Site sl on css.ClinicalSiteID = sl.ClinicalSiteID
;