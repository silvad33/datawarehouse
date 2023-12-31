﻿CREATE TABLE [dbo].[DimHierarchy] (
    [HierarchyDepth]                     INT            NULL,
    [HierarchyType]                      VARCHAR (50)   NULL,
    [RootPartyNumber]                    VARCHAR (50)   NULL,
    [RootPartyNumberNameAlias]           NVARCHAR (20)  NULL,
    [RootPartyOriganizationName]         NVARCHAR (100) NULL,
    [LeafPartyNumber]                    VARCHAR (50)   NULL,
    [LeafPartyNumberNameAlias]           NVARCHAR (20)  NULL,
    [LeafPartyNumberOriganizationName]   NVARCHAR (100) NULL,
    [LeafOperatingUnit]                  VARCHAR (50)   NULL,
    [Level1PartyNumber]                  VARCHAR (50)   NULL,
    [Level1PartyNumberNameAlias]         NVARCHAR (20)  NULL,
    [Level1PartyNumberOriganizationName] NVARCHAR (100) NULL,
    [Level2PartyNumber]                  VARCHAR (50)   NULL,
    [Level2PartyNumberNameAlias]         NVARCHAR (20)  NULL,
    [Level2PartyNumberOriganizationName] NVARCHAR (100) NULL,
    [Level3PartyNumber]                  VARCHAR (50)   NULL,
    [Level3PartyNumberNameAlias]         NVARCHAR (20)  NULL,
    [Level3PartyNumberOriganizationName] NVARCHAR (100) NULL,
    [Level4PartyNumber]                  VARCHAR (50)   NULL,
    [Level4PartyNumberNameAlias]         NVARCHAR (20)  NULL,
    [Level4PartyNumberOriganizationName] NVARCHAR (100) NULL,
    [DepartmentKey]                      BIGINT         NOT NULL
);

