CREATE TABLE [mdr].[BIForeignKeyInfo] (
    [DBName]           VARCHAR (500) NOT NULL,
    [SchemaName]       VARCHAR (500) NULL,
    [name]             VARCHAR (500) NOT NULL,
    [childtable]       VARCHAR (500) NOT NULL,
    [childcolumnname]  VARCHAR (500) NULL,
    [parenttable]      VARCHAR (500) NOT NULL,
    [parentcolumnname] VARCHAR (500) NULL
);

