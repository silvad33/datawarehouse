
CREATE PROCEDURE [dbo].[spDimDepartment]
AS

UPDATE DimDepartment
SET DimDepartment.[DepartmentNumber] = z.[DepartmentNumber]
	,DimDepartment.[DepartmentDescription] = z.[DepartmentDescription]
	,DimDepartment.[DepartmentNumberDescription] = z.[DepartmentNumberDescription]
	,DimDepartment.[DepartmentDescriptionNumber] = z.[DepartmentDescriptionNumber]
	,DimDepartment.DepartmentIsActive=ISNULL(z.DepartmentIsActive,0)
FROM (
	SELECT DepartmentNumber
		,DepartmentDescription
		,CONCAT (
			DepartmentNumber
			,' - '
			,DepartmentDescription
			) DepartmentNumberDescription
		,CONCAT (
			DepartmentDescription
			,' ('
			,DepartmentNumber
			,')'
			) DepartmentDescriptionNumber
		,DepartmentIsActive
	FROM (
		SELECT DISTINCT DIMENSIONVALUE DepartmentNumber
			,dept.DESCRIPTION DepartmentDescription, 
			CASE WHEN ISSUSPENDED=1 THEN 0 ELSE 1 END as DepartmentIsActive
		FROM [dbo].[FinancialDimensionValueEntityStaging] Dept
		WHERE Dept.FINANCIALDIMENSION = 'Department'
		) z
	) z
WHERE z.departmentnumber = dimdepartment.departmentnumber

INSERT INTO DimDepartment (
	[DepartmentNumber]
	,[DepartmentDescription]
	,[DepartmentNumberDescription]
	,[DepartmentDescriptionNumber]
	,DepartmentIsActive
	)
SELECT DepartmentNumber
	,DepartmentDescription
	,CONCAT (
		DepartmentNumber
		,' - '
		,DepartmentDescription
		) DepartmentNumberDescription
	,CONCAT (
		DepartmentDescription
		,' ('
		,DepartmentNumber
		,')'
		) DepartmentDescriptionNumber
	,DepartmentIsActive
FROM (
	SELECT DISTINCT DIMENSIONVALUE DepartmentNumber
		,dept.DESCRIPTION DepartmentDescription, 
		CASE WHEN ISSUSPENDED=1 THEN 0 ELSE 1 END as DepartmentIsActive
	FROM [dbo].[FinancialDimensionValueEntityStaging] Dept
	WHERE Dept.FINANCIALDIMENSION = 'Department'
	) z
WHERE DepartmentNumber NOT IN (
		SELECT DISTINCT departmentnumber
		FROM dimdepartment
		)

UPDATE DimDepartment
SET DepartmentIsActive=0 WHERE DepartmentIsActive IS NULL





--		insert into DimDepartment([DepartmentNumber]
--      ,[DepartmentDescription]
--      ,[DepartmentNumberDescription]
--      ,[DepartmentDescriptionNumber]
--      ,[securitykey])

--SELECT DepartmentNumber
--	,DepartmentDescription
--	,CONCAT (
--		DepartmentNumber
--		,' - '
--		,DepartmentDescription
--		) DepartmentNumberDescription
--	,CONCAT (
--		DepartmentDescription
--		,' ('
--		,DepartmentNumber
--		,')'
--		) DepartmentDescriptionNumber
--		,securitykey
--FROM (
--	SELECT DISTINCT DIMENSIONVALUE DepartmentNumber
--		,dept.DESCRIPTION DepartmentDescription
--	FROM [dbo].[FinancialDimensionValueEntityStaging] Dept
--	WHERE Dept.FINANCIALDIMENSION = 'Department'
--	) z
--	left join [D365Security] d on d.department = z.DepartmentNumber
----123

