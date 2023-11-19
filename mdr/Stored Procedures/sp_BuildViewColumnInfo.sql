CREATE PROCEDURE [mdr].[sp_BuildViewColumnInfo] @dbName VARCHAR(500) AS

-- Exec mdr.sp_BuildViewColumnInfo 'IonisDW'

DECLARE @sql VARCHAR(1000)
 
--Delete previous column load info from supplied dbName
DELETE FROM  mdr.BIViewColumnInfo WHERE dbname= @dbName
--Reload column info.
SET @sql = 'INSERT INTO mdr.BIViewColumnInfo(DBName, SchemaName, ViewName, ColumnName, DataType, [Length], Scale, [Precision], Colorder,Object_id) '
SET @sql = @sql + 'SELECT ' + '''' + @dbName + '''' + ', s.name, o.name, c.name, t.name, c.length,c.xscale,c.xprec,c.colid,o.id  ' 
SET @sql = @sql + 'FROM ' + @dbName + '.sys.sysobjects o, ' + @dbName + '.sys.syscolumns c, ' + @dbName + '.sys.types t, ' + @dbName + '.sys.schemas s, ' 
SET @sql = @sql + 'mdr.BIViewInfo B WHERE o.xtype  = ' + '''' + 'V' + '''' + ' AND s.[schema_id] = o.uid AND c.id = o.id AND t.user_type_id = c.xtype AND '
SET @sql = @sql + 'b.ViewName collate database_default=o.name AND b.DBName collate database_default= ' + '''' + @dbName + '''' + ' AND b.SchemaName collate database_default=s.name ORDER BY o.name,c.colid, c.name'
EXEC (@sql)
--SELECT @sql
-- Repeat the column name initially
UPDATE mdr.BIViewColumnInfo SET newcolumnname=columnname WHERE dbname= @dbName
------DELETE Text, Image and NText datatypes
DELETE FROM mdr.BIViewColumnInfo WHERE datatype IN ('Text','Image','NText') AND dbname = @dbName
  








