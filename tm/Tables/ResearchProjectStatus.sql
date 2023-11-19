CREATE TABLE [TM].[ResearchProjectStatus]
(
	[ResearchProjectStatusId] int NOT NULL IDENTITY (1, 1),
	[ResearchProjectStatusNameId] int NOT NULL,
	[ResearchProjectId] int NULL,
	[StartDate] datetime NOT NULL,
	[EndDate] datetime NOT NULL,
	[IsCurrent] bit NOT NULL,
	[CreatedBy] varchar(100) NULL,
	[CreatedDate] datetime NULL,
	[LastModifiedBy] varchar(100) NULL,
	[LastModifiedDate] datetime NULL
)
GO

ALTER TABLE [TM].[ResearchProjectStatus] 
 ADD CONSTRAINT [PK__Research__6017F80B58B83D61]
	PRIMARY KEY CLUSTERED ([ResearchProjectStatusId] ASC)
GO

ALTER TABLE [TM].[ResearchProjectStatus] ADD CONSTRAINT [FK__ResearchP__Resea__23AA061E]
	FOREIGN KEY ([ResearchProjectId]) REFERENCES [TM].[ResearchProject] ([ResearchProjectId]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [TM].[ResearchProjectStatus] ADD CONSTRAINT [FK__ResearchP__Statu__22B5E1E5]
	FOREIGN KEY ([ResearchProjectStatusNameId]) REFERENCES [TM].[ResearchProjectStatusNames] ([ResearchProjectStatusNameId]) ON DELETE No Action ON UPDATE No Action
GO