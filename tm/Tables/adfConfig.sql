CREATE TABLE [TM].[adfConfig](
	[SourceFileName] [varchar](100) NULL,
	[SourceDirectory] [varchar](100) NULL,
	[TargetSchema] [varchar](100) NULL,
	[TargetTable] [varchar](100) NULL,
	IsActive bit null, 
    [FranchiseName] VARCHAR(100) NULL, 
    [CurrentStatus] VARCHAR(100) NULL, 
    [ResearchMilestone] VARCHAR(100) NULL, 
    [SourceFile] VARCHAR(100) NULL, 
    [SourceExcelPath] VARCHAR(250) NULL
)