CREATE Procedure [mdr].[FindBIDiscinctValues] @dbname varchar(100),@datatype varchar(50),@length int, @value varchar(200) as

--FindBIDiscinctValues 'OMNIA_EIOC_P_IOC_CM','NVarchar',40,'CIC/OCN Exception'

declare @schemaname varchar(50),@tablename varchar(50),@columnname varchar(50),
	@sql varchar(1000)

-- Declare a cursor for the columns
declare columninfocursor cursor for
select c.dbname,c.schemaname,c.tablename,c.columnname 
from mdr.bicolumninfo c,mdr.BITableInfo t
where c.datatype =@datatype and
c.length=@length and
t.dbname=c.dbname and
t.schemaname=c.schemaname and
t.tablename=c.tablename and
t.dbname = @dbname and
t.NumRows>0 and
t.NumRows<1000000 and
c.DistinctValueCount>99 -- the others are in distinct value table
for update

truncate table mdr.BIFindDistinctValues

open columninfocursor
fetch next from columninfocursor into @dbname,@schemaname,@tablename,@columnname

while @@FETCH_STATUS=0
begin
	-- Create and execute SQL to update distinctvaluecount
	select @sql= 'insert into mdr.BIFindDistinctValues select distinct ' + ''''+@dbname+''''+ +','+''''+
		@schemaname+''''+','+''''+@tablename+''''+','+''''+@columnname+''''+',"'+
		@columnname+'" from '+
		@dbname+'.'+@schemaname+'."'+@tablename+
		'" where  "'+ @columnname+'"='+''''+@value+''''

--	select @sql
	exec (@sql)
--	break
	fetch next from columninfocursor into @dbname,@schemaname,@tablename,@columnname
end
close columninfocursor
deallocate columninfocursor








