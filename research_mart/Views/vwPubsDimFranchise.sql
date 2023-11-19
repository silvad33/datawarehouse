CREATE VIEW [research_mart].[vwPubsDimFranchise] AS 
(
  SELECT m.[PubsKey],m.[PubsFranchiseID],f.[Franchise] FROM
    [research].[PubsRecordFranchise]  m
  LEFT JOIN 
    [research].[PubsFranchise]  f 
  ON
    m.[PubsFranchiseID]=f.[PubsFranchiseID]
)
GO
