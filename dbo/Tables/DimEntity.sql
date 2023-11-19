CREATE TABLE [dbo].[DimEntity] (
    [EntityKey] INT NOT NULL IDENTITY(1, 1)
    , [EntityID] NVARCHAR(4) NOT NULL
    , [EntityDescription] NVARCHAR(60) NULL
    , [EntityDescriptionID] NVARCHAR(67) NOT NULL
    , [EntityIDDescription] NVARCHAR(67) NOT NULL
    , [AuditCreatedAt] DATETIME NULL
    , [AuditCreatedBy] VARCHAR(100) NULL
    , [AuditUpdatedAt] DATETIME NULL
    , [AuditUpdatedBy] VARCHAR(100) NULL
    )
GO

/* Create Primary Keys, Indexes, Uniques, Checks */
ALTER TABLE [dbo].[DimEntity] ADD CONSTRAINT [PK_DimEntity] PRIMARY KEY CLUSTERED ([EntityKey] ASC)
GO

CREATE NONCLUSTERED INDEX [IX_DimEntity] ON [dbo].[DimEntity] ([EntityID] ASC)
GO