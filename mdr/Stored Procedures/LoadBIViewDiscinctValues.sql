CREATE Procedure [mdr].[LoadBIViewDiscinctValues] @dbname varchar(100), @valuecount int as

--mdr.LoadBIViewDiscinctValues 'AxDB', 10000

declare @schemaname varchar(50),@Viewname varchar(50),@columnname varchar(50),
	@sql varchar(1000),@datatype varchar(50)

-- Zero out values to be set
delete from mdr.BIViewDistinctValues where dbname=@dbname
--select * from mdr.BIViewDistinctValues

-- Declare a cursor for the columns
declare columninfocursor cursor for
select c.dbname,c.schemaname,c.Viewname,c.columnname,c.datatype
from mdr.biViewcolumninfo c,mdr.BIViewInfo t
where not c.datatype in ('text','image','bit','binary','uniqueidentifier') and
t.dbname=c.dbname and
t.schemaname=c.schemaname and
t.Viewname=c.Viewname and
t.dbname = @dbname and
t.NumRows>0 and 
c.DistinctValueCount>1 and
c.Length<10000 and
c.DistinctValueCount<@valuecount -- ajdust as needed
and not exists (select * from mdr.BIViewDistinctValues v where v.dbname=c.dbname and v.schemaname=c.schemaname and v.ViewName=c.ViewName and v.columnname=c.columnname)
order by c.Viewname,c.columnname
for update

open columninfocursor
fetch next from columninfocursor into @dbname,@schemaname,@Viewname,@columnname,@datatype

while @@FETCH_STATUS=0
begin
	-- Create and execute SQL to update distinctvaluecount
	if not @datatype in('decimal','datetime','int','smallint','float','tinyint','numeric','smalldatetime','money','real','bigint')
	begin
		select @sql= 'Insert into mdr.BIViewDistinctValues select ' + ''''+@dbname+''''+ +','+''''+
			@schemaname+''''+','+''''+@Viewname+''''+','+''''+@columnname+''''+', substring("'+
			@columnname+'",1,200), 0, count(*) from '+
			@dbname+'.'+@schemaname+'."'+@Viewname+
			'" group by  substring("'+ @columnname+'",1,200)'
	end
	else
	begin
		select @sql= 'Insert into mdr.BIViewDistinctValues select ' + ''''+@dbname+''''+ +','+''''+
		@schemaname+''''+','+''''+@Viewname+''''+','+''''+@columnname+''''+', "'+
		@columnname+'", 0, count(*) from '+
		@dbname+'.'+@schemaname+'."'+@Viewname+
		'" group by  "'+ @columnname+'"'
	end

	--select @sql
	exec (@sql)
	--break
	fetch next from columninfocursor into @dbname,@schemaname,@Viewname,@columnname,@datatype
end
close columninfocursor
deallocate columninfocursor

UPDATE mdr.BIViewDistinctValues
SET ViewColumnID=
	(SELECT v.ID
	FROM BIViewColumnInfo v
	WHERE v.dbname=BIViewDistinctValues.dbname and
	v.schemaname=BIViewDistinctValues.schemaname and
	v.viewname=BIViewDistinctValues.viewname and
	v.ColumnName=BIViewDistinctValues.ColumnName)

--mdr.LoadBIDiscinctValues 'OMNIA_EIOC_P_IOC_CM'



