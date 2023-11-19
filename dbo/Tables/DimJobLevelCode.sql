CREATE TABLE [dbo].[DimJobLevelCode] (
    [JobLevelCodeDimKey] INT             NOT NULL,
    [JobLevelCode]       VARCHAR (10)    NOT NULL,
    [ApprovalLevel]      VARCHAR (3)     NULL,
    [Expenses]           DECIMAL (38, 2) DEFAULT ((0.00)) NULL,
    [Agreements]         DECIMAL (38, 2) DEFAULT ((0.00)) NULL,
    [Entity]             VARCHAR (5)     NOT NULL,
    [CreatedBy]          VARCHAR (50)    NULL,
    [CreatedDate]        DATE            NULL,
    [UpdatedBy]          VARCHAR (50)    NULL,
    [UpdatedDate]        DATE            NULL
);

