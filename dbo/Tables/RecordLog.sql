CREATE TABLE [dbo].[RecordLog] (
    [RecID]       BIGINT          NULL,
    [SourceTable] VARCHAR (15)    NOT NULL,
    [Type]        VARCHAR (6)     NOT NULL,
    [AsOf]        NVARCHAR (4000) NULL
);

