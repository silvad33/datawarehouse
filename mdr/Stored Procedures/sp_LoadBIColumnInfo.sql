
CREATE PROCEDURE [mdr].[sp_LoadBIColumnInfo] @dbName VARCHAR(500) AS

INSERT INTO [mdr].[RSMLogit] ([RunProcess], RunCharName1, RunChar1) VALUES ('Start sp_LoadBIColumnInfo','DBName',@dbName)

-- Exec mdr.sp_LoadBIColumnInfo 'RogueWave'
-- Select * from mdr.BiColumnInfo where datatype like '%Date%'

DECLARE @schemaName VARCHAR(50)
DECLARE @tableName VARCHAR(500)
DECLARE @columnName VARCHAR(50)
DECLARE @sql VARCHAR(1000)

-- Declare a cursor for the columns
DECLARE columninfocursor cursor for
	SELECT c.dbname,c.schemaname,c.tablename,c.columnname 
	FROM mdr.BIColumnInfo c, BITableInfo t
	WHERE NOT c.DataType IN ('text','image','bit','uniqueidentifier') AND
	t.DBName = c.DBName AND
	t.SchemaName = c.SchemaName AND
	t.TableName = c.TableName AND
	t.DBName = @dbName AND
	t.NumRows > 0 AND
	c.DistinctValueCount is NULL
FOR UPDATE

OPEN columninfocursor
FETCH NEXT FROM columninfocursor INTO @dbName, @schemaname, @tablename, @columnname

WHILE @@FETCH_STATUS=0
BEGIN
	-- Create and execute SQL to update DistinctValueCount
	SET @sql= 'UPDATE mdr.BIColumnInfo SET DistinctValueCount = (SELECT COUNT(DISTINCT "' + @columnname + '") FROM ' +
		@dbname+'.'+@schemaname+'."' + @tablename +
		'" WITH (NOLOCK)) WHERE DBName = ' + '''' + @dbName + '''' + ' AND ' +
		'SchemaName = ' + '''' + @schemaname + '''' + ' AND ' +
		'TableName = ' + '''' + @tablename + '''' + ' AND ' +
		'ColumnName = ' + '''' + @columnname + ''''

	BEGIN TRY  
    -- Generate divide-by-zero error.  
		exec (@sql)
	END TRY  
	BEGIN CATCH  
		-- Execute error retrieval routine.  
		Select @sql=''
	END CATCH; 
	---- Create and execute SQL to update MaxVal
	--SET @sql= 'UPDATE mdr.BIColumnInfo SET MaxVal = (SELECT MAX("' + @columnname + '") FROM ' +
	--	@dbName + '.' + @schemaname + '."' + @tablename +
	--	'" WITH (NOLOCK)) WHERE DBName = ' + '''' + @dbName + '''' + ' AND ' +
	--	'SchemaName = ' + '''' + @schemaname + '''' + ' AND ' +
	--	'TableName = ' + '''' + @tablename + '''' + ' AND ' +
	--	'ColumnName = ' + '''' + @columnname + ''''
	--BEGIN TRY  
 --   -- Generate divide-by-zero error.  
	--	exec (@sql)
	--END TRY  
	--BEGIN CATCH  
	--	-- Execute error retrieval routine.  
	--	Select @sql=''
	--END CATCH; 

	---- Create and execute SQL to update minval
	--SET @sql= 'UPDATE mdr.BIColumnInfo SET MinVal = (SELECT MIN("' + @columnname+'") FROM '+
	--	@dbName + '.' + @schemaname + '."' + @tablename +
	--	'" WITH (NOLOCK)) WHERE DBName = ' + '''' + @dbName + '''' + ' AND ' +
	--	'SchemaName =' + '''' + @schemaname + '''' + ' AND ' +
	--	'TableName =' + '''' + @tablename + '''' + ' AND ' +
	--	'columnname=' + '''' + @columnname + ''''
	--BEGIN TRY  
 --   -- Generate divide-by-zero error.  
	--	exec (@sql)
	--END TRY  
	--BEGIN CATCH  
	--	-- Execute error retrieval routine.  
	--	Select @sql=''
	--END CATCH; 

	---- Create and execute SQL to update Max Date
	--SET @sql= 'UPDATE mdr.BIColumnInfo SET MaxDate = (SELECT MAX("' + @columnname + '") FROM ' +
	--	@dbName + '.' + @schemaname + '."' + @tablename +
	--	'" WITH (NOLOCK)) WHERE DBName = ' + '''' + @dbName + '''' + ' AND ' +
	--	'SchemaName = ' + '''' + @schemaname + '''' + ' AND ' +
	--	'TableName = ' + '''' + @tablename + '''' + ' AND ' +
	--	'ColumnName = ' + '''' + @columnname + ''''+ ' AND ' +
	--	'DataType like ' +'''' + 'DATE%' + ''''
	--BEGIN TRY  
 --   -- Generate divide-by-zero error.  
	--	exec (@sql)
	--END TRY  
	--BEGIN CATCH  
	--	-- Execute error retrieval routine.  
	--	Select @sql=''
	--END CATCH; 

	---- Create and execute SQL to update NullRowsCount
	--SET  @sql= 'UPDATE mdr.BIColumnInfo SET NullRowsCount = (SELECT COUNT(*) FROM ' +
	--	@dbName + '.' + @schemaname+ '."' + @tablename +
	--	' " WITH (NOLOCK) WHERE "' + @columnname + '" is null) WHERE DBName = ' + '''' + @dbName + '''' + ' AND ' +
	--	'SchemaName = ' + '''' + @schemaname + '''' + ' AND ' +
	--	'TableName = ' + '''' + @tablename + '''' + ' AND ' +
	--	'ColumnName = ' + '''' + @columnname + ''''
	--BEGIN TRY  
 --   -- Generate divide-by-zero error.  
	--	exec (@sql)
	--END TRY  
	--BEGIN CATCH  
	--	-- Execute error retrieval routine.  
	--	Select @sql=''
	--END CATCH; 

	FETCH NEXT FROM columninfocursor INTO @dbName, @schemaname, @tablename, @columnname
