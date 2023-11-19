/****** Object:  View [clinical_mart].[StudyCountry]    Script Date: 4/29/2021 7:10:52 AM ******/

create view clinical_mart.StudyCountry as 

	select distinct cs.ClinicalStudyName
		,isnull(sl.Country, 'Unknown') as Country
	from clinical.ClinicalStudySites css
	inner join clinical.ClinicalStudy cs on css.ClinicalStudyID = cs.ClinicalStudyID
	left join clinical_mart.Site sl on css.ClinicalSiteID = sl.ClinicalSiteID
;