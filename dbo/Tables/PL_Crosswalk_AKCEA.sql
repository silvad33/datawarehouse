CREATE TABLE [dbo].[PL_Crosswalk_AKCEA] (
    [TotalingAccount]            NVARCHAR (20) NOT NULL,
    [TotalingAccountDescription] NVARCHAR (60) NULL,
    [mainAccount]                NVARCHAR (20) NOT NULL,
    [AccountKey]                 INT           NOT NULL,
    [DepartmentKey]              INT           NOT NULL,
    [DepartmentNumber]           NVARCHAR (30) NOT NULL,
    [PLType]                     VARCHAR (17)  NOT NULL,
    [PLGroup]                    NVARCHAR (60) NULL,
    [PLOrder]                    INT           NULL,
    [Factor]                     INT           NULL
);

