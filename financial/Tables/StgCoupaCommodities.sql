CREATE TABLE [financial].[StgCoupaCommodities] (
    Id INT NULL
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
    , CreatedById INT NULL
    , UpdatedById INT NULL
    )