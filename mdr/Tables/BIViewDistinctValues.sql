CREATE TABLE [mdr].[BIViewDistinctValues] (
    [ID]           INT           IDENTITY (1, 1) NOT NULL,
    [DBName]       VARCHAR (50)  NULL,
    [SchemaName]   VARCHAR (50)  NULL,
    [ViewName]     VARCHAR (500) NULL,
    [ColumnName]   VARCHAR (100) NULL,
    [ColValue]     VARCHAR (200) NULL,
    [ViewColumnID] NCHAR (10)    NULL,
    [ValueCount]   INT           NULL
);

