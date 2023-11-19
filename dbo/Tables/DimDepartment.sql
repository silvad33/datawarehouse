CREATE TABLE [dbo].[DimDepartment] (
    [DepartmentKey] INT NOT NULL IDENTITY(1, 1)
    , [DepartmentNumber] NVARCHAR(30) NOT NULL
    , [DepartmentDescription] NVARCHAR(60) NOT NULL
    , [DepartmentNumberDescription] NVARCHAR(93) NOT NULL
    , [DepartmentDescriptionNumber] NVARCHAR(93) NOT NULL
    , [DepartmentIsActive] INT NULL
    , [AuditCreatedAt] DATETIME NULL
    , [AuditCreatedBy] VARCHAR(100) NULL
    , [AuditUpdatedAt] DATETIME NULL
    , [AuditUpdatedBy] VARCHAR(100) NULL
    )
GO

/* Create Primary Keys, Indexes, Uniques, Checks */
ALTER TABLE [dbo].[DimDepartment] ADD CONSTRAINT [PK_DimDepartment] PRIMARY KEY CLUSTERED ([DepartmentKey] ASC)
GO

CREATE NONCLUSTERED INDEX [IX_DimDepartment] ON [dbo].[DimDepartment] ([DepartmentNumber] ASC)
GO

CREATE NONCLUSTERED INDEX [IX1_DimDepartment] ON [dbo].[DimDepartment] ([DepartmentKey] ASC)
GO