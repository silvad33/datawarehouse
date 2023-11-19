CREATE proc [dbo].[spDimEntity] as

update DimEntity 
set	   DimEntity.[EntityID] =				  z.[EntityID] 
      ,DimEntity.[EntityDescription] =		  z.[EntityDescription] 
      ,DimEntity.[EntityDescriptionID] =	  z.[EntityDescriptionID]
      ,DimEntity.[EntityIDDescription] =	  z.[EntityIDDescription]
	  from (select distinct DATAAREAID EntityID
			,case when f.ORGANIZATIONNAME is null 
				then 'Description Not Available'
				else f.ORGANIZATIONNAME
					end  EntityDescription
		,case when f.ORGANIZATIONNAME is null 
				then 'Description Not Available'
				else concat(f.ORGANIZATIONNAME,' (',DATAAREAID,')')
					end  EntityDescriptionID
		,case when f.ORGANIZATIONNAME is null 
				then 'Description Not Available'
				else concat(DATAAREAID,' - ',f.ORGANIZATIONNAME)
					end  EntityIDDescription
		--,securityKey
  from (select distinct dataareaid from GeneralJournalAccountEntryStaging 
			union select distinct dataareaid from BudgetRegisterEntryStaging) g
  left join [dbo].[DirPartyV2Staging]  f
		on g.DATAAREAID =  f.LEGALENTITYDATAAREA
			and f.PARTYTYPE = 'LegalEntity'
	where DATAAREAID in (select distinct entityid from dimentity)
	) z where  z.EntityID = DimEntity.entityid


insert into DimEntity ( [EntityID]
      ,[EntityDescription]
      ,[EntityDescriptionID]
      ,[EntityIDDescription]
     -- ,[SecurityKey]
	 )
select distinct DATAAREAID EntityID
			,case when f.ORGANIZATIONNAME is null 
				then 'Description Not Available'
				else f.ORGANIZATIONNAME
					end  EntityDescription
		,case when f.ORGANIZATIONNAME is null 
				then 'Description Not Available'
				else concat(f.ORGANIZATIONNAME,' (',DATAAREAID,')')
					end  EntityDescriptionID
		,case when f.ORGANIZATIONNAME is null 
				then 'Description Not Available'
				else concat(DATAAREAID,' - ',f.ORGANIZATIONNAME)
					end  EntityIDDescription
		--,securityKey
  from (select distinct dataareaid from GeneralJournalAccountEntryStaging 
			union select distinct dataareaid from BudgetRegisterEntryStaging) g
  left join [dbo].[DirPartyV2Staging]  f
		on g.DATAAREAID =  f.LEGALENTITYDATAAREA
			and f.PARTYTYPE = 'LegalEntity'
	where DATAAREAID not in (select distinct entityid from dimentity)
--	left join [D365Security] d on d.entity =  g.DATAAREAID


