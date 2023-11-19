CREATE TABLE [dbo].[DimProject] (
    [ProjectKey] INT NOT NULL IDENTITY(1, 1)
    , [ProjectNumber] VARCHAR(10) NULL
    , [ProjectDescription] NVARCHAR(60) NULL
    , [ProjectNumberDescription] NVARCHAR(73) NOT NULL
    , [ProjectDescriptionNumber] NVARCHAR(73) NOT NULL
    , [Partition] VARCHAR(20) NULL
    , [DataAreaID] VARCHAR(4) NULL
    , [ProjectID] INT NULL
    , [ProjectIsActive] INT NULL
    , [AuditCreatedAt] DATETIME NULL
    , [AuditCreatedBy] VARCHAR(100) NULL
    , [AuditUpdatedAt] DATETIME NULL
    , [AuditUpdatedBy] VARCHAR(100) NULL
    )
GO

/* Create Primary Keys, Indexes, Uniques, Checks */
ALTER TABLE [dbo].[DimProject] ADD CONSTRAINT [PK_DimProject] PRIMARY KEY CLUSTERED ([ProjectKey] ASC)
GO

CREATE NONCLUSTERED INDEX [IX_DimProject] ON [dbo].[DimProject] (
    [ProjectNumber] ASC
    , [DataAreaID] ASC
    )
GO