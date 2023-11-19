CREATE PROCEDURE [dbo].[spDimProject] as

/****** Script for SelectTopNRows command from SSMS  ******/
UPDATE Dimproject
SET Dimproject.[ProjectNumber] = z.[ProjectNumber]
	,Dimproject.[ProjectDescription] = z.[ProjectDescription]
	,Dimproject.[ProjectNumberDescription] = z.[ProjectNumberDescription]
	,Dimproject.[ProjectDescriptionNumber] = z.[ProjectDescriptionNumber]
	,Dimproject.[Partition] = z.[Partition]
	,Dimproject.[DataAreaID] = z.[DataAreaID]
	,Dimproject.ProjectIsActive = z.ProjectIsActive
FROM (
	SELECT ProjectNumber
		,ProjectDescription
		,CONCAT (
			ProjectNumber
			,' - '
			,ProjectDescription
			) ProjectNumberDescription
		,CONCAT (
			ProjectDescription
			,' ('
			,ProjectNumber
			,')'
			) ProjectDescriptionNumber
		,PARTITION
		,DataAreaID
		,ProjectIsActive
	FROM (
		SELECT DISTINCT [Project] ProjectNumber
			,Proj.DESCRIPTION ProjectDescription
			,D.[Partition]
			,[DataAreaID]
			,CASE WHEN proj.ISSUSPENDED=0 THEN 1 ELSE 0 END as ProjectIsActive 
		FROM [dbo].[DisplayValueExplosion] D
		LEFT JOIN [dbo].[FinancialDimensionValueEntityStaging] Proj ON Proj.DIMENSIONVALUE = D.Project
			AND D.PARTITION = Proj.PARTITION
			AND Proj.FINANCIALDIMENSION = 'PROJECT'
		) z
	) z
WHERE z.projectnumber = dimproject.projectnumber
	AND z.dataareaid = dimproject.dataareaid
	AND z.PARTITION = dimproject.PARTITION

INSERT INTO DimProject (
	[ProjectNumber]
	,[ProjectDescription]
	,[ProjectNumberDescription]
	,[ProjectDescriptionNumber]
	,[Partition]
	,[DataAreaID]
	,ProjectIsActive
	)
SELECT ProjectNumber
	,ProjectDescription
	,CONCAT (
		ProjectNumber
		,' - '
		,ProjectDescription
		) ProjectNumberDescription
	,CONCAT (
		ProjectDescription
		,' ('
		,ProjectNumber
		,')'
		) ProjectDescriptionNumber
	,PARTITION
	,DataAreaID
	,ProjectIsActive
FROM (
	SELECT DISTINCT [Project] ProjectNumber
		,Proj.DESCRIPTION ProjectDescription
		,D.[Partition]
		,[DataAreaID]
		,CASE WHEN proj.ISSUSPENDED=0 THEN 1 ELSE 0 END as ProjectIsActive 
	FROM [dbo].[DisplayValueExplosion] D
	LEFT JOIN [dbo].[FinancialDimensionValueEntityStaging] Proj ON Proj.DIMENSIONVALUE = D.Project
		AND D.PARTITION = Proj.PARTITION
		AND Proj.FINANCIALDIMENSION = 'PROJECT'
	) z
WHERE CONCAT (
		dataareaid
		,'-'
		,projectnumber
		) NOT IN (
		SELECT DISTINCT CONCAT (
				dataareaid
				,'-'
				,projectnumber
				)
		FROM dimproject
		)

update dimproject 
set projectid = z.projectnumber
from(SELECT ProjectKey, dbo.udf_extractInteger(ProjectDescription) AS ProjectNumber
	FROM DimProject
	) z where z.ProjectKey = DimProject.ProjectKey

update dimproject 
set projectid = 0
WHERE projectid is null


update dimproject 
set ProjectIsActive = 0
WHERE ProjectIsActive is null