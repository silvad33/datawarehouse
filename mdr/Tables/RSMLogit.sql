CREATE TABLE [mdr].[RSMLogit] (
    [RunTS]        DATETIME      CONSTRAINT [DF_RSMLogit_RunTS] DEFAULT (getdate()) NOT NULL,
    [RunProcess]   VARCHAR (100) NULL,
    [RunUser]      VARCHAR (100) NULL,
    [RunInt1]      INT           NULL,
    [RunIntName1]  VARCHAR (100) NULL,
    [RunInt2]      INT           NULL,
    [RunIntName2]  VARCHAR (100) NULL,
    [RunInt3]      INT           NULL,
    [RunIntName3]  VARCHAR (100) NULL,
    [RunChar1]     VARCHAR (100) NULL,
    [RunCharName1] VARCHAR (100) NULL,
    [RunChar2]     VARCHAR (100) NULL,
    [RunCharName2] VARCHAR (100) NULL,
    [RunChar3]     VARCHAR (100) NULL,
    [RunCharName3] VARCHAR (100) NULL,
    [RunDate1]     DATE          NULL,
    [RunDateName1] VARCHAR (100) NULL,
    [RunDate2]     DATE          NULL,
    [RunDateName2] VARCHAR (100) NULL,
    [RunDate3]     DATE          NULL,
    [RunDateName3] VARCHAR (100) NULL
);

