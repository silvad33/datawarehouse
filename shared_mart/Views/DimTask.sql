/*
Purpose:
*/
CREATE VIEW [shared_mart].[DimTask] AS

SELECT [TaskNumber],
	[TaskDescription],
	[TaskNumberDescription],
	[TaskDescriptionNumber],
	[Partition],
	[DataAreaID],
	[TaskKey]
FROM [dbo].[DimTask]
GO