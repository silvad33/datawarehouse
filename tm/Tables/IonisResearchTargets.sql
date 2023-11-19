CREATE TABLE [TM].[IonisResearchTargets]
(
	[IonisResearchTargetId] int NOT NULL IDENTITY (1, 1),
	[IonisTargetName] varchar(100) NOT NULL,
	[GeneTarget] varchar(100) NULL,
	[ResearchProjectId] int NULL,
	[CreatedBy] varchar(100) NULL,
	[CreatedDate] datetime NULL,
	[LastModifiedBy] varchar(100) NULL,
	[LastModifiedDate] datetime NULL
)
GO

ALTER TABLE [TM].[IonisResearchTargets] 
 ADD CONSTRAINT [PK__IonisRes__57669C424843FA2F]
	PRIMARY KEY CLUSTERED ([IonisResearchTargetId] ASC)
GO

ALTER TABLE [TM].[IonisResearchTargets] 
 ADD CONSTRAINT [UQ__IonisRes__F2290365D22144B5] UNIQUE NONCLUSTERED ([ResearchProjectId] ASC)
GO

ALTER TABLE [TM].[IonisResearchTargets] ADD CONSTRAINT [FK__IonisRese__Resea__2F1BB8CA]
	FOREIGN KEY ([ResearchProjectId]) REFERENCES [TM].[ResearchProject] ([ResearchProjectId]) ON DELETE No Action ON UPDATE No Action
GO