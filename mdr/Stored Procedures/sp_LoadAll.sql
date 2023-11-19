CREATE Procedure [mdr].[sp_LoadAll] @dbname varchar(100), @dvcount int 
as

INSERT INTO [mdr].[RSMLogit] ([RunProcess], RunCharName1, RunChar1) VALUES ('Start sp_LoadAll','DBName',@dbName)

--exec mdr.sp_LoadAll 'IonisDW',20000
--exec mdr.emptydb
--exec mdr.sp_ResetDB 'IonisDW'

EXEC mdr.sp_LoadTableInfo @dbname

EXEC mdr.sp_BuildColumnInfo @dbname

EXEC mdr.sp_LoadBIColumnInfo @dbname

EXEC mdr.sp_LoadBIDiscinctValues @dbname,@dvcount

EXEC mdr.sp_LoadForeignKeyInfo @dbname

EXEC mdr.sp_BIDependencies @dbname

EXEC mdr.sp_LoadViewInfo @dbname

EXEC [mdr].[sp_BuildViewColumnInfo] @dbname

EXEC [mdr].[sp_LoadBIViewColumnInfo] @dbname

EXEC [mdr].[LoadBIViewDiscinctValues] @dbname,@dvcount

INSERT INTO [mdr].[RSMLogit] ([RunProcess], RunCharName1, RunChar1) VALUES ('End sp_LoadAll','DBName',@dbName)











