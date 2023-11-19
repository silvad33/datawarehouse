CREATE TABLE [dbo].[tblLocalMeritCalc] (
    [ID]          INT            NOT NULL,
    [Sal]         NVARCHAR (100) NOT NULL,
    [HourlyRate]  NVARCHAR (100) NULL,
    [DateCreated] DATETIME CONSTRAINT [DF_tblLocalMeritCalc_DateCreated] DEFAULT (getdate()) NULL, CONSTRAINT [PK_tblLocalMeritCalc] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 80),
    [LocalCurrency] [varchar](50) NULL
);

