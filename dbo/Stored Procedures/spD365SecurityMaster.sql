CREATE PROCEDURE spD365SecurityMaster as

-- Rebuild security master
TRUNCATE TABLE D365SecurityMaster
INSERT INTO D365SecurityMaster
SELECT DISTINCT d.DepartmentNumber,d.DepartmentKey,e.EntityID,e.EntityKey 
FROM DimDepartment d, DimEntity e