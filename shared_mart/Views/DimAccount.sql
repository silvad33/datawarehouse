/*
Purpose: List Account dimensions for data consumption
*/

CREATE VIEW [shared_mart].[DimAccount] AS

SELECT [MainAccountNumber]
      ,[MainAccountDescription]
      ,[MainAccountNumberDescription]
      ,[MainAccountDescriptionNumber]
      ,[MainAccountType]
      ,[MainAccountCategoryDescription]
      ,[level5]
      ,[level5Description]
      ,[level4]
      ,[level4Description]
      ,[level3]
      ,[level3Description]
      ,[Level2]
      ,[Level2Description]
      ,[Level1]
      ,[Level1Description]
      ,[IsGAAP]
      ,[IsControlled]
      ,[IsFTE]
      ,[PARTITION]
      ,[AccountKey]
      ,[IsActive]
FROM [dbo].[DimAccount]