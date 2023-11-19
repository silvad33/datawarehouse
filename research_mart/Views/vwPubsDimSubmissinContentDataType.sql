CREATE VIEW [research_mart].[vwPubsDimSubmissinContentDataType] AS 
(
  SELECT m.[PubsKey],m.[PubsSubmissionContentDataTypeID],f.[Title] FROM
    [research].[PubsRecordSubmissinContentDataType]  m
  LEFT JOIN 
    [research].[PubsSubmissionContentDataType]  f 
  ON
    m.[PubsSubmissionContentDataTypeID]=f.[PubsSubmissionContentDataTypeID]
)
GO
