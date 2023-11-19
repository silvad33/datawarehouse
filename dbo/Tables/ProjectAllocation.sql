CREATE TABLE [dbo].[ProjectAllocation] (
    [StartDate]            DATE             NOT NULL,
    [EndDate]              DATE             NOT NULL,
    [Department]           INT              NOT NULL,
    [Project]              VARCHAR (50)     NULL,
    [DataAreaID]           NVARCHAR (50)    NOT NULL,
    [AllocationPercentage] DECIMAL (18, 10) NULL
);

