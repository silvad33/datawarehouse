CREATE TABLE [research].[MTIDGenes](
	[MTID] [varchar](50) NOT NULL,
	[EnsemblID] [varchar](50) NOT NULL,
	[DateModified] [datetime] NULL,
	[DateCreated] [datetime] NULL,
	[MTIDGenesID] int NOT NULL IDENTITY (1, 1)
) ON [PRIMARY]
GO
ALTER TABLE [research].[MTIDGenes] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [research].[MTIDGenes] 
 ADD CONSTRAINT [PK_MTIDGenes]
	PRIMARY KEY CLUSTERED ([MTIDGenesID] ASC)
GO
