CREATE TABLE [dbo].[CovidGuestResponse]
(
	[Id] INT NOT NULL PRIMARY KEY,
	[FullName] VARCHAR(100) NOT NULL, 
    [Email] VARCHAR(100) NOT NULL, 
    [Response] Varchar(200) NOT NULL, 
    [CreatedDateTime] DATETIME NOT NULL
);

GO


CREATE NONCLUSTERED INDEX [IX_CovidGuestResponse_Created] 
 ON [dbo].[CovidGuestResponse] ([CreatedDateTime] ASC);
GO

CREATE NONCLUSTERED INDEX [IX_CovidGuestResponse_FullName] 
 ON [dbo].[CovidGuestResponse] ([FullName] ASC);
GO






