/****** Object:  Table [clinical].[KPIConfig]    Script Date: 4/29/2021 7:10:52 AM ******/
CREATE TABLE [clinical_mart].[KPIConfig](
	[Level] [varchar](50) NOT NULL,
	[LevelValue] [varchar](50) NOT NULL,
	[KPIName] [varchar](50) NOT NULL,
	[KPIThreshold1] [numeric](18, 2) NULL,
	[KPIThreshold2] [numeric](18, 2) NULL,
	[KPIThreshold3] [numeric](18, 2) NULL,
	[KPIThreshold4] [numeric](18, 2) NULL,
	[KPIThreshold5] [numeric](18, 2) NULL,
	[LevelKPIWeight] [numeric](18, 2) NULL,
	[LevelKPILag] [numeric](18, 2) NULL
) ON [PRIMARY]
GO
/****** Object:  Index [uix_KPIConfig]    Script Date: 4/29/2021 7:10:52 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [uix_KPIConfig] ON [clinical_mart].[KPIConfig]
(
	[Level] ASC,
	[LevelValue] ASC,
	[KPIName] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
GO
