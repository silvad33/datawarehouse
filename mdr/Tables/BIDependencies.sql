CREATE TABLE [mdr].[BIDependencies] (
    [DBname]               VARCHAR (50)   NOT NULL,
    [ObjectID]             BIGINT         NULL,
    [ObjectName]           [sysname]      NOT NULL,
    [ObjectType]           NVARCHAR (60)  NULL,
    [ReferencedObject]     [sysname]      NOT NULL,
    [ReferencedObjectType] NVARCHAR (60)  NULL,
    [ReferencedField]      NVARCHAR (128) NULL,
    [SelectAll]            BIT            NOT NULL,
    [Updated]              BIT            NOT NULL,
    [SelectSpecific]       BIT            NOT NULL
);

