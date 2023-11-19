CREATE PROCEDURE [dbo].[BoomiSelectInClause]

/*
Creator: Daniel Silva
Create Date: 10/1/2020
Description: This procedure is to be used for Boomi process that need to execute an IN clause. 
*/
    @Fields NVARCHAR(256),
    @Table NVARCHAR(256),
    @Var varchar(256),--you may have to chunk your calls if your variable hits this length limit DSilva10/1/2020
    @Where NVARCHAR(256)
AS
BEGIN TRY
    Declare @sql as Nvarchar(4000);
    create table Temp_Table
    (
        ID varchar(256)
    );
    insert into Temp_Table
        (ID)
    values
        (@var);

    set @sql = 'SELECT ' + @Fields + ' FROM ' + @Table + ' WHERE ' + @Where + ' IN
(select value from Temp_Table cross apply string_split(ID, '',''))';
    exec sp_executesql @sql, N'';
    drop table Temp_Table;
END TRY
BEGIN CATCH
PRINT 'In catch block.';
THROW;
drop table Temp_Table;
END CATCH;
