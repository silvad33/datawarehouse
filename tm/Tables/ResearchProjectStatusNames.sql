CREATE TABLE [TM].[ResearchProjectStatusNames]
(
	[ResearchProjectStatusNameId] int NOT NULL IDENTITY (1, 1),
	[ResearchProjectStatusName] varchar(100) NOT NULL,
	[CreatedBy] varchar(100) NULL,
	[CreatedDate] datetime NULL,
	[LastModifiedBy] varchar(100) NULL,
	[LastModifiedDate] datetime NULL
)
GO

ALTER TABLE [TM].[ResearchProjectStatusNames] 
 ADD CONSTRAINT [PK__Status__C8EE2063A590FFE4]
	PRIMARY KEY CLUSTERED ([ResearchProjectStatusNameId] ASC)
GO