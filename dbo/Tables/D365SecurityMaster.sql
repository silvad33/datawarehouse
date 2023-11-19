CREATE TABLE [dbo].[D365SecurityMaster] (
    [SecurityMasterID] INT           IDENTITY (1, 1) NOT NULL,
    [DepartmentNumber] NVARCHAR (30) NOT NULL,
    [DepartmentKey]    INT           NOT NULL,
    [EntityID]         NVARCHAR (4)  NOT NULL,
    [EntityKey]        INT           NOT NULL,
    CONSTRAINT [PK_D365SecurityMaster] PRIMARY KEY CLUSTERED ([SecurityMasterID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_D365SecurityMaster]
    ON [dbo].[D365SecurityMaster]([EntityKey] ASC, [DepartmentKey] ASC);

