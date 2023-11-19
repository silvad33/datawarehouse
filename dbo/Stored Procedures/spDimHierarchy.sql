CREATE proc [dbo].[spDimHierarchy] as

truncate table DimHierarchy
insert into DimHierarchy
select [HierarchyDepth]
      ,[HierarchyType]
      ,[RootPartyNumber]
	  ,d1.[NAMEALIAS] RootPartyNumberNameAlias
      ,d1.[ORGANIZATIONNAME] RootPartyOriganizationName
      ,[LeafPartyNumber]
	  ,d2.[NAMEALIAS] LeafPartyNumberNameAlias
      ,d2.[ORGANIZATIONNAME] LeafPartyNumberOriganizationName
      ,[LeafOperatingUnit]
      ,[Level1PartyNumber]
	  ,d3.[NAMEALIAS] Level1PartyNumberNameAlias
      ,d3.[ORGANIZATIONNAME] Level1PartyNumberOriganizationName
	  ,[Level2PartyNumber]
	  ,d4.[NAMEALIAS] Level2PartyNumberNameAlias
      ,d4.[ORGANIZATIONNAME] Level2PartyNumberOriganizationName
	  ,[Level3PartyNumber]
	  ,d5.[NAMEALIAS] Level3PartyNumberNameAlias
      ,d5.[ORGANIZATIONNAME] Level3PartyNumberOriganizationName
	  ,[Level4PartyNumber] 
	  ,d6.[NAMEALIAS] Level4PartyNumberNameAlias
      ,d6.[ORGANIZATIONNAME] Level4PartyNumberOriganizationName
	  ,dept.DepartmentKey
	     from(
SELECT [HierarchyDepth]
      ,[HierarchyType]
      ,[RootPartyNumber]
      ,[LeafPartyNumber]
      ,[LeafOperatingUnit]
      ,[Level1PartyNumber]
      ,case when [HierarchyDepth] = 1 then [Level1PartyNumber]
			else [Level2PartyNumber] end [Level2PartyNumber]
      ,case when [HierarchyDepth] = 1 then [Level1PartyNumber]
			when [HierarchyDepth] = 2 then [Level2PartyNumber]
			else [Level3PartyNumber] end [Level3PartyNumber]
      ,case when [HierarchyDepth] = 1 then [Level1PartyNumber]
			when [HierarchyDepth] = 2 then [Level2PartyNumber]
			when [HierarchyDepth] = 3 then [Level3PartyNumber]
			else [Level4PartyNumber] end [Level4PartyNumber]
  FROM [dbo].[OrganizationHierarchy] )OH
  left join  [dbo].[DirPartyV2Staging]  D1 on d1.PARTYNUMBER = OH.RootPartyNumber
		and d1.PARTYTYPE = 'OperatingUnit'
  left join  [dbo].[DirPartyV2Staging]  D2 on D2.PARTYNUMBER = OH.LeafPartyNumber
		and d2.PARTYTYPE = 'OperatingUnit'
  left join  [dbo].[DirPartyV2Staging]  D3 on D3.PARTYNUMBER = OH.Level1PartyNumber
		and d3.PARTYTYPE = 'OperatingUnit'
  left join  [dbo].[DirPartyV2Staging]  D4 on D4.PARTYNUMBER = OH.Level2PartyNumber
		and d4.PARTYTYPE = 'OperatingUnit'
  left join  [dbo].[DirPartyV2Staging]  D5 on D5.PARTYNUMBER = OH.Level3PartyNumber
		and d5.PARTYTYPE = 'OperatingUnit'
  left join  [dbo].[DirPartyV2Staging]  D6 on D6.PARTYNUMBER = OH.Level4PartyNumber
		and d6.PARTYTYPE = 'OperatingUnit'
		join DimDepartment dept on dept.DepartmentNumber = oh.LeafOperatingUnit
