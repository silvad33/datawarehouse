/*
Purpose:
*/
CREATE VIEW [shared_mart].[DimEntity] AS

SELECT [EntityID]
	  ,[EntityDescription]
      ,[EntityDescriptionID]
      ,[EntityIDDescription]
      ,[EntityKey]
FROM [dbo].[DimEntity]
GO
