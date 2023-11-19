CREATE VIEW [research_mart].[DimTarget] AS 
SELECT 
	[ID],
	[PubsKey],
	[Ensembl_Id],
	[SelectedTerm]
FROM [research].[PubsRecordTarget]
GO
