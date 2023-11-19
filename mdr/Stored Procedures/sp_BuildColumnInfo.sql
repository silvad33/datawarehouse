CREATE PROCEDURE [mdr].[sp_BuildColumnInfo] @dbName VARCHAR(500) AS

INSERT INTO [mdr].[RSMLogit] ([RunProcess], RunCharName1, RunChar1) VALUES ('Start sp_BuildColumnInfo','DBName',@dbName)

-- Exec mdr.sp_BuildColumnInfo 'GayLea'

DECLARE @sql VARCHAR(1000)
DECLARE @tblName VARCHAR(500)
DECLARE @tblID int

--Delete previous column load info from supplied dbName
DELETE FROM  mdr.BIColumnInfo WHERE dbname= @dbName
--Reload column info.
SET @sql = 'INSERT INTO mdr.BIColumnInfo(DBName, SchemaName, TableName, ColumnName, DataType, [Length], Scale, [Precision], Colorder) '
SET @sql = @sql + 'SELECT ' + '''' + @dbName + '''' + ', s.name, o.name, c.name, t.name, c.length,c.xscale,c.xprec,c.colid ' 
SET @sql = @sql + 'FROM ' + @dbName + '.sys.sysobjects o, ' + @dbName + '.sys.syscolumns c, ' + @dbName + '.sys.types t, ' + @dbName + '.sys.schemas s, ' 
SET @sql = @sql + 'mdr.BITableInfo B WHERE o.xtype = ' + '''' + 'U' + '''' + ' AND s.[schema_id] = o.uid AND c.id = o.id AND t.user_type_id = c.xtype AND '
SET @sql = @sql + 'b.TableName=o.name AND b.DBName= ' + '''' + @dbName + '''' + ' AND b.SchemaName=s.name ORDER BY o.name,c.colid, c.name'
EXECUTE (@sql)
-- Repeat the column name initially
UPDATE mdr.BIColumnInfo SET newcolumnname=columnname WHERE dbname= @dbName
--DELETE Text, Image and NText datatypes
DELETE FROM mdr.BIColumnInfo WHERE datatype IN ('Text','Image','NText') AND dbname = @dbName

UPDATE mdr.BIColumnInfo
SET TableID=
(SELECT ID 
FROM mdr.BITableInfo t
where t.DBName=BIColumnInfo.DBName and
	t.SchemaName=BIColumnInfo.SchemaName and
	t.TableName=BIColumnInfo.TableName)

INSERT INTO [mdr].[RSMLogit] ([RunProcess], RunCharName1, RunChar1) VALUES ('End sp_BuildColumnInfo','DBName',@dbName)




