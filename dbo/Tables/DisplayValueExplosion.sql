CREATE TABLE [dbo].[DisplayValueExplosion] (
    [DisplayValue] VARCHAR (100) NULL,
    [MainAccount]  VARCHAR (10)  NULL,
    [Department]   VARCHAR (10)  NULL,
    [Project]      VARCHAR (10)  NULL,
    [Task]         VARCHAR (10)  NULL,
    [Partition]    VARCHAR (20)  NULL,
    [DataAreaID]   VARCHAR (4)   NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_DisplayValueExplosion]
    ON [dbo].[DisplayValueExplosion]([DisplayValue] ASC, [DataAreaID] ASC, [Partition] ASC);

