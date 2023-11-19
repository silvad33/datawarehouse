
create view clinical_mart.SiteActivation as 

      with PIName as (
          select psr.*
                ,FirstName
                ,LastName 
                ,row_number() over(partition by psr.ClinicalStudySitesID order by isnull(psr.StartDate,'1900-01-01') desc, PersonSiteRolesID desc) _rnk
                ,count(psr.ClinicalSitePersonID) over(partition by psr.ClinicalStudySitesID) _cnt
          from clinical.PersonSiteRoles psr
          inner join shared.Person p on psr.ClinicalSitePersonID = p.PersonID
          where role = 'Primary Investigator'
      )

      select cs.ClinicalStudyName
            ,isnull(sl.Country,'Unknown') as Country
            ,csi.ClinicalSiteNumber
            ,css.SiteInitiationDate
            ,css.CTMS_Status as Status
            ,case when css.CTMS_Status in ('Active','Open','Closed') 
                      then case when isnull(MaximumNumberOfSubjects, 0) = 0 then 1 else 0 end
            	else 0 end as SiteActivated
            ,coalesce(FirstName + ' ' + LastName, CTMS_PrimaryInvestigator, 'N/A') as PrimaryInvestigator ---Use MDM data first otherwise CTMS 
            ,case when css.CTMS_Status in ('Active','Open','Closed') 
                      then case when isnull(MaximumNumberOfSubjects, 0) = 0 then 1 else 0 end
            	    when css.CTMS_Status = 'Start-up' and MaximumNumberOfSubjects is null then 1
            	    else 0 end as ListSite
      from clinical.ClinicalStudySites css
      inner join clinical.ClinicalStudy cs on css.ClinicalStudyID = cs.ClinicalStudyID
      inner join clinical.ClinicalSite csi on css.ClinicalSiteID = csi.ClinicalSiteID
      left join clinical_mart.Site sl on css.ClinicalSiteID = sl.ClinicalSiteID
      left join PIName pin on css.ClinicalStudySitesID = pin.ClinicalStudySitesID and pin._rnk = 1
      where css.CTMS_Status is not null --- Added to only filter out Sites not in CTMS
;