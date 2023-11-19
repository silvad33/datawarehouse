CREATE TABLE [dbo].[POLineAllocation] (
    [PO_Line_ID]        INT          NOT NULL,
    [DepartmentKey]     INT          NULL,
    [AccountKey]        INT          NULL,
    [ProjectKey]        INT          NULL,
    [TaskKey]           INT          NULL,
    [AllocationPercent] FLOAT (53)   NULL,
    [Amount]            FLOAT (53)   NULL,
    [PO_Number]         VARCHAR (25) NULL
);

