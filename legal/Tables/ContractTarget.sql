CREATE TABLE [legal].[ContractTarget]
(
	[IsEncumbred] bit NULL,
	[MTID] varchar(200) NULL,
	[ContractTargetID] int NOT NULL IDENTITY(1,1),
	[LegalContractsID] int NULL,
    CONSTRAINT [PK_ContractTarget] PRIMARY KEY CLUSTERED ([ContractTargetID] ASC)
)