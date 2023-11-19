/*
Purpose:
*/
CREATE VIEW [shared_mart].[DimHierarchy] AS

SELECT [HierarchyDepth]
      ,[HierarchyType]
      ,[RootPartyNumber]
      ,[RootPartyNumberNameAlias]
      ,[RootPartyOriganizationName]
      ,[LeafPartyNumber]
      ,[LeafPartyNumberNameAlias]
      ,[LeafPartyNumberOriganizationName]
      ,[LeafOperatingUnit]
      ,[Level1PartyNumber]
      ,[Level1PartyNumberNameAlias]
      ,[Level1PartyNumberOriganizationName]
      ,[Level2PartyNumber]
      ,[Level2PartyNumberNameAlias]
      ,[Level2PartyNumberOriganizationName]
      ,[Level3PartyNumber]
      ,[Level3PartyNumberNameAlias]
      ,[Level3PartyNumberOriganizationName]
      ,[Level4PartyNumber]
      ,[Level4PartyNumberNameAlias]
      ,[Level4PartyNumberOriganizationName]
      ,[DepartmentKey]
FROM [dbo].[DimHierarchy]
GO
