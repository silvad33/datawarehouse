﻿CREATE TABLE [dbo].[DimUser_BadUsersBackup_08282020] (
    [UserKey]           INT            IDENTITY (1, 1) NOT NULL,
    [UserName]          VARCHAR (100)  NULL,
    [CoupaUserID]       INT            NULL,
    [EmployeeNumber]    VARCHAR (50)   NULL,
    [Email]             VARCHAR (100)  NULL,
    [ManagerKey]        INT            NULL,
    [DepartmentKey]     INT            NULL,
    [FirstName]         VARCHAR (100)  NULL,
    [LastName]          VARCHAR (100)  NULL,
    [FullName]          VARCHAR (200)  NULL,
    [StockLevelCode]    VARCHAR (15)   NULL,
    [UserType]          VARCHAR (20)   NULL,
    [Active]            BIT            NULL,
    [CompanyCode]       VARCHAR (10)   NULL,
    [DateInserted]      DATETIME       NULL,
    [DateModified]      DATETIME       NULL,
    [PubsUserId]        INT            NULL,
    [Notes]             VARCHAR (100)  NULL,
    [FTE]               DECIMAL (5, 2) NULL,
    [JobTitle]          VARCHAR (100)  NULL,
    [TerminationDate]   DATETIME       NULL,
    [OriginalHireDate]  DATETIME       NULL,
    [LatestHireDate]    DATETIME       NULL,
    [FirstNameFormal]   VARCHAR (30)   NULL,
    [ExemptStatus]      VARCHAR (15)   NULL,
    [WorkplaceLocation] VARCHAR (15)   NULL,
    [WorkplaceName]     VARCHAR (80)   NULL,
    [EmployeeId]        VARCHAR (20)   NULL,
    [EmailUltiPro]      VARCHAR (100)  NULL,
    [WorkPhone]         VARCHAR (50)   NULL,
    [CellPhone]         VARCHAR (50)   NULL
);

