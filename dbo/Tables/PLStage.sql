CREATE TABLE [dbo].[PLStage] (
    [TotalingAccount]            NVARCHAR (20) NOT NULL,
    [TotalingAccountDescription] NVARCHAR (60) NULL,
    [MainAccount]                NVARCHAR (20) NOT NULL,
    [AccountKey]                 INT           NOT NULL,
    [DepartmentKey]              INT           NOT NULL,
    [DepartmentNumber]           NVARCHAR (30) NOT NULL
);

