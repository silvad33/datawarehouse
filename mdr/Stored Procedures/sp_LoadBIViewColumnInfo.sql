CREATE PROCEDURE [mdr].[sp_LoadBIViewColumnInfo] @dbName VARCHAR(500) AS

-- Exec mdr.sp_LoadBIViewColumnInfo 'AxDB'

DECLARE @schemaName VARCHAR(50)
DECLARE @ViewName VARCHAR(50)
DECLARE @columnName VARCHAR(50)
DECLARE @sql VARCHAR(1000)

-- Zero out values to be set
UPDATE mdr.BIViewColumnInfo 
	SET DistinctValueCount = 0, 
		NullRowsCount=0, 
		NullPct=0, 
		PKSeq=0 
WHERE DBName = @dbName
-- Declare a cursor for the columns
DECLARE columninfocursor cursor for
	SELECT c.dbname,c.schemaname,c.ViewName,c.columnname 
	FROM mdr.BIViewColumnInfo c, BIViewInfo t
	WHERE NOT c.DataType IN ('text','image','bit','uniqueidentifier') AND
	t.DBName = c.DBName AND
	t.SchemaName = c.SchemaName AND
	t.ViewName = c.ViewName AND
	t.DBName = @dbName AND
	t.NumRows > 0 AND
	c.DistinctValueCount = 0 AND
	c.NullRowsCount=0
FOR UPDATE
 

OPEN columninfocursor
FETCH NEXT FROM columninfocursor INTO @dbName, @schemaname, @ViewName, @columnname

WHILE @@FETCH_STATUS=0
BEGIN
	-- Create and execute SQL to update DistinctValueCount
	SET @sql= 'UPDATE mdr.BIViewColumnInfo SET DistinctValueCount = (SELECT COUNT(DISTINCT "' + @columnname + '") FROM ' +
		@dbname+'.'+@schemaname+'."' + @ViewName +
		'") WHERE DBName = ' + '''' + @dbName + '''' + ' AND ' +
		'SchemaName = ' + '''' + @schemaname + '''' + ' AND ' +
		'ViewName = ' + '''' + @ViewName + '''' + ' AND ' +
		'ColumnName = ' + '''' + @columnname + ''''
	EXECUTE (@sql)
	-- Create and execute SQL to update MaxVal
	--SET @sql= 'UPDATE mdr.BIViewColumnInfo SET MaxVal = (SELECT MAX("' + @columnname + '") FROM ' +
	--	@dbName + '.' + @schemaname + '."' + @ViewName +
	--	'") WHERE DBName = ' + '''' + @dbName + '''' + ' AND ' +
	--	'SchemaName = ' + '''' + @schemaname + '''' + ' AND ' +
	--	'ViewName = ' + '''' + @ViewName + '''' + ' AND ' +
	--	'ColumnName = ' + '''' + @columnname + ''''
	--EXECUTE (@sql)
	---- Create and execute SQL to update minval
	--SET @sql= 'UPDATE mdr.BIViewColumnInfo SET MinVal = (SELECT MIN("' + @columnname+'") FROM '+
	--	@dbName + '.' + @schemaname + '."' + @ViewName +
	--	'") WHERE DBName = ' + '''' + @dbName + '''' + ' AND ' +
	--	'SchemaName =' + '''' + @schemaname + '''' + ' AND ' +
	--	'ViewName =' + '''' + @ViewName + '''' + ' AND ' +
	--	'columnname=' + '''' + @columnname + ''''
	--EXECUTE (@sql)
	---- Create and execute SQL to update NullRowsCount
	--SET  @sql= 'UPDATE mdr.BIViewColumnInfo SET NullRowsCount = (SELECT COUNT(*) FROM ' +
	--	@dbName + '.' + @schemaname+ '."' + @ViewName +
	--	'" WHERE "' + @columnname + '" is null) WHERE DBName = ' + '''' + @dbName + '''' + ' AND ' +
	--	'SchemaName = ' + '''' + @schemaname + '''' + ' AND ' +
	--	'ViewName = ' + '''' + @ViewName + '''' + ' AND ' +
	--	'ColumnName = ' + '''' + @columnname + ''''
	--EXECUTE (@sql)
	FETCH NEXT FROM columninfocursor INTO @dbName, @schemaname, @ViewName, @columnname
end

CLOSE columninfocursor
DEALLOCATE columninfocursor

---- Set the pct of the time each column is null
--UPDATE mdr.BIViewColumnInfo 
--SET NullPCT=
--((NullRowsCount*1.00)/(SELECT NumRows FROM BIViewInfo r 
--			WHERE mdr.BIViewColumnInfo.DBName = r.DBName AND
--				mdr.BIViewColumnInfo.SchemaName = r.SchemaName AND
--				mdr.BIViewColumnInfo.ViewName = r.ViewName))*100.00
--WHERE (SELECT NumRows FROM mdr.BIViewInfo r 
--		WHERE mdr.BIViewColumnInfo.DBName = r.DBName AND
--			mdr.BIViewColumnInfo.SchemaName = r.SchemaName AND
--			mdr.BIViewColumnInfo.ViewName = r.ViewName) > 0 AND  DBName = @dbName


UPDATE mdr.BIViewColumnInfo
SET ViewID=
	(SELECT ID FROM mdr.BIViewInfo v 
	where v.dbname=mdr.BIViewColumnInfo.dbname and
	v.schemaname=mdr.BIViewColumnInfo.schemaname and
	v.viewname=mdr.BIViewColumnInfo.viewname)
