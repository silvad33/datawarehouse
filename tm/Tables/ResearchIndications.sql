CREATE TABLE [TM].[ResearchIndications]
(
	[ResearchIndicationId] int NOT NULL IDENTITY (1, 1),
	[ResearchIndicationName] varchar(255) NOT NULL,
	[CreatedBy] varchar(100) NULL,
	[CreatedDate] datetime NULL,
	[LastModifiedBy] varchar(100) NULL,
	[IndicationID] int NULL,
	[LastModifiedDate] datetime NULL
)
GO

ALTER TABLE [TM].[ResearchIndications] 
 ADD CONSTRAINT [PK_ResearchIndications]
	PRIMARY KEY CLUSTERED ([ResearchIndicationId] ASC)
GO

ALTER TABLE [TM].[ResearchIndications] ADD CONSTRAINT [FK_ResearchIndication_Indication]
	FOREIGN KEY ([IndicationID]) REFERENCES [TM].[Indications] ([IndicationsID]) ON DELETE No Action ON UPDATE No Action
GO