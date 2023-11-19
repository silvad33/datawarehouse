
CREATE PROCEDURE [dbo].[spDimTask]
AS
UPDATE DimTask
SET dimtask.[TaskNumber] = z.[TaskNumber]
	,dimtask.[TaskDescription] = z.[TaskDescription]
	,dimtask.[TaskNumberDescription] = z.[TaskNumberDescription]
	,dimtask.[TaskDescriptionNumber] = z.[TaskDescriptionNumber]
	,dimtask.[Partition] = z.[Partition]
	,dimtask.[DataAreaID] = z.[DataAreaID]
FROM (
	SELECT TaskNumber
		,Task.DESCRIPTION TaskDescription
		,CONCAT (
			TaskNumber
			,' - '
			,Task.DESCRIPTION
			) TaskNumberDescription
		,CONCAT (
			Task.DESCRIPTION
			,' ('
			,TaskNumber
			,')'
			) TaskDescriptionNumber
		,z.[Partition]
		,[DataAreaID]
	FROM (
		SELECT DISTINCT [Task] TaskNumber
			--,
			,D.[Partition]
			,[DataAreaID]
		FROM [dbo].[DisplayValueExplosion] D
		) z
	LEFT JOIN [dbo].[FinancialDimensionValueEntityStaging] Task ON task.DIMENSIONVALUE = z.TaskNumber
		AND z.PARTITION = task.PARTITION
		AND task.FINANCIALDIMENSION = 'TASK'
	) z
WHERE z.TaskNumber = dimtask.TaskNumber
	AND z.DataAreaID = dimtask.DataAreaID
	AND z.PARTITION = dimtask.PARTITION

INSERT INTO DimTask (
	[TaskNumber]
	,[TaskDescription]
	,[TaskNumberDescription]
	,[TaskDescriptionNumber]
	,[Partition]
	,[DataAreaID]
	)
SELECT TaskNumber
	,Task.DESCRIPTION TaskDescription
	,CONCAT (
		TaskNumber
		,' - '
		,Task.DESCRIPTION
		) TaskNumberDescription
	,CONCAT (
		Task.DESCRIPTION
		,' ('
		,TaskNumber
		,')'
		) TaskDescriptionNumber
	,z.[Partition]
	,[DataAreaID]
FROM (
	SELECT DISTINCT [Task] TaskNumber
		--,
		,D.[Partition]
		,[DataAreaID]
	FROM [dbo].[DisplayValueExplosion] D
	) z
LEFT JOIN [dbo].[FinancialDimensionValueEntityStaging] Task ON task.DIMENSIONVALUE = z.TaskNumber
	AND z.PARTITION = task.PARTITION
	AND task.FINANCIALDIMENSION = 'TASK'
WHERE CONCAT (
		dataareaid
		,'-'
		,tasknumber
		) NOT IN (
		SELECT DISTINCT CONCAT (
				dataareaid
				,'-'
				,tasknumber
				)
		FROM DimTask
		)