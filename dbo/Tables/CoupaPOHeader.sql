CREATE TABLE [dbo].[CoupaPOHeader] (
    [ID]               INT           NULL,
    [PO_Number]        VARCHAR (20)  NULL,
    [Supplier]         VARCHAR (100) NULL,
    [Exported]         BIT           NULL,
    [Last_Exported_At] DATETIME      NULL,
    [Status]           VARCHAR (50)  NULL,
    [Created_At]       DATETIME      NULL,
    [Updated_At]       DATETIME      NULL,
    [Refreshed_At]     DATETIME      NULL,
    [Version]          INT           NULL,
    [CapitalID]        VARCHAR (50)  NULL,
    [CapitalItem]      VARCHAR (500) NULL
);

