CREATE VIEW [shared_mart].[DimDepartment] AS

select D.DepartmentNumber, D.DepartmentDescription, D.DepartmentNumberDescription, D.DepartmentDescriptionNumber, D.DepartmentKey,DepartmentIsActive,
  CASE WHEN ISNULL(IU.DepartmentKey,'') = '' THEN 0 ELSE 1 END AS IonisDepartment,
  CASE WHEN ISNULL(AU.DepartmentKey,'') = '' THEN 0 ELSE 1 END AS AkceaDepartment
from [dbo].[DimDepartment] AS D
left outer join (
	SELECT DISTINCT DepartmentKey
	FROM [dbo].[DimUser]
	WHERE CompanyCode = 'IONS') AS IU on D.DepartmentKey = IU.DepartmentKey
left outer join (
	SELECT DISTINCT DepartmentKey
	FROM [dbo].[DimUser]
	WHERE CompanyCode LIKE 'AK%') AS AU on D.DepartmentKey = AU.DepartmentKey
GO
