CREATE PROCEDURE [mdr].[sp_ResetDB] @dbName VARCHAR(500) AS
-- EXEC sp_ResetDB 'RogueWave'

INSERT INTO [mdr].[RSMLogit] ([RunProcess], RunCharName1, RunChar1) VALUES ('Start sp_ResetDB','DBName',@dbName)

DELETE FROM mdr.BITableInfo WHERE DBName=@dbName
DELETE FROM mdr.BIColumnInfo WHERE DBName=@dbName
DELETE FROM mdr.BIDistinctValues WHERE DBName=@dbName
DELETE FROM mdr.BIDependencies WHERE DBName=@dbName
DELETE FROM mdr.BIForeignKeyInfo WHERE DBName=@dbName

INSERT INTO [mdr].[RSMLogit] ([RunProcess], RunCharName1, RunChar1) VALUES ('End sp_ResetDB','DBName',@dbName)
