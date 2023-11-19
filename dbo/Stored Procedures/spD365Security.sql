
CREATE PROCEDURE [dbo].[spD365Security] as

--select * from D365Security where NetworkAlias like 'jp%'
--select * from D365Admins
--jprasad@ionisph.com	All
--delete from D365Admins where NetworkAlias like 'jp%'

-- Rebuild D365 Security
truncate table D365Security

UPDATE ionisusers set entity='IONS' where ENTITy='IONIS'

insert into D365Security
select Entity, 
	username+'@'+
		case when entity='IONS' then 'ionisph.com' else 'akceatx.com' end,
		departmentid,null,null,null
from ionisusers

update D365Security
set DepartmentKey = (SELECT DepartmentKey FROM DimDepartment where DepartmentNumber=D365Security.Department)

update D365Security
set EntityKey = (SELECT EntityKey FROM DimEntity where EntityID=D365Security.Entity)

update D365Security
set SecurityKey = (SELECT SecurityMasterID 
					FROM D365SecurityMaster sm 
					where sm.departmentkey=D365Security.DepartmentKey and sm.entitykey=D365Security.EntityKey)

-- Delete any Admin records that may have already been entered
DELETE FROM D365Security WHERE NetworkAlias in (SELECT NetworkAlias FROM D365Admins)

-- Load Admins
insert into D365Security
select dsm.EntityID,dma.NetworkAlias, dsm.DepartmentNumber,dsm.EntityKey,dsm.DepartmentKey,dsm.SecurityMasterID
from D365SecurityMaster dsm, D365Admins dma
WHERE dma.Entity='All'

insert into D365Security
select dsm.EntityID,dma.NetworkAlias, dsm.DepartmentNumber,dsm.EntityKey,dsm.DepartmentKey,dsm.SecurityMasterID
from D365SecurityMaster dsm, D365Admins dma
WHERE dma.Entity='Akcea' and dsm.EntityID LIKE 'AK%'

-- Special code for Susan Readman
insert into D365Security
select dsm.EntityID,'SReadman@ionisph.com' as NetworkAlias, dsm.DepartmentNumber,dsm.EntityKey,dsm.DepartmentKey,dsm.SecurityMasterID
from D365SecurityMaster dsm
WHERE dsm.DepartmentNumber>='685' and dsm.DepartmentNumber<='795' and NOT dsm.DepartmentNumber='699' -- Exclude MFG



insert into D365Security
select entity,'KBurinskas@ionisph.com',Department,EntityKey,DepartmentKey,SecurityKey from D365Security
where NetworkAlias like '%ahug%'
and entity = 'ions'
and Department = '540'

union all

select entity,'BTruong@ionisph.com',Department,EntityKey,DepartmentKey,SecurityKey from D365Security
where NetworkAlias like '%ahug%'
and entity = 'ions'
and Department = '290'







