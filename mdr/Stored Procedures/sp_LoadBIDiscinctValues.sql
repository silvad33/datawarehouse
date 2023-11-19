CREATE Procedure [mdr].[sp_LoadBIDiscinctValues] @dbname varchar(100), @valuecount int as

INSERT INTO [mdr].[RSMLogit] ([RunProcess], RunCharName1, RunChar1) VALUES ('Start sp_LoadBIDiscinctValues','DBName',@dbName)

--mdr.sp_LoadBIDiscinctValues 'RogueWave', 1000

declare @schemaname varchar(50),@tablename varchar(500),@columnname varchar(50),
	@sql varchar(1000),@datatype varchar(50)

-- Zero out values to be set
--delete from BIDistinctValues where dbname=@dbname

-- Declare a cursor for the columns
declare columninfocursor cursor for
select c.dbname,c.schemaname,c.tablename,c.columnname,c.datatype
from mdr.bicolumninfo c,mdr.BITableInfo t
where not c.datatype in ('text','image','bit','binary','uniqueidentifier') and
t.dbname=c.dbname and
t.schemaname=c.schemaname and
t.tablename=c.tablename and
t.dbname = @dbname and
t.NumRows>0 and 
c.DistinctValueCount>1 and
--c.Length<300 and
c.DistinctValueCount<@valuecount -- ajdust as needed
and not exists (select * from mdr.BIDistinctValues v where v.dbname=c.dbname and v.schemaname=c.schemaname and v.TableName=c.TableName and v.columnname=c.columnname)
order by c.tablename,c.columnname
for update

open columninfocursor
fetch next from columninfocursor into @dbname,@schemaname,@tablename,@columnname,@datatype

while @@FETCH_STATUS=0
begin
	-- Create and execute SQL to update distinctvaluecount
	if not @datatype in('decimal','datetime','int','bigint','smallint','float','tinyint','numeric','smalldatetime','money','real')
	begin
		select @sql= 'Insert into mdr.BIDistinctValues select ' + ''''+@dbname+''''+ +','+''''+
			@schemaname+''''+','+''''+@tablename+''''+','+''''+@columnname+''''+', substring("'+
			@columnname+'",1,200), count(*),0 from '+
			@dbname+'.'+@schemaname+'."'+@tablename+
			'" WITH (NOLOCK) group by  substring("'+ @columnname+'",1,200)'
	end
	else
	begin
		select @sql= 'Insert into mdr.BIDistinctValues select ' + ''''+@dbname+''''+ +','+''''+
		@schemaname+''''+','+''''+@tablename+''''+','+''''+@columnname+''''+', "'+
		@columnname+'", count(*),0 from '+
		@dbname+'.'+@schemaname+'."'+@tablename+
		'" WITH (NOLOCK) group by  "'+ @columnname+'"'
	end

	exec (@sql)

	fetch next from columninfocursor into @dbname,@schemaname,@tablename,@columnname,@datatype
end
close columninfocursor
deallocate columninfocursor

UPDATE mdr.BIDistinctValues
SET ColumnID=
	(SELECT ID
	FROM mdr.BIColumnInfo c
	WHERE c.DBName=mdr.BIDistinctValues.DBName and
		c.SchemaName=mdr.BIDistinctValues.SchemaName and
		c.TableName=mdr.BIDistinctValues.TableName and
		c.ColumnName=mdr.BIDistinctValues.ColumnName)

INSERT INTO [mdr].[RSMLogit] ([RunProcess], RunCharName1, RunChar1) VALUES ('End sp_LoadBIDiscinctValues','DBName',@dbName)
