CREATE VIEW [research_mart].[Journals] AS 
SELECT [JournalID]
      ,[JournalTitle]
      ,[URLLink]
      ,[URLDescription]
      ,[ISDN]
      ,[AddedBy]
      ,[Abbreviation]
      ,[Created]
      ,[Modified]
      ,[CreatedByUserKey]
      ,[DateCreated]
      ,[DateModified]
  FROM [research].[PubsJournals]
GO