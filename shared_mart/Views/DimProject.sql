/*
Purpose:
*/
CREATE VIEW [shared_mart].[DimProject] AS

SELECT [ProjectNumber],
	[ProjectDescription],
	[ProjectNumberDescription],
	[ProjectDescriptionNumber],
	[Partition],
	[DataAreaID],
	[ProjectKey],
	[ProjectID],
	[ProjectIsActive]
FROM [dbo].[DimProject]
GO