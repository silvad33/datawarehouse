
CREATE PROCEDURE [mdr].[sp_LoadTableInfo] @dbName VARCHAR(500) AS

INSERT INTO [mdr].[RSMLogit] ([RunProcess], RunCharName1, RunChar1) VALUES ('Start sp_LoadTableInfo','DBName',@dbName)

-- Exec mdr.sp_LoadTableInfo 'GayLea'

DECLARE @sql VARCHAR(1000)
DECLARE @tblName VARCHAR(500)
DECLARE @tblID int

--Initial insert for user tables in the db name passed.
SET @sql = 'INSERT INTO mdr.BITableInfo (DBName, SchemaName, TableName) SELECT ' + '''' + @dbName + '''' + ', ' + 's.name, o.name ' 
SET @sql = @sql + 'FROM ' + @dbName + '.sys.sysobjects o, '+ @dbName + '.sys.schemas s ' 
SET @sql = @sql + 'WHERE s.schema_id=o.uid AND o.xtype= ' + '''' + 'U' + '''' + ' AND '--s.name = ' + '''' + 'mdr' + '''' + ' AND '
SET @sql = @sql + 'NOT o.name like ' + '''' + 'sys%' + '''' + ' AND '
SET @sql = @sql + 'NOT o.name like ' + '''' + 'temp%' + '''' + ' AND '
SET @sql = @sql + 'NOT o.name like ' + '''' + 'sync%' + '''' + ' ORDER BY o.name'
EXECUTE (@sql)

--Updates BITableInfo with the current row count.
DECLARE tbl_cursor CURSOR FOR 
	SELECT [ID], DBName + '.' + SchemaName + '."' + TableName + '"' FROM mdr.BITableInfo WHERE DBName = @dbName

OPEN tbl_cursor
FETCH NEXT FROM tbl_cursor INTO @tblID, @tblName
WHILE @@FETCH_STATUS = 0   
BEGIN  
	SET @sql = 'UPDATE mdr.BITableInfo SET NumRows = (SELECT COUNT(*) FROM ' + @tblName + ' WITH (NOLOCK)) WHERE [ID] = ' + CAST(@tblID AS VARCHAR(10)) 
	EXECUTE (@sql)
	FETCH NEXT FROM tbl_cursor INTO @tblID, @tblName   
END   

CLOSE tbl_cursor   
DEALLOCATE tbl_cursor 

--Updates BITableInfo for HasPK.
SET @sql = 'UPDATE mdr.BITableInfo SET HasPK = ' + '''' + 'YES' + '''' + ' WHERE DBName = ' + '''' + @dbName + ''''
SET @sql =  @sql + ' AND SchemaName = ' + '''' + 'mdr' + '''' + ' AND TableName IN	(SELECT o.name FROM ' + @dbName + '.sys.sysobjects o, '
SET @sql =  @sql + @dbName + '.sys.schemas s WHERE [ID] IN (SELECT parent_obj FROM ' + @dbName + '.sys.sysobjects WHERE '
SET @sql =  @sql + 'xtype = ' + '''' + 'PK' + '''' + ') AND s.schema_id=o.uid AND o.xtype= ' + '''' + 'U' + ''''
SET @sql =  @sql + ' AND s.name = ' + '''' + 'mdr' + '''' + ' AND NOT o.name like ' + '''' + 'sys%' + ''''
SET @sql =  @sql + ' AND NOT o.name like ' + '''' + 'temp%' + '''' + ')'
EXECUTE (@sql)

Update mdr.BITableInfo 
Set Description='Not Populated', IncludeExclude='E' where NumRows=0

INSERT INTO [mdr].[RSMLogit] ([RunProcess], RunCharName1, RunChar1) VALUES ('End sp_LoadTableInfo','DBName',@dbName)
