CREATE TABLE [TM].[StgNeuroTargetValidation]( 
	[Target] [varchar](255) NULL,
	[Indication] [varchar](255) NULL,
	[RU] [varchar](255) NULL,
	[HIT Status] [varchar](255) NULL,
	[6 month notice sent] [varchar](255) NULL,
	[Earliest TS Date] [varchar](255) NULL,
	[RMC Date (next 6 months)] [varchar](255) NULL,
	[TS Prob] [varchar](255) NULL,
	[Milestone] [varchar](255) NULL,
	[BIIB Prob] [varchar](255) NULL,
	[Ionis / BIIB Lead] [varchar](255) NULL,
	[Status / Key gating experiments] [varchar](Max) NULL,
	[Sort] [varchar](255)  NULL,
	[Last date confirmed/PI] [varchar](255) NULL,
	LoadDate datetime
)