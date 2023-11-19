/*
Description: Track history of COVID-19 Form responses from Ionis employees
Change Log :

*/
CREATE TABLE [dbo].[CovidEmployeeResponse]
(
	[Id] INT NOT NULL PRIMARY KEY, 
    [FullName] VARCHAR(100) NOT NULL, 
    [Email] VARCHAR(100) NOT NULL, 
    [UserKey] INT NULL, -- set with value from DimUser table if matched on SharePoint email
    [Response] Varchar(200) NOT NULL, 
    [ResponseId] INT NULL DEFAULT 0,
    [CreatedDateTime] DATETIME NOT NULL
);

GO

CREATE NONCLUSTERED INDEX [IX_CovidEmployeeResponse_Created] 
 ON [dbo].[CovidEmployeeResponse] ([CreatedDateTime] ASC);
GO

CREATE NONCLUSTERED INDEX [IX_CovidEmployeeResponse_FullName] 
 ON [dbo].[CovidEmployeeResponse] ([FullName] ASC);
GO

