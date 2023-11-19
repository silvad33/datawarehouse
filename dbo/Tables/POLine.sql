CREATE TABLE [dbo].[POLine] (
    [ID]                  INT           NOT NULL,
    [Created_By]          VARCHAR (100) NULL,
    [Created_At]          DATETIME      NULL,
    [Updated_By]          VARCHAR (100) NULL,
    [Updated_At]          DATETIME      NULL,
    [Accounting_Total]    FLOAT (53)    NULL,
    [Accounting_Currency] CHAR (3)      NULL,
    [Description]         VARCHAR (500) NULL,
    [Invoiced_Quantity]   FLOAT (53)    NULL,
    [PO_Line_Number]      INT           NOT NULL,
    [PO_ID]               INT           NOT NULL,
    [PO_Number]           VARCHAR (25)  NULL,
    [Price]               FLOAT (53)    NULL,
    [Received_Quantity]   FLOAT (53)    NULL,
    [Source_Part_Number]  VARCHAR (500) NULL,
    [Status]              VARCHAR (50)  NULL,
    [Total]               FLOAT (53)    NULL,
    [Reporting_Total]     FLOAT (53)    NULL,
    [PoLineStartDate]     DATETIME      NULL,
    [PoLineEndDate]       DATETIME      NULL
);

