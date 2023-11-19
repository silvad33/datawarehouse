CREATE TABLE [TM].[ResearchProjectResearchIndications]
(
	[ResearchProjectId] int NOT NULL,
	[ResearchIndicationId] int NOT NULL
)
GO

ALTER TABLE [TM].[ResearchProjectResearchIndications] ADD CONSTRAINT [FK_ResearchProjectResearchIndication_ResearchIndication]
	FOREIGN KEY ([ResearchIndicationId]) REFERENCES [TM].[ResearchIndications] ([ResearchIndicationId]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [TM].[ResearchProjectResearchIndications] ADD CONSTRAINT [FK_ResearchProjectResearchIndication_ResearchProject]
	FOREIGN KEY ([ResearchProjectId]) REFERENCES [TM].[ResearchProject] ([ResearchProjectId]) ON DELETE No Action ON UPDATE No Action
GO