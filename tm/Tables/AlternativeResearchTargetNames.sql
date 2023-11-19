CREATE TABLE [TM].[AlternativeResearchTargetNames]
(
	[AlternativeTargetName] varchar(100) NULL,
	[AlternativeResearchTargetNameId] int NOT NULL IDENTITY(1,1),
	[IonisResearchTargetId] int NOT NULL
)
GO

ALTER TABLE [TM].[AlternativeResearchTargetNames] 
 ADD CONSTRAINT [PK_AlternativeResearchTargetNames]
	PRIMARY KEY CLUSTERED ([AlternativeResearchTargetNameId] ASC)
GO

ALTER TABLE [TM].[AlternativeResearchTargetNames] ADD CONSTRAINT [FK_AlternativeResearchTargetNames_IonisResearchTarget]
	FOREIGN KEY ([IonisResearchTargetId]) REFERENCES [TM].[IonisResearchTargets] ([IonisResearchTargetId]) ON DELETE No Action ON UPDATE No Action
GO