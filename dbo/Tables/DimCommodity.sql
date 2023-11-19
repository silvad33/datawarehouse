CREATE TABLE [dbo].[DimCommodity] (
    [DimCommodityKey] [int] IDENTITY(1, 1) NOT NULL
    , CoupaCommodityId INT NULL
    , CreatedAt DATETIME NULL
    , UpdatedAt DATETIME NULL
    , Active VARCHAR(5) NULL
    , Name VARCHAR(250) NULL
    , TranslatedName VARCHAR(250) NULL
    , Deductibility VARCHAR(250) NULL
    , Category VARCHAR(250) NULL
    , SubCategory VARCHAR(250) NULL
    , Account VARCHAR(250) NULL
    , Taxable VARCHAR(250) NULL
    , Project VARCHAR(250) NULL
    , Study VARCHAR(250) NULL
    , CreatedByCoupaId INT NULL
    , UpdatedByCoupaId INT NULL
    , [AuditCreatedAt] DATETIME NULL
    , [AuditCreatedBy] VARCHAR(100) NULL
    , [AuditUpdatedAt] DATETIME NULL
    , [AuditUpdatedBy] VARCHAR(100) NULL
    ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[DimCommodity] ADD CONSTRAINT [PK_DimCommodity] PRIMARY KEY CLUSTERED ([DimCommodityKey] ASC)
GO

CREATE NONCLUSTERED INDEX [IX1_DimCommodity] ON [dbo].[DimCommodity] ([CoupaCommodityId] ASC)
GO