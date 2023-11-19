CREATE VIEW [research_mart].[vwPubsDimIonisAuthor] AS 
(
  SELECT m.[PubsKey],m.[IonisAuthorKey],f.[FullName] FROM
    [research].[PubsRecordIonisAuthor]  m
  LEFT JOIN 
    [dbo].[DimUser]  f 
  ON
    m.[IonisAuthorKey]=f.[UserKey]
)
GO
