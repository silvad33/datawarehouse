CREATE Procedure [mdr].[sp_LoadForeignKeyInfo] @dbname varchar(50) as

INSERT INTO [mdr].[RSMLogit] ([RunProcess], RunCharName1, RunChar1) VALUES ('Start sp_LoadForeignKeyInfo','DBName',@dbName)

DECLARE @sql VARCHAR(5000)

--exec mdr.[sp_LoadForeignKeyInfo] 'RogueWave'
delete from mdr.BIForeignKeyInfo where dbname=@dbname

SET @sql = 'INSERT INTO mdr.BIForeignKeyInfo(DBName, SchemaName, Name, Childtable,childcolumnname,parenttable,parentcolumnname) '
SET @sql = @sql + 'SELECT ' + '''' + @dbName + '''' + ', s.name, fk.name,o2.name as childtable,c2.name as childcolumnname,o.name as parenttable,
	c.name as parentcolumnname ' 
SET @sql = @sql + 'FROM ' + @dbName + '.sys.foreign_keys fk, ' + @dbName + '.sys.objects o, ' + @dbName + '.sys.objects o2, ' + 
	@dbName + '.sys.foreign_key_columns fkc, '  + 
	@dbName + '.sys.columns c, '  + @dbName + '.sys.columns c2, '   + @dbName + '.sys.schemas s ' 
SET @sql = @sql + 'where o.object_id=fk.referenced_object_id and o2.object_id=fk.parent_object_id and c.object_id=o.object_id and '
SET @sql = @sql + 'c2.object_id=o2.object_id and fkc.constraint_object_id=fk.object_id and fkc.parent_object_id=fk.parent_object_id and '
SET @sql = @sql + 'fkc.referenced_object_id=fk.referenced_object_id and fkc.parent_column_id=c2.column_id and '
SET @sql = @sql + 'fkc.referenced_column_id=c.column_id'
--select @sql
EXECUTE (@sql)

Delete from mdr.BIForeignKeyInfo where SchemaName<>'mdr'

UPDATE mdr.BITableInfo
SET ChildInConstraintCount=
	ISNULL((SELECT COUNT(*)
	FROM mdr.BIForeignKeyInfo fk
	WHERE fk.DBName=BITableInfo.DBName and
	fk.childtable=BITableInfo.TableName),0)

UPDATE mdr.BITableInfo
SET ParentInConstraintCount=
	ISNULL((SELECT COUNT(*)
	FROM mdr.BIForeignKeyInfo fk
	WHERE fk.DBName=BITableInfo.DBName and
	fk.parenttable=BITableInfo.TableName),0)

INSERT INTO [mdr].[RSMLogit] ([RunProcess], RunCharName1, RunChar1) VALUES ('End sp_LoadForeignKeyInfo','DBName',@dbName)
