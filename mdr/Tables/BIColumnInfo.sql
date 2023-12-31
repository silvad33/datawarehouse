﻿CREATE TABLE [mdr].[BIColumnInfo] (
    [ID]                 INT            IDENTITY (1, 1) NOT NULL,
    [DBName]             VARCHAR (50)   NOT NULL,
    [SchemaName]         VARCHAR (50)   NOT NULL,
    [TableName]          VARCHAR (500)  NOT NULL,
    [ColumnName]         VARCHAR (100)  NOT NULL,
    [ColOrder]           INT            NULL,
    [NewColumnName]      VARCHAR (100)  NULL,
    [DataType]           VARCHAR (50)   NULL,
    [ChangeDateFlag]     CHAR (1)       NULL,
    [Length]             INT            NULL,
    [Scale]              INT            NULL,
    [Precision]          INT            NULL,
    [Description]        VARCHAR (300)  NULL,
    [ETLNotes]           VARCHAR (8000) NULL,
    [DistinctValueCount] INT            NULL,
    [NullRowsCount]      INT            NULL,
    [NullPCT]            DECIMAL (5, 2) NULL,
    [PKSeq]              INT            NULL,
    [MaxVal]             VARCHAR (200)  NULL,
    [MinVal]             VARCHAR (200)  NULL,
    [KeySeq]             INT            NULL,
    [DestDataType]       VARCHAR (50)   NULL,
    [IncludeExclude]     CHAR (1)       NULL,
    [ColumnCount]        INT            NULL,
    [CommonColumnID]     VARCHAR (50)   NULL,
    [MaxDate]            DATE           NULL,
    [TableID]            INT            NULL,
    CONSTRAINT [PK_BIColumnInfo] PRIMARY KEY CLUSTERED ([ID] ASC)
);

