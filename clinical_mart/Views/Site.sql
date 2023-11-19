/****** Object:  View clinical_mart.Site    Script Date: 4/29/2021 7:10:52 AM ******/

create view clinical_mart.Site as 

	with SiteLocation as ( 
	select LocationType
	      ,PersonID
	      ,ClinicalSiteID
	      ,li.OrganizationID
		  ,o.OrgName
		  ,a.AddresseeName
		  ,a.StreetAddress1
		  ,a.StreetAddress2
		  ,a.City
		  ,a.StateProvince
		  ,a.PostalCode
		  ,a.Country
		  ,a.AddressID
		  ,a.LocationInfoID
		  ,row_number() over(partition by ClinicalSiteID order by case when a.Country is not null then li.LocationInfoID end desc, li.LocationInfoID desc) as _rank
	FROM shared.LocationInfo li
	inner join shared.Address a on li.LocationInfoID = a.LocationInfoID
	inner join shared.Organization o on li.OrganizationID = o.OrganizationID
	where li.LocationType = 'Address'
	)

	select cs.ClinicalSiteNumber
	      ,sl.* 
	from SiteLocation sl
	inner join clinical.ClinicalSite cs on sl.ClinicalSiteID = cs.ClinicalSiteID
	where _rank = 1
;