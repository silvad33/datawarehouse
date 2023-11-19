CREATE PROCEDURE [mdr].[sp_BIDependencies] @dbName VARCHAR(500) AS

INSERT INTO [mdr].[RSMLogit] ([RunProcess], RunCharName1, RunChar1) VALUES ('Start sp_BIDependencies','DBName',@dbName)

-- Exec mdr.[sp_BIDependencies] 'RogueWave'
-- SELECT * FROM mdr.BIDependencies where dbname='RogueWave'
 
DECLARE @sql VARCHAR(max)

DELETE FROM mdr.BIDependencies
WHERE DBName = @dbName

--drop table BIDependencies
SET @sql=
'INSERT  INTO mdr.BIDependencies select '+ '''' + @dbname  + '''' + ' as DBname, d.object_id,
o.name as ObjectName,o.type_desc as ObjectType, t.name as TableName,t.type_desc as TableType,
c.name as ColumnName,d.is_select_all as IS_SELECTED_ALL,d.is_updated as IS_UPDATED,d.is_selected as IS_SELECTED
from ' + @dbname + '.sys.sql_dependencies d
left join ' + @dbname + '.sys.objects o on o.object_id=d.object_id
left join ' + @dbname + '.sys.objects t on t.object_id=d.referenced_major_id
left join ' + @dbname + '.sys.all_columns c on c.object_id=t.object_id and c.column_id=d.referenced_minor_id'

--select * from sys.sql_dependencies where object_id=770101784
--select * from sys.objects where name like 'sp%fct%'

EXECUTE (@sql)

UPDATE mdr.BITableInfo
SET NumberOfDependencies=
	ISNULL((SELECT COUNT(DISTINCT ObjectName)
	FROM mdr.BIDependencies d
	WHERE d.DBname=BITableInfo.DBName and
		d.ReferencedObject=BITableInfo.TableName),0)

INSERT INTO [mdr].[RSMLogit] ([RunProcess], RunCharName1, RunChar1) VALUES ('End sp_BIDependencies','DBName',@dbName)
