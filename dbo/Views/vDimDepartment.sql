
CREATE VIEW vDimDepartment AS

select D.DepartmentNumber, D.DepartmentDescription, D.DepartmentNumberDescription, D.DepartmentDescriptionNumber,
  CASE WHEN ISNULL(IU.DepartmentKey,'') = '' THEN 0 ELSE 1 END AS IonisDepartment,
  CASE WHEN ISNULL(AU.DepartmentKey,'') = '' THEN 0 ELSE 1 END AS AkceaDepartment
from DimDepartment AS D
left outer join (
	SELECT DISTINCT DepartmentKey
	FROM DimUser
	WHERE CompanyCode = 'IONS') AS IU on D.DepartmentKey = IU.DepartmentKey
left outer join (
	SELECT DISTINCT DepartmentKey
	FROM DimUser
	WHERE CompanyCode LIKE 'AK%') AS AU on D.DepartmentKey = AU.DepartmentKey
