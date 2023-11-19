CREATE TABLE [mdr].[BITableInfo] (
    [ID]                      INT            IDENTITY (1, 1) NOT NULL,
    [DBName]                  VARCHAR (50)   NOT NULL,
    [SchemaName]              VARCHAR (50)   NOT NULL,
    [TableName]               VARCHAR (500)  NOT NULL,
    [NewTableName]            VARCHAR (500)  NULL,
    [TableType]               VARCHAR (50)   NULL,
    [TableCategory]           VARCHAR (50)   CONSTRAINT [DF__BITableIn__Table__0EA330E9] DEFAULT ('RAW') NULL,
    [NumRows]                 INT            NULL,
    [Description]             VARCHAR (300)  NULL,
    [ETLNotes]                VARCHAR (8000) NULL,
    [HasPK]                   VARCHAR (3)    NULL,
    [IncludeExclude]          CHAR (1)       CONSTRAINT [DF_BITableInfo_IncludeExclude] DEFAULT ('I') NULL,
    [LoadMethod]              CHAR (10)      NULL,
    [ColCount]                INT            NULL,
    [PopColCount]             INT            NULL,
    [ParentInConstraintCount] INT            NULL,
    [ChildInConstraintCount]  INT            NULL,
    [MaxDate]                 DATE           NULL,
    [NumberOfDependencies]    INT            NULL,
    CONSTRAINT [PK_BITableInfo] PRIMARY KEY CLUSTERED ([ID] ASC)
);

