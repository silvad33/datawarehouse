CREATE TABLE [mdr].[BIViewInfo] (
    [ID]             INT            IDENTITY (1, 1) NOT NULL,
    [DBName]         VARCHAR (50)   NOT NULL,
    [SchemaName]     VARCHAR (50)   NOT NULL,
    [ViewName]       VARCHAR (100)  NOT NULL,
    [NewViewName]    VARCHAR (100)  NULL,
    [ViewType]       VARCHAR (50)   NULL,
    [ViewCategory]   VARCHAR (50)   NULL,
    [NumRows]        INT            NULL,
    [Description]    VARCHAR (300)  NULL,
    [ETLNotes]       VARCHAR (8000) NULL,
    [HasPK]          VARCHAR (3)    NULL,
    [IncludeExclude] CHAR (1)       NULL,
    [LoadMethod]     CHAR (10)      NULL,
    [ColCount]       INT            NULL,
    [PopColCount]    INT            NULL,
    [DependencyID]   BIGINT         NULL,
    CONSTRAINT [PK_BIViewInfo] PRIMARY KEY CLUSTERED ([DBName] ASC, [SchemaName] ASC, [ViewName] ASC)
);

