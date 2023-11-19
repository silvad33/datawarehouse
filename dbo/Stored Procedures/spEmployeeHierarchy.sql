CREATE PROCEDURE [dbo].[spEmployeeHierarchy] as

--select * from AliceTempSecurity where NetworkAlias like 'jp%'
--select * from EmployeeHierarchy where ReportsToEMail like 'jp%'

TRUNCATE Table EmployeeHierarchy

insert into EmployeeHierarchy
  select distinct u.Email as ReportsToEMail,u.FullName as EmployeeFullName, d.DepartmentNumber, 
	u.FullName+'-'+Convert(varchar(50),d.DepartmentNumber) as SecurityKey
	from FACTCOMMITMENTS AS FC
  join DIMUser u on u.[UserKey]=fc.RequesterKey
  join DimDepartment d on d.DepartmentKey=fc.departmentkey
  

insert into EmployeeHierarchy
  select distinct s.NetworkAlias as ReportsToEMail, 
	u.FullName as EmployeeFullName, d.DepartmentNumber, 
	u.FullName +'-'+Convert(varchar(50),d.DepartmentNumber) as SecurityKey
  from AliceTempSecurity s
  
  join DimEntity e on e.EntityID=s.Entity
  join DimDepartment d on d.DepartmentNumber=s.DepartmentID and ISNUMERIC(DepartmentNumber)=1
  --Note on 9/17/2020 Harry Chen Commented the following two lines and add different DimUser join to get user FullName
  join FACTCOMMITMENTS fc on fc.Entity=s.Entity and fc.DepartmentKey=d.DepartmentKey and not fc.RequesterKey is NULL
  join DIMUser u on u.[UserKey]=fc.RequesterKey
  --join DIMUser u on lower(u.Email)=lower(s.NetworkAlias) --This is required to get correct FullName from DimUser table instead of the input file
  where not exists 
	(select * from EmployeeHierarchy eh
	where eh.ReportsToEMail=s.NetworkAlias and
	eh.EmployeeFullName=u.FullName and
	eh.SecurityKey=u.FullName+'-'+Convert(varchar(50),d.DepartmentNumber))

-- Don't include akcea accounts
DELETE FROM EmployeeHierarchy WHERE ReportsToEMail like '%akcea%'

-- Set to the long email in security table
UPDATE EmployeeHierarchy
SET ReportsToEMail=
	(SELECT [FinalEmployeeEmail]
	FROM [dbo].[AliceTempLongShortEmails] ae
	WHERE ae.EmployeeEmail=EmployeeHierarchy.ReportsToEMail)
WHERE EXISTS
	(SELECT [FinalEmployeeEmail]
	FROM [dbo].[AliceTempLongShortEmails] ae
	WHERE ae.EmployeeEmail=EmployeeHierarchy.ReportsToEMail)
