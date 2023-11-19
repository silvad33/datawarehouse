
CREATE PROCEDURE [mdr].[sp_LoadViewInfo] @dbName VARCHAR(500) AS

-- Exec mdr.[sp_LoadViewInfo] 'AxDB'

DELETE from mdr.BIViewInfo where DBName=@dbName

DECLARE @sql VARCHAR(1000)
DECLARE @vwName VARCHAR(500)
DECLARE @vwID int

--Initial insert for user tables in the db name passed.
SET @sql = 'INSERT INTO mdr.BIViewInfo (DBName, SchemaName, ViewName) SELECT ' + '''' + @dbName + '''' + ', ' + 's.name, o.name ' 
SET @sql = @sql + 'FROM ' + @dbName + '.sys.sysobjects o, '+ @dbName + '.sys.schemas s, ' + @dbName + '.sys.objects so ' 
SET @sql = @sql + 'WHERE s.schema_id=o.uid AND o.id = so.object_id AND o.xtype= ' + '''' + 'V' + '''' + ' AND s.name <> ' + '''' + 'mdr' + '''' + ' AND '
SET @sql = @sql + 'NOT o.name like ' + '''' + 'sys%' + '''' + ' AND '
SET @sql = @sql + 'NOT o.name like ' + '''' + 'temp%' + '''' + ' AND '
SET @sql = @sql + 'NOT o.name like ' + '''' + 'sync%' + '''' + ' ORDER BY o.name'
EXECUTE (@sql)

DECLARE vw_cursor CURSOR FOR 
	SELECT [ID], DBName + '.' + SchemaName + '.' + ViewName FROM mdr.BIViewInfo WHERE DBName = @dbName and not ViewName in ('DelTek_LU_custEngineeringStatus','DelTek_LU_custLEEDGoal')

OPEN vw_cursor
FETCH NEXT FROM vw_cursor INTO @vwID, @vwName
WHILE @@FETCH_STATUS = 0   
BEGIN  
	SET @sql = 'UPDATE mdr.BIViewInfo SET NumRows = (SELECT COUNT(*) FROM ' + @vwName + ') WHERE [ID] = ' + CAST(@vwID AS VARCHAR(10)) 
	EXECUTE (@sql)
	FETCH NEXT FROM vw_cursor INTO @vwID, @vwName   
END   

CLOSE vw_cursor   
DEALLOCATE vw_cursor 
 

Update mdr.BIViewInfo 
Set Description='Not Populated', IncludeExclude='E' where NumRows=0

UPDATE mdr.BIViewInfo
SET DependencyID=
	(SELECT TOP 1 d.ObjectID
	FROM mdr.BIDependencies d
	WHERE d.DBname=mdr.BIViewInfo.DBname and d.ObjectName=mdr.BIViewInfo.ViewName)




