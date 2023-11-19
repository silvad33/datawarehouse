CREATE TABLE [dbo].[JobHistory]
(
    EndTime DATETIME,
    ErrorCode VARCHAR(MAX),
    JobHistoryId INT,
    JobName VARCHAR(MAX),
    MaxUpdateDate DATETIME,
    MaxId INT,
    MinUpdateDate DATETIME,
    MinId INT,
    StartTime DATETIME,
    JobStatus VARCHAR(MAX),
    JobRowCount INT, 
    [CreatedBy] NVARCHAR(120) NULL, 
    [ErrorNumber] NVARCHAR(256) NULL, 
    [ErrorSeverity] NVARCHAR(256) NULL, 
    [ErrorState] NVARCHAR(256) NULL, 
    [ErrorProcedure] NVARCHAR(256) NULL, 
    [ErrorLine] NVARCHAR(256) NULL, 
    [ErrorMessage] NVARCHAR(256) NULL
)
