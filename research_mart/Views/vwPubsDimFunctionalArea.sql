CREATE VIEW [research_mart].[vwPubsDimFunctionalArea] AS 
(
  SELECT m.[PubsKey],m.[PubsFunctionalAreaID],f.[Functional] FROM
    [research].[PubsRecordFunctionalArea]  m
  LEFT JOIN 
    [research].[PubsFunctionalArea]  f 
  ON
    m.[PubsFunctionalAreaID]=f.[PubsFunctionalAreaID]
)
GO
