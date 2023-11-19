CREATE TABLE [dbo].[DimAccount] (
    [AccountKey] INT NOT NULL IDENTITY(1, 1)
    , [MainAccountNumber] NVARCHAR(20) NOT NULL
    , [MainAccountDescription] NVARCHAR(60) NOT NULL
    , [MainAccountNumberDescription] NVARCHAR(83) NOT NULL
    , [MainAccountDescriptionNumber] NVARCHAR(83) NOT NULL
    , [MainAccountType] VARCHAR(15) NULL
    , [MainAccountCategoryDescription] NVARCHAR(60) NOT NULL
    , [level5] NVARCHAR(20) NULL
    , [level5Description] NVARCHAR(60) NULL
    , [level4] NVARCHAR(20) NULL
    , [level4Description] NVARCHAR(60) NULL
    , [level3] NVARCHAR(20) NULL
    , [level3Description] NVARCHAR(60) NULL
    , [Level2] NVARCHAR(20) NULL
    , [Level2Description] NVARCHAR(60) NULL
    , [Level1] NVARCHAR(20) NULL
    , [Level1Description] NVARCHAR(60) NULL
    , [IsGAAP] INT NULL
    , [IsControlled] INT NULL
    , [IsFTE] INT NULL
    , [PARTITION] NVARCHAR(20) NOT NULL
    , [IsActive] INT NULL
    , [AuditCreatedAt] DATETIME NULL
    , [AuditCreatedBy] VARCHAR(100) NULL
    , [AuditUpdatedAt] DATETIME NULL
    , [AuditUpdatedBy] VARCHAR(100) NULL
    )
GO

/* Create Primary Keys, Indexes, Uniques, Checks */
ALTER TABLE [dbo].[DimAccount] ADD CONSTRAINT [PK_DimAccount] PRIMARY KEY CLUSTERED ([AccountKey] ASC)
GO

CREATE NONCLUSTERED INDEX [IX1_DimAccount] ON [dbo].[DimAccount] ([MainAccountNumber] ASC)
GO