end

CLOSE columninfocursor
DEALLOCATE columninfocursor

---- Set the pct of the time each column is null
--UPDATE mdr.BIColumnInfo 
--SET NullPCT=
--((NullRowsCount*1.00)/(SELECT NumRows FROM mdr.BITableInfo r 
--			WHERE mdr.BIColumnInfo.DBName = r.DBName AND
--				mdr.BIColumnInfo.SchemaName = r.SchemaName AND
--				mdr.BIColumnInfo.TableName = r.TableName))*100.00
--WHERE (SELECT NumRows FROM mdr.BITableInfo r 
--		WHERE mdr.BIColumnInfo.DBName = r.DBName AND
--			mdr.BIColumnInfo.SchemaName = r.SchemaName AND
--			mdr.BIColumnInfo.TableName = r.TableName) > 0 AND  DBName = @dbName

-- Set the primary key status
select top 1 @sql=
'update mdr.bicolumninfo 
set pkseq= 
(select max(index_column_id) from '+
mdr.bicolumninfo.dbname + '.sys.indexes i,' + 
mdr.bicolumninfo.dbname + '.sys.objects t,' +
mdr.bicolumninfo.dbname + '.sys.index_columns k,' +
mdr.bicolumninfo.dbname + '.sys.columns c
where c.object_id=t.object_id and
i.object_id=t.object_id and
k.index_id=i.index_id and
k.object_id=t.object_id and
k.column_id=c.column_id and
i.is_primary_key=1 and
c.name=mdr.bicolumninfo.columnname and
t.name=mdr.bicolumninfo.tablename)
where exists
(select * from '+
mdr.bicolumninfo.dbname + '.sys.indexes i,' + 
mdr.bicolumninfo.dbname + '.sys.objects t,' +
mdr.bicolumninfo.dbname + '.sys.index_columns k,' +
mdr.bicolumninfo.dbname + '.sys.columns c
where c.object_id=t.object_id and
i.object_id=t.object_id and
k.index_id=i.index_id and
k.object_id=t.object_id and
k.column_id=c.column_id and
i.is_primary_key=1 and
c.name=mdr.bicolumninfo.columnname and
t.name=mdr.bicolumninfo.tablename)' from mdr.bicolumninfo where dbname=@dbname
EXECUTE (@sql)

Update mdr.BIColumnInfo
set ColumnCount= null

Update mdr.BIColumnInfo
set ColumnCount=
(select COUNT(*) from mdr.BIColumnInfo C
where C.DBName=mdr.BIColumnInfo.DBName and
C.SchemaName=mdr.BIColumnInfo.SchemaName and
C.ColumnName=mdr.BIColumnInfo.ColumnName and
--C.TableName<>mdr.mdr.BIColumnInfo.TableName and
C.DistinctValueCount>0)
where DistinctValueCount>0

Update mdr.BITableInfo
set ColCount=
	isnull((select COUNT(*) 
	from mdr.BIColumnInfo c
	where c.DBName=mdr.BITableInfo.DBName and
	c.SchemaName=mdr.BITableInfo.SchemaName and
	c.TableName=mdr.BITableInfo.TableName),0)

Update mdr.BITableInfo
set PopColCount=
	isnull((select COUNT(*) 
	from mdr.BIColumnInfo c
	where c.DBName=mdr.BITableInfo.DBName and
	c.SchemaName=mdr.BITableInfo.SchemaName and
	c.TableName=mdr.BITableInfo.TableName and
	c.DistinctValueCount>1),0)
	
Update mdr.BIColumnInfo
set Description='NA', ETLNotes='NA'
where DistinctValueCount<=1

-- Set the maxdate for the table
UPDATE mdr.BITableInfo
SET MaxDate=
	(SELECT MAX(MaxDate)
	FROM mdr.BIColumnInfo c
	WHERE c.TableName=mdr.BITableInfo.TableName AND
	c.DataType LIKE 'DATE%')

INSERT INTO [mdr].[RSMLogit] ([RunProcess], RunCharName1, RunChar1) VALUES ('End sp_LoadBIColumnInfo','DBName',@dbName)
