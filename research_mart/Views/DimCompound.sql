CREATE VIEW [research_mart].[DimCompound] AS 
SELECT 
	[ID],
	[PubsKey],
	[CompoundNumber]

FROM [research].[PubsRecordCompound]
GO
