CREATE TABLE [dbo].[BuildingAccessUser] (
    [RecordId]     INT           IDENTITY (1, 1) NOT NULL,
    [BadgeNumber]  VARCHAR (50)  NOT NULL,
    [FirstName]    VARCHAR (100) NOT NULL,
    [LastName]     VARCHAR (100) NULL,
    [Company]      VARCHAR (100) NULL,
    [Department]   VARCHAR (50)  NULL,
    [BadgeStatus]  VARCHAR (50)  NULL,
    [DimUserKey]   INT           NULL,
    [DateModified] DATETIME      CONSTRAINT [CS_BuildingAccessUserDateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_BuildingAccessUser_RecorId] PRIMARY KEY CLUSTERED ([RecordId] ASC) WITH (FILLFACTOR = 80)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IND_BuildingAccessUser_Name]
    ON [dbo].[BuildingAccessUser]([BadgeNumber] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [IX_BuildingAccessUser_DimUserKey]
    ON [dbo].[BuildingAccessUser]([DimUserKey] ASC) WITH (FILLFACTOR = 80);

