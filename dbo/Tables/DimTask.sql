CREATE TABLE [dbo].[DimTask] (
    [TaskKey] INT NOT NULL IDENTITY(1, 1)
    , [TaskNumber] VARCHAR(10) NULL
    , [TaskDescription] NVARCHAR(60) NULL
    , [TaskNumberDescription] NVARCHAR(73) NOT NULL
    , [TaskDescriptionNumber] NVARCHAR(73) NOT NULL
    , [Partition] VARCHAR(20) NULL
    , [DataAreaID] VARCHAR(4) NULL
    , [AuditCreatedAt] DATETIME NULL
    , [AuditCreatedBy] VARCHAR(100) NULL
    , [AuditUpdatedAt] DATETIME NULL
    , [AuditUpdatedBy] VARCHAR(100) NULL
    )
GO

/* Create Primary Keys, Indexes, Uniques, Checks */
ALTER TABLE [dbo].[DimTask] ADD CONSTRAINT [PK_DimTask] PRIMARY KEY CLUSTERED ([TaskKey] ASC)
GO

CREATE NONCLUSTERED INDEX [IX_DimTask] ON [dbo].[DimTask] (
    [TaskNumber] ASC
    , [DataAreaID] ASC
    )
GO