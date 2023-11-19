CREATE TABLE [mdr].[BIDistinctValues] (
    [ID]         INT           IDENTITY (1, 1) NOT NULL,
    [DBName]     VARCHAR (50)  NULL,
    [SchemaName] VARCHAR (50)  NULL,
    [TableName]  VARCHAR (100) NULL,
    [ColumnName] VARCHAR (100) NULL,
    [ColValue]   VARCHAR (200) NULL,
    [ValueCount] INT           NULL,
    [ColumnID]   INT           NULL
);

