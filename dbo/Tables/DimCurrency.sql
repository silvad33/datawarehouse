CREATE TABLE [dbo].[DimCurrency](
	[CurrencyKey] [int] IDENTITY(1,1) NOT NULL,
	[CoupaId] [nvarchar](20) NOT NULL,
	[Code] [nvarchar](10) NOT NULL,
	[Decimals] [int] NOT NULL,
	[UpdatedByUserKey] [nvarchar](83) NULL,
	[AuditCreatedAt] DATETIME NULL,
    [AuditCreatedBy] VARCHAR(100) NULL,
    [AuditUpdatedAt] DATETIME NULL,
    [AuditUpdatedBy] VARCHAR(100) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DimCurrency] ADD  CONSTRAINT [PK_DimCurrency] PRIMARY KEY CLUSTERED 
(
	[CurrencyKey] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX1_DimAccount] ON [dbo].[DimCurrency]
(
	[CoupaId] ASC
)
GO
