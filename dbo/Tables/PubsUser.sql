CREATE TABLE [dbo].[PubsUser] (
    [PubsUserId]   INT           NOT NULL,
    [Email]        VARCHAR (80)  NOT NULL,
    [FullName]     VARCHAR (100) NULL,
    [FirstName]    VARCHAR (50)  NULL,
    [LastName]     VARCHAR (50)  NULL,
    [DateCreated]  DATETIME      CONSTRAINT [CS_PubsUser_DateCreated] DEFAULT (getdate()) NOT NULL,
    [DateModified] DATETIME      NULL,
    CONSTRAINT [PK_PubsUserId] PRIMARY KEY CLUSTERED ([PubsUserId] ASC) WITH (FILLFACTOR = 80)
);

