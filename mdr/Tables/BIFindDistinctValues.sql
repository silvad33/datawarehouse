CREATE TABLE [mdr].[BIFindDistinctValues] (
    [ID]         INT           IDENTITY (1, 1) NOT NULL,
    [DBName]     VARCHAR (50)  NULL,
    [SchemaName] VARCHAR (50)  NULL,
    [TableName]  VARCHAR (50)  NULL,
    [ColumnName] VARCHAR (50)  NULL,
    [ColValue]   VARCHAR (200) NULL
);